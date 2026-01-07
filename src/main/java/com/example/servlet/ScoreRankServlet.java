package com.example.servlet;

import com.example.util.DBUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.sql.*;

@WebServlet("/api/scorerank")
public class ScoreRankServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        PrintWriter out = response.getWriter();
        
        String scoreStr = request.getParameter("score");
        String yearStr = request.getParameter("year");
        String province = request.getParameter("province");
        String subjectType = request.getParameter("subject");
        
        // If querying for a range
        String minScoreStr = request.getParameter("minScore");
        String maxScoreStr = request.getParameter("maxScore");
        
        try {
            if (minScoreStr != null && maxScoreStr != null) {
                // Range query
                handleRangeQuery(Integer.parseInt(minScoreStr), Integer.parseInt(maxScoreStr), 
                    yearStr != null ? Integer.parseInt(yearStr) : 2024, province, subjectType, out);
            } else if (scoreStr != null) {
                // Single score query
                handleSingleScoreQuery(Integer.parseInt(scoreStr), 
                    yearStr != null ? Integer.parseInt(yearStr) : 2024, province, subjectType, out);
            } else {
                // Get available years and provinces
                handleMetadata(out);
            }
        } catch (NumberFormatException e) {
            out.print("{\"success\":false,\"message\":\"Invalid number format\"}");
        } catch (SQLException e) {
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"Database error: " + e.getMessage() + "\"}");
        }
    }
    
    private void handleSingleScoreQuery(int score, int year, String province, String subjectType, PrintWriter out) throws SQLException {
        JSONObject result = new JSONObject();
        result.put("success", true);
        result.put("queryScore", score);
        result.put("queryYear", year);
        
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT * FROM score_rank WHERE score = ? AND year = ? ");
        
        if (province != null && !province.isEmpty()) {
            sql.append("AND province = ? ");
        }
        if (subjectType != null && !subjectType.isEmpty()) {
            sql.append("AND subject_type = ? ");
        }
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
            
            int paramIndex = 1;
            pstmt.setInt(paramIndex++, score);
            pstmt.setInt(paramIndex++, year);
            if (province != null && !province.isEmpty()) {
                pstmt.setString(paramIndex++, province);
            }
            if (subjectType != null && !subjectType.isEmpty()) {
                pstmt.setString(paramIndex++, subjectType);
            }
            
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                result.put("found", true);
                result.put("score", rs.getInt("score"));
                result.put("rank", rs.getInt("rank_position"));
                result.put("cumulativeCount", rs.getInt("cumulative_count"));
                result.put("province", rs.getString("province"));
                result.put("subjectType", rs.getString("subject_type"));
            } else {
                // Try to find closest score
                result.put("found", false);
                
                String closestSql = "SELECT * FROM score_rank WHERE year = ? " +
                    (province != null ? "AND province = ? " : "") +
                    "ORDER BY ABS(score - ?) LIMIT 1";
                
                PreparedStatement closestStmt = conn.prepareStatement(closestSql);
                int idx = 1;
                closestStmt.setInt(idx++, year);
                if (province != null) {
                    closestStmt.setString(idx++, province);
                }
                closestStmt.setInt(idx++, score);
                
                ResultSet closestRs = closestStmt.executeQuery();
                if (closestRs.next()) {
                    result.put("closestScore", closestRs.getInt("score"));
                    result.put("closestRank", closestRs.getInt("rank_position"));
                    result.put("estimatedRank", estimateRank(score, closestRs.getInt("score"), 
                        closestRs.getInt("rank_position"), conn, year, province));
                }
            }
        }
        
        // Get nearby scores for context
        String nearbySql = "SELECT * FROM score_rank WHERE year = ? " +
            (province != null ? "AND province = ? " : "") +
            "AND score BETWEEN ? AND ? ORDER BY score DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(nearbySql)) {
            
            int idx = 1;
            pstmt.setInt(idx++, year);
            if (province != null) {
                pstmt.setString(idx++, province);
            }
            pstmt.setInt(idx++, score - 10);
            pstmt.setInt(idx++, score + 10);
            
            ResultSet rs = pstmt.executeQuery();
            JSONArray nearby = new JSONArray();
            while (rs.next()) {
                JSONObject item = new JSONObject();
                item.put("score", rs.getInt("score"));
                item.put("rank", rs.getInt("rank_position"));
                item.put("cumulativeCount", rs.getInt("cumulative_count"));
                nearby.add(item);
            }
            result.put("nearby", nearby);
        }
        
        out.print(result.toJSONString());
    }
    
    private int estimateRank(int queryScore, int knownScore, int knownRank, Connection conn, int year, String province) throws SQLException {
        // Simple linear estimation based on nearby data points
        int scoreDiff = knownScore - queryScore;
        // Estimate ~50 students per score point on average (varies by score level)
        int estimatedDiff = scoreDiff * 50;
        return Math.max(1, knownRank + estimatedDiff);
    }
    
    private void handleRangeQuery(int minScore, int maxScore, int year, String province, String subjectType, PrintWriter out) throws SQLException {
        JSONObject result = new JSONObject();
        result.put("success", true);
        result.put("minScore", minScore);
        result.put("maxScore", maxScore);
        result.put("year", year);
        
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT * FROM score_rank WHERE year = ? AND score BETWEEN ? AND ? ");
        
        if (province != null && !province.isEmpty()) {
            sql.append("AND province = ? ");
        }
        if (subjectType != null && !subjectType.isEmpty()) {
            sql.append("AND subject_type = ? ");
        }
        
        sql.append("ORDER BY score DESC");
        
        JSONArray data = new JSONArray();
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
            
            int paramIndex = 1;
            pstmt.setInt(paramIndex++, year);
            pstmt.setInt(paramIndex++, minScore);
            pstmt.setInt(paramIndex++, maxScore);
            if (province != null && !province.isEmpty()) {
                pstmt.setString(paramIndex++, province);
            }
            if (subjectType != null && !subjectType.isEmpty()) {
                pstmt.setString(paramIndex++, subjectType);
            }
            
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                JSONObject item = new JSONObject();
                item.put("score", rs.getInt("score"));
                item.put("rank", rs.getInt("rank_position"));
                item.put("cumulativeCount", rs.getInt("cumulative_count"));
                item.put("province", rs.getString("province"));
                item.put("subjectType", rs.getString("subject_type"));
                data.add(item);
            }
        }
        
        result.put("count", data.size());
        result.put("data", data);
        out.print(result.toJSONString());
    }
    
    private void handleMetadata(PrintWriter out) throws SQLException {
        JSONObject result = new JSONObject();
        result.put("success", true);
        
        try (Connection conn = DBUtil.getConnection()) {
            // Get available years
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT DISTINCT year FROM score_rank ORDER BY year DESC");
            JSONArray years = new JSONArray();
            while (rs.next()) {
                years.add(rs.getInt("year"));
            }
            result.put("years", years);
            
            // Get available provinces
            rs = stmt.executeQuery("SELECT DISTINCT province FROM score_rank ORDER BY province");
            JSONArray provinces = new JSONArray();
            while (rs.next()) {
                provinces.add(rs.getString("province"));
            }
            result.put("provinces", provinces);
            
            // Get available subject types
            rs = stmt.executeQuery("SELECT DISTINCT subject_type FROM score_rank WHERE subject_type IS NOT NULL ORDER BY subject_type");
            JSONArray subjects = new JSONArray();
            while (rs.next()) {
                subjects.add(rs.getString("subject_type"));
            }
            result.put("subjectTypes", subjects);
        }
        
        out.print(result.toJSONString());
    }
}
