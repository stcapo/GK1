package com.example.servlet;

import com.example.util.DBUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.sql.*;

/**
 * Strategy Analysis API - provides 冲稳保 counts for main page display
 */
@WebServlet("/api/analysis/strategy")
public class StrategyAnalysisServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        
        PrintWriter out = response.getWriter();
        
        String scoreStr = request.getParameter("score");
        String province = request.getParameter("province");
        
        if (scoreStr == null || scoreStr.isEmpty()) {
            // Try to get from session
            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("userScore") != null) {
                scoreStr = session.getAttribute("userScore").toString();
                province = (String) session.getAttribute("userProvince");
            }
        }
        
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
            JSONObject result = getStrategyCounts(score, province);
            out.print(result.toJSONString());
        } catch (SQLException e) {
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"Database error\"}");
        }
    }
    
    private JSONObject getStrategyCounts(int score, String province) throws SQLException {
        JSONObject result = new JSONObject();
        result.put("success", true);
        result.put("userScore", score);
        
        // Count universities in each strategy range
        int impactCount = countUniversitiesInRange(score + 5, score + 30, province);
        int safeCount = countUniversitiesInRange(score - 15, score + 5, province);
        int backupCount = countUniversitiesInRange(score - 40, score - 15, province);
        
        result.put("impactCount", impactCount);
        result.put("safeCount", safeCount);
        result.put("backupCount", backupCount);
        
        return result;
    }
    
    private int countUniversitiesInRange(int minScore, int maxScore, String province) throws SQLException {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(DISTINCT u.id) as cnt ");
        sql.append("FROM universities u ");
        sql.append("JOIN admission_data ad ON u.id = ad.university_id ");
        sql.append("WHERE ad.year >= 2022 ");
        sql.append("AND ad.min_score BETWEEN ? AND ? ");
        
        if (province != null && !province.isEmpty()) {
            sql.append("AND ad.province = ? ");
        }
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
            
            pstmt.setInt(1, minScore);
            pstmt.setInt(2, maxScore);
            if (province != null && !province.isEmpty()) {
                pstmt.setString(3, province);
            }
            
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("cnt");
            }
        }
        
        return 0;
    }
}
