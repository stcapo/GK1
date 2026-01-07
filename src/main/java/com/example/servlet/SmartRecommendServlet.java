package com.example.servlet;

import com.example.util.DBUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.sql.*;
import java.util.*;

/**
 * Smart Recommendation API - provides intelligent 冲稳保 analysis
 */
@WebServlet("/api/recommend")
public class SmartRecommendServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        PrintWriter out = response.getWriter();
        
        // Get parameters
        String scoreStr = request.getParameter("score");
        String rankStr = request.getParameter("rank");
        String province = request.getParameter("province");
        String batch = request.getParameter("batch");
        String mode = request.getParameter("mode"); // university or major
        
        if (scoreStr == null || scoreStr.isEmpty()) {
            out.print("{\"success\":false,\"message\":\"Score is required\"}");
            return;
        }
        
        int score;
        try {
            score = Integer.parseInt(scoreStr);
        } catch (NumberFormatException e) {
            out.print("{\"success\":false,\"message\":\"Invalid score\"}");
            return;
        }
        
        try {
            JSONObject result = getRecommendations(score, province, batch);
            out.print(result.toJSONString());
        } catch (SQLException e) {
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"Database error: " + e.getMessage() + "\"}");
        }
    }
    
    private JSONObject getRecommendations(int score, String province, String batch) throws SQLException {
        JSONObject result = new JSONObject();
        result.put("success", true);
        result.put("userScore", score);
        
        // 冲: score+5 to score+30 (can reach but challenging)
        JSONArray impact = getUniversitiesByStrategy(score + 5, score + 30, province, batch, "冲");
        result.put("impact", impact);
        result.put("impactCount", impact.size());
        
        // 稳: score-15 to score+5 (good chance)
        JSONArray safe = getUniversitiesByStrategy(score - 15, score + 5, province, batch, "稳");
        result.put("safe", safe);
        result.put("safeCount", safe.size());
        
        // 保: score-40 to score-15 (very safe)
        JSONArray backup = getUniversitiesByStrategy(score - 40, score - 15, province, batch, "保");
        result.put("backup", backup);
        result.put("backupCount", backup.size());
        
        // Combined data for frontend
        JSONArray allData = new JSONArray();
        allData.addAll(impact);
        allData.addAll(safe);
        allData.addAll(backup);
        result.put("data", allData);
        
        return result;
    }
    
    private JSONArray getUniversitiesByStrategy(int minScore, int maxScore, String province, String batch, String strategy) throws SQLException {
        JSONArray result = new JSONArray();
        
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT DISTINCT u.id, u.name, u.code, u.province, u.city, u.type, ");
        sql.append("u.is_985, u.is_211, u.is_double_first, ");
        sql.append("ad.min_score, ad.min_rank, ad.batch ");
        sql.append("FROM universities u ");
        sql.append("JOIN admission_data ad ON u.id = ad.university_id ");
        sql.append("WHERE ad.year >= 2022 ");
        sql.append("AND ad.min_score BETWEEN ? AND ? ");
        
        List<Object> params = new ArrayList<>();
        params.add(minScore);
        params.add(maxScore);
        
        if (province != null && !province.isEmpty()) {
            sql.append("AND ad.province = ? ");
            params.add(province);
        }
        
        if (batch != null && !batch.isEmpty()) {
            sql.append("AND ad.batch LIKE ? ");
            params.add("%" + batch + "%");
        }
        
        sql.append("ORDER BY ad.min_score DESC ");
        sql.append("LIMIT 30");
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                pstmt.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = pstmt.executeQuery();
            Set<Integer> seenIds = new HashSet<>();
            
            while (rs.next()) {
                int uniId = rs.getInt("id");
                if (seenIds.contains(uniId)) continue;
                seenIds.add(uniId);
                
                JSONObject uni = new JSONObject();
                uni.put("id", uniId);
                uni.put("name", rs.getString("name"));
                uni.put("code", rs.getString("code"));
                uni.put("province", rs.getString("province"));
                uni.put("city", rs.getString("city"));
                uni.put("type", rs.getString("type"));
                uni.put("is985", rs.getInt("is_985") == 1);
                uni.put("is211", rs.getInt("is_211") == 1);
                uni.put("isDoubleFirst", rs.getInt("is_double_first") == 1);
                uni.put("minScore", rs.getInt("min_score"));
                uni.put("minRank", rs.getObject("min_rank"));
                uni.put("batch", rs.getString("batch"));
                uni.put("strategy", strategy);
                
                // Build tags
                JSONArray tags = new JSONArray();
                if (rs.getInt("is_985") == 1) {
                    JSONObject tag = new JSONObject();
                    tag.put("label", "985");
                    tag.put("class", "double-first");
                    tags.add(tag);
                }
                if (rs.getInt("is_211") == 1) {
                    JSONObject tag = new JSONObject();
                    tag.put("label", "211");
                    tag.put("class", "project-211");
                    tags.add(tag);
                }
                if (rs.getInt("is_double_first") == 1) {
                    JSONObject tag = new JSONObject();
                    tag.put("label", "双一流");
                    tag.put("class", "double-first");
                    tags.add(tag);
                }
                uni.put("tags", tags);
                
                result.add(uni);
            }
        }
        
        return result;
    }
}
