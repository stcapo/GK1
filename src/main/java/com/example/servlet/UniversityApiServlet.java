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

@WebServlet("/api/universities/*")
public class UniversityApiServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String pathInfo = request.getPathInfo();
        PrintWriter out = response.getWriter();
        
        try {
            if (pathInfo == null || "/".equals(pathInfo)) {
                // Search universities
                handleSearch(request, out);
            } else if ("/provinces".equals(pathInfo)) {
                // Get all provinces
                handleGetProvinces(out);
            } else if ("/recommend".equals(pathInfo)) {
                // Get recommended universities by score
                handleRecommend(request, out);
            } else if (pathInfo.matches("/\\d+")) {
                // Get university by ID
                int id = Integer.parseInt(pathInfo.substring(1));
                handleGetById(id, out);
            } else {
                response.setStatus(404);
                out.print("{\"error\":\"Not found\"}");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(500);
            out.print("{\"error\":\"Database error: " + e.getMessage() + "\"}");
        }
    }
    
    private void handleSearch(HttpServletRequest request, PrintWriter out) throws SQLException {
        String keyword = request.getParameter("keyword");
        String province = request.getParameter("province");
        String type = request.getParameter("type");
        String is985 = request.getParameter("is985");
        String is211 = request.getParameter("is211");
        String limitStr = request.getParameter("limit");
        
        int limit = 50;
        if (limitStr != null) {
            try { limit = Integer.parseInt(limitStr); } catch (Exception e) {}
        }
        
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT u.*, ");
        sql.append("(SELECT MIN(ad.min_score) FROM admission_data ad WHERE ad.university_id = u.id AND ad.year = 2024) as min_score_2024, ");
        sql.append("(SELECT MIN(ad.min_rank) FROM admission_data ad WHERE ad.university_id = u.id AND ad.year = 2024) as min_rank_2024 ");
        sql.append("FROM universities u WHERE 1=1 ");
        
        List<Object> params = new ArrayList<>();
        
        if (keyword != null && !keyword.isEmpty()) {
            sql.append("AND u.name LIKE ? ");
            params.add("%" + keyword + "%");
        }
        if (province != null && !province.isEmpty()) {
            sql.append("AND u.province = ? ");
            params.add(province);
        }
        if (type != null && !type.isEmpty()) {
            sql.append("AND u.type = ? ");
            params.add(type);
        }
        if ("1".equals(is985)) {
            sql.append("AND u.is_985 = 1 ");
        }
        if ("1".equals(is211)) {
            sql.append("AND u.is_211 = 1 ");
        }
        
        sql.append("ORDER BY COALESCE(min_score_2024, 0) DESC LIMIT ?");
        params.add(limit);
        
        JSONArray result = new JSONArray();
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                pstmt.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                JSONObject uni = new JSONObject();
                uni.put("id", rs.getInt("id"));
                uni.put("name", rs.getString("name"));
                uni.put("province", rs.getString("province"));
                uni.put("city", rs.getString("city"));
                uni.put("type", rs.getString("type"));
                uni.put("is985", rs.getInt("is_985") == 1);
                uni.put("is211", rs.getInt("is_211") == 1);
                uni.put("isDoubleFirst", rs.getInt("is_double_first") == 1);
                uni.put("minScore2024", rs.getObject("min_score_2024"));
                uni.put("minRank2024", rs.getObject("min_rank_2024"));
                result.add(uni);
            }
        }
        
        JSONObject response = new JSONObject();
        response.put("success", true);
        response.put("count", result.size());
        response.put("data", result);
        out.print(response.toJSONString());
    }
    
    private void handleGetProvinces(PrintWriter out) throws SQLException {
        JSONArray provinces = new JSONArray();
        
        String sql = "SELECT DISTINCT province FROM universities WHERE province IS NOT NULL ORDER BY province";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                provinces.add(rs.getString("province"));
            }
        }
        
        JSONObject response = new JSONObject();
        response.put("success", true);
        response.put("data", provinces);
        out.print(response.toJSONString());
    }
    
    private void handleRecommend(HttpServletRequest request, PrintWriter out) throws SQLException {
        String scoreStr = request.getParameter("score");
        String province = request.getParameter("province");
        
        if (scoreStr == null) {
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
        
        // Calculate score range for recommendations
        int impactMin = score - 30;  // 冲
        int safeMin = score - 10;    // 稳
        int safeMax = score + 10;
        int backupMax = score + 30;  // 保
        
        JSONObject result = new JSONObject();
        result.put("success", true);
        result.put("userScore", score);
        
        // Get impact universities (冲)
        result.put("impact", getUniversitiesByScoreRange(impactMin, score, province, "冲"));
        
        // Get safe universities (稳)
        result.put("safe", getUniversitiesByScoreRange(safeMin, safeMax, province, "稳"));
        
        // Get backup universities (保)
        result.put("backup", getUniversitiesByScoreRange(score, backupMax, province, "保"));
        
        out.print(result.toJSONString());
    }
    
    private JSONArray getUniversitiesByScoreRange(int minScore, int maxScore, String province, String level) throws SQLException {
        JSONArray result = new JSONArray();
        
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT u.id, u.name, u.province, u.type, u.is_985, u.is_211, ");
        sql.append("MIN(ad.min_score) as min_score, MIN(ad.min_rank) as min_rank ");
        sql.append("FROM universities u ");
        sql.append("JOIN admission_data ad ON u.id = ad.university_id ");
        sql.append("WHERE ad.year = 2024 ");
        sql.append("AND ad.min_score BETWEEN ? AND ? ");
        
        List<Object> params = new ArrayList<>();
        params.add(minScore);
        params.add(maxScore);
        
        if (province != null && !province.isEmpty()) {
            sql.append("AND ad.source_province = ? ");
            params.add(province);
        }
        
        sql.append("GROUP BY u.id, u.name, u.province, u.type, u.is_985, u.is_211 ");
        sql.append("ORDER BY min_score DESC LIMIT 20");
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                pstmt.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                JSONObject uni = new JSONObject();
                uni.put("id", rs.getInt("id"));
                uni.put("name", rs.getString("name"));
                uni.put("province", rs.getString("province"));
                uni.put("type", rs.getString("type"));
                uni.put("is985", rs.getInt("is_985") == 1);
                uni.put("is211", rs.getInt("is_211") == 1);
                uni.put("minScore", rs.getInt("min_score"));
                uni.put("minRank", rs.getInt("min_rank"));
                uni.put("level", level);
                result.add(uni);
            }
        }
        
        return result;
    }
    
    private void handleGetById(int id, PrintWriter out) throws SQLException {
        String sql = "SELECT * FROM universities WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                JSONObject uni = new JSONObject();
                uni.put("id", rs.getInt("id"));
                uni.put("name", rs.getString("name"));
                uni.put("province", rs.getString("province"));
                uni.put("city", rs.getString("city"));
                uni.put("type", rs.getString("type"));
                uni.put("is985", rs.getInt("is_985") == 1);
                uni.put("is211", rs.getInt("is_211") == 1);
                uni.put("isDoubleFirst", rs.getInt("is_double_first") == 1);
                
                // Get admission data
                String admissionSql = "SELECT * FROM admission_data WHERE university_id = ? ORDER BY year DESC";
                PreparedStatement admissionStmt = conn.prepareStatement(admissionSql);
                admissionStmt.setInt(1, id);
                ResultSet admissionRs = admissionStmt.executeQuery();
                
                JSONArray admissions = new JSONArray();
                while (admissionRs.next()) {
                    JSONObject admission = new JSONObject();
                    admission.put("year", admissionRs.getInt("year"));
                    admission.put("batch", admissionRs.getString("batch"));
                    admission.put("minScore", admissionRs.getInt("min_score"));
                    admission.put("avgScore", admissionRs.getInt("avg_score"));
                    admission.put("minRank", admissionRs.getInt("min_rank"));
                    admission.put("enrollmentCount", admissionRs.getInt("enrollment_count"));
                    admissions.add(admission);
                }
                uni.put("admissions", admissions);
                
                JSONObject response = new JSONObject();
                response.put("success", true);
                response.put("data", uni);
                out.print(response.toJSONString());
            } else {
                out.print("{\"success\":false,\"message\":\"University not found\"}");
            }
        }
    }
}
