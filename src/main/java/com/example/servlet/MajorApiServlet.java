package com.example.servlet;

import com.example.util.DBUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.sql.*;
import java.util.*;

@WebServlet("/api/majors/*")
public class MajorApiServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String pathInfo = request.getPathInfo();
        PrintWriter out = response.getWriter();
        
        try {
            if (pathInfo == null || "/".equals(pathInfo)) {
                handleSearch(request, out);
            } else if ("/categories".equals(pathInfo)) {
                handleGetCategories(out);
            } else if (pathInfo.matches("/\\d+")) {
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
        String category = request.getParameter("category");
        String limitStr = request.getParameter("limit");
        
        int limit = 50;
        if (limitStr != null) {
            try { limit = Integer.parseInt(limitStr); } catch (Exception e) {}
        }
        
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT m.*, ");
        sql.append("(SELECT COUNT(*) FROM admission_data ad WHERE ad.major_id = m.id) as admission_count ");
        sql.append("FROM majors m WHERE 1=1 ");
        
        List<Object> params = new ArrayList<>();
        
        if (keyword != null && !keyword.isEmpty()) {
            sql.append("AND m.name LIKE ? ");
            params.add("%" + keyword + "%");
        }
        if (category != null && !category.isEmpty()) {
            sql.append("AND m.category = ? ");
            params.add(category);
        }
        
        sql.append("ORDER BY admission_count DESC LIMIT ?");
        params.add(limit);
        
        JSONArray result = new JSONArray();
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                pstmt.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                JSONObject major = new JSONObject();
                major.put("id", rs.getInt("id"));
                major.put("name", rs.getString("name"));
                major.put("category", rs.getString("category"));
                major.put("admissionCount", rs.getInt("admission_count"));
                result.add(major);
            }
        }
        
        JSONObject response = new JSONObject();
        response.put("success", true);
        response.put("count", result.size());
        response.put("data", result);
        out.print(response.toJSONString());
    }
    
    private void handleGetCategories(PrintWriter out) throws SQLException {
        JSONArray categories = new JSONArray();
        
        String sql = "SELECT DISTINCT category FROM majors WHERE category IS NOT NULL ORDER BY category";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                categories.add(rs.getString("category"));
            }
        }
        
        JSONObject response = new JSONObject();
        response.put("success", true);
        response.put("data", categories);
        out.print(response.toJSONString());
    }
    
    private void handleGetById(int id, PrintWriter out) throws SQLException {
        String sql = "SELECT * FROM majors WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                JSONObject major = new JSONObject();
                major.put("id", rs.getInt("id"));
                major.put("name", rs.getString("name"));
                major.put("category", rs.getString("category"));
                
                // Get admission data with university info
                String admissionSql = "SELECT ad.*, u.name as university_name, u.province, u.type " +
                    "FROM admission_data ad " +
                    "JOIN universities u ON ad.university_id = u.id " +
                    "WHERE ad.major_id = ? ORDER BY ad.year DESC, ad.min_score DESC";
                PreparedStatement admissionStmt = conn.prepareStatement(admissionSql);
                admissionStmt.setInt(1, id);
                ResultSet admissionRs = admissionStmt.executeQuery();
                
                JSONArray admissions = new JSONArray();
                while (admissionRs.next()) {
                    JSONObject admission = new JSONObject();
                    admission.put("universityId", admissionRs.getInt("university_id"));
                    admission.put("universityName", admissionRs.getString("university_name"));
                    admission.put("province", admissionRs.getString("province"));
                    admission.put("type", admissionRs.getString("type"));
                    admission.put("year", admissionRs.getInt("year"));
                    admission.put("minScore", admissionRs.getInt("min_score"));
                    admission.put("avgScore", admissionRs.getInt("avg_score"));
                    admission.put("minRank", admissionRs.getInt("min_rank"));
                    admissions.add(admission);
                }
                major.put("admissions", admissions);
                
                JSONObject response = new JSONObject();
                response.put("success", true);
                response.put("data", major);
                out.print(response.toJSONString());
            } else {
                out.print("{\"success\":false,\"message\":\"Major not found\"}");
            }
        }
    }
}
