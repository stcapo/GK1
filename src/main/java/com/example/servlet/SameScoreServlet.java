package com.example.servlet;

import com.example.util.DBUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.sql.*;

@WebServlet("/api/samescore")
public class SameScoreServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        PrintWriter out = response.getWriter();
        
        String scoreStr = request.getParameter("score");
        String yearStr = request.getParameter("year");
        String province = request.getParameter("province");
        
        if (scoreStr == null) {
            out.print("{\"success\":false,\"message\":\"Score is required\"}");
            return;
        }
        
        int score;
        int year = 2024;
        
        try {
            score = Integer.parseInt(scoreStr);
            if (yearStr != null) {
                year = Integer.parseInt(yearStr);
            }
        } catch (NumberFormatException e) {
            out.print("{\"success\":false,\"message\":\"Invalid score or year\"}");
            return;
        }
        
        // Find universities where students with same score were admitted
        // Score range: score-5 to score+5
        int scoreMin = score - 5;
        int scoreMax = score + 5;
        
        try {
            JSONObject result = new JSONObject();
            result.put("success", true);
            result.put("queryScore", score);
            result.put("queryYear", year);
            result.put("province", province);
            
            // Get universities that admitted students within this score range
            StringBuilder sql = new StringBuilder();
            sql.append("SELECT u.id, u.name, u.province, u.city, u.type, u.is_985, u.is_211, ");
            sql.append("ad.min_score, ad.avg_score, ad.min_rank, ad.enrollment_count, ");
            sql.append("m.name as major_name, m.category as major_category ");
            sql.append("FROM admission_data ad ");
            sql.append("JOIN universities u ON ad.university_id = u.id ");
            sql.append("LEFT JOIN majors m ON ad.major_id = m.id ");
            sql.append("WHERE ad.year = ? ");
            sql.append("AND ad.min_score BETWEEN ? AND ? ");
            
            if (province != null && !province.isEmpty()) {
                sql.append("AND ad.source_province = ? ");
            }
            
            sql.append("ORDER BY ad.min_score DESC, u.is_985 DESC, u.is_211 DESC ");
            sql.append("LIMIT 100");
            
            JSONArray destinations = new JSONArray();
            
            try (Connection conn = DBUtil.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
                
                int paramIndex = 1;
                pstmt.setInt(paramIndex++, year);
                pstmt.setInt(paramIndex++, scoreMin);
                pstmt.setInt(paramIndex++, scoreMax);
                
                if (province != null && !province.isEmpty()) {
                    pstmt.setString(paramIndex++, province);
                }
                
                ResultSet rs = pstmt.executeQuery();
                while (rs.next()) {
                    JSONObject dest = new JSONObject();
                    dest.put("universityId", rs.getInt("id"));
                    dest.put("universityName", rs.getString("name"));
                    dest.put("province", rs.getString("province"));
                    dest.put("city", rs.getString("city"));
                    dest.put("type", rs.getString("type"));
                    dest.put("is985", rs.getInt("is_985") == 1);
                    dest.put("is211", rs.getInt("is_211") == 1);
                    dest.put("minScore", rs.getInt("min_score"));
                    dest.put("avgScore", rs.getInt("avg_score"));
                    dest.put("minRank", rs.getInt("min_rank"));
                    dest.put("enrollmentCount", rs.getInt("enrollment_count"));
                    dest.put("majorName", rs.getString("major_name"));
                    dest.put("majorCategory", rs.getString("major_category"));
                    
                    // Calculate match level
                    int minScore = rs.getInt("min_score");
                    if (score >= minScore + 5) {
                        dest.put("matchLevel", "保底");
                    } else if (score >= minScore - 5) {
                        dest.put("matchLevel", "稳妥");
                    } else {
                        dest.put("matchLevel", "冲刺");
                    }
                    
                    destinations.add(dest);
                }
            }
            
            result.put("count", destinations.size());
            result.put("destinations", destinations);
            
            // Statistics
            JSONObject stats = new JSONObject();
            int total985 = 0, total211 = 0, totalOther = 0;
            for (int i = 0; i < destinations.size(); i++) {
                JSONObject d = destinations.getJSONObject(i);
                if (d.getBooleanValue("is985")) total985++;
                else if (d.getBooleanValue("is211")) total211++;
                else totalOther++;
            }
            stats.put("count985", total985);
            stats.put("count211", total211);
            stats.put("countOther", totalOther);
            result.put("stats", stats);
            
            out.print(result.toJSONString());
            
        } catch (SQLException e) {
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"Database error: " + e.getMessage() + "\"}");
        }
    }
}
