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
 * Wishlist API - Full CRUD for user wishlists
 */
@WebServlet("/api/wishlist/*")
public class WishlistApiServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("userId") == null) {
            out.print("{\"success\":false,\"message\":\"Please login first\"}");
            return;
        }
        
        int userId = (Integer) session.getAttribute("userId");
        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo == null || "/".equals(pathInfo)) {
                // Get all wishlists for user
                handleGetAll(userId, out);
            } else if (pathInfo.matches("/\\d+")) {
                // Get specific wishlist with items
                int wishlistId = Integer.parseInt(pathInfo.substring(1));
                handleGetById(userId, wishlistId, out);
            } else {
                response.setStatus(404);
                out.print("{\"error\":\"Not found\"}");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"Database error\"}");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("userId") == null) {
            out.print("{\"success\":false,\"message\":\"Please login first\"}");
            return;
        }
        
        int userId = (Integer) session.getAttribute("userId");
        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo == null || "/".equals(pathInfo)) {
                // Create new wishlist
                handleCreate(request, userId, out);
            } else if (pathInfo.matches("/\\d+/items")) {
                // Add item to wishlist
                int wishlistId = Integer.parseInt(pathInfo.split("/")[1]);
                handleAddItem(request, userId, wishlistId, out);
            } else {
                response.setStatus(404);
                out.print("{\"error\":\"Not found\"}");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"Database error\"}");
        }
    }
    
    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("userId") == null) {
            out.print("{\"success\":false,\"message\":\"Please login first\"}");
            return;
        }
        
        int userId = (Integer) session.getAttribute("userId");
        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo != null && pathInfo.matches("/\\d+")) {
                int wishlistId = Integer.parseInt(pathInfo.substring(1));
                handleUpdate(request, userId, wishlistId, out);
            } else {
                response.setStatus(404);
                out.print("{\"error\":\"Not found\"}");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"Database error\"}");
        }
    }
    
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("userId") == null) {
            out.print("{\"success\":false,\"message\":\"Please login first\"}");
            return;
        }
        
        int userId = (Integer) session.getAttribute("userId");
        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo != null && pathInfo.matches("/\\d+")) {
                int wishlistId = Integer.parseInt(pathInfo.substring(1));
                handleDelete(userId, wishlistId, out);
            } else if (pathInfo != null && pathInfo.matches("/\\d+/items/\\d+")) {
                String[] parts = pathInfo.split("/");
                int wishlistId = Integer.parseInt(parts[1]);
                int itemId = Integer.parseInt(parts[3]);
                handleDeleteItem(userId, wishlistId, itemId, out);
            } else {
                response.setStatus(404);
                out.print("{\"error\":\"Not found\"}");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"Database error\"}");
        }
    }
    
    private void handleGetAll(int userId, PrintWriter out) throws SQLException {
        String sql = "SELECT w.*, " +
            "(SELECT COUNT(*) FROM wishlist_items wi WHERE wi.wishlist_id = w.id) as item_count " +
            "FROM wishlist w WHERE w.user_id = ? ORDER BY w.updated_at DESC";
        
        JSONArray wishlists = new JSONArray();
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                JSONObject wl = new JSONObject();
                wl.put("id", rs.getInt("id"));
                wl.put("name", rs.getString("name"));
                wl.put("year", rs.getInt("year"));
                wl.put("status", rs.getString("status"));
                wl.put("itemCount", rs.getInt("item_count"));
                wl.put("createdAt", rs.getString("created_at"));
                wl.put("updatedAt", rs.getString("updated_at"));
                wishlists.add(wl);
            }
        }
        
        JSONObject response = new JSONObject();
        response.put("success", true);
        response.put("data", wishlists);
        out.print(response.toJSONString());
    }
    
    private void handleGetById(int userId, int wishlistId, PrintWriter out) throws SQLException {
        String sql = "SELECT * FROM wishlist WHERE id = ? AND user_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, wishlistId);
            pstmt.setInt(2, userId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                JSONObject wl = new JSONObject();
                wl.put("id", rs.getInt("id"));
                wl.put("name", rs.getString("name"));
                wl.put("year", rs.getInt("year"));
                wl.put("status", rs.getString("status"));
                
                // Get items
                String itemSql = "SELECT wi.*, u.name as university_name, m.name as major_name " +
                    "FROM wishlist_items wi " +
                    "JOIN universities u ON wi.university_id = u.id " +
                    "LEFT JOIN majors m ON wi.major_id = m.id " +
                    "WHERE wi.wishlist_id = ? " +
                    "ORDER BY wi.order_num";
                
                PreparedStatement itemStmt = conn.prepareStatement(itemSql);
                itemStmt.setInt(1, wishlistId);
                ResultSet itemRs = itemStmt.executeQuery();
                
                JSONArray items = new JSONArray();
                while (itemRs.next()) {
                    JSONObject item = new JSONObject();
                    item.put("id", itemRs.getInt("id"));
                    item.put("order", itemRs.getInt("order_num"));
                    item.put("universityId", itemRs.getInt("university_id"));
                    item.put("universityName", itemRs.getString("university_name"));
                    item.put("majorId", itemRs.getObject("major_id"));
                    item.put("majorName", itemRs.getString("major_name"));
                    item.put("strategy", itemRs.getString("strategy"));
                    items.add(item);
                }
                wl.put("items", items);
                
                JSONObject response = new JSONObject();
                response.put("success", true);
                response.put("data", wl);
                out.print(response.toJSONString());
            } else {
                out.print("{\"success\":false,\"message\":\"Wishlist not found\"}");
            }
        }
    }
    
    private void handleCreate(HttpServletRequest request, int userId, PrintWriter out) throws SQLException {
        String name = request.getParameter("name");
        String yearStr = request.getParameter("year");
        
        if (name == null || name.isEmpty()) {
            name = "我的志愿表";
        }
        
        int year = java.time.Year.now().getValue();
        if (yearStr != null) {
            try { year = Integer.parseInt(yearStr); } catch (Exception e) {}
        }
        
        String sql = "INSERT INTO wishlist (user_id, name, year) VALUES (?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setInt(1, userId);
            pstmt.setString(2, name);
            pstmt.setInt(3, year);
            pstmt.executeUpdate();
            
            ResultSet keys = pstmt.getGeneratedKeys();
            int newId = 0;
            if (keys.next()) {
                newId = keys.getInt(1);
            }
            
            JSONObject response = new JSONObject();
            response.put("success", true);
            response.put("id", newId);
            response.put("message", "创建成功");
            out.print(response.toJSONString());
        }
    }
    
    private void handleAddItem(HttpServletRequest request, int userId, int wishlistId, PrintWriter out) throws SQLException {
        String universityIdStr = request.getParameter("universityId");
        String majorIdStr = request.getParameter("majorId");
        String orderStr = request.getParameter("order");
        String strategy = request.getParameter("strategy");
        
        if (universityIdStr == null) {
            out.print("{\"success\":false,\"message\":\"University ID is required\"}");
            return;
        }
        
        int universityId = Integer.parseInt(universityIdStr);
        Integer majorId = majorIdStr != null ? Integer.parseInt(majorIdStr) : null;
        
        // Get next order number if not specified
        int order = 1;
        if (orderStr != null) {
            order = Integer.parseInt(orderStr);
        } else {
            String maxOrderSql = "SELECT COALESCE(MAX(order_num), 0) + 1 FROM wishlist_items WHERE wishlist_id = ?";
            try (Connection conn = DBUtil.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(maxOrderSql)) {
                pstmt.setInt(1, wishlistId);
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) {
                    order = rs.getInt(1);
                }
            }
        }
        
        String sql = "INSERT INTO wishlist_items (wishlist_id, university_id, major_id, order_num, strategy) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setInt(1, wishlistId);
            pstmt.setInt(2, universityId);
            if (majorId != null) {
                pstmt.setInt(3, majorId);
            } else {
                pstmt.setNull(3, Types.INTEGER);
            }
            pstmt.setInt(4, order);
            pstmt.setString(5, strategy);
            pstmt.executeUpdate();
            
            ResultSet keys = pstmt.getGeneratedKeys();
            int newId = 0;
            if (keys.next()) {
                newId = keys.getInt(1);
            }
            
            // Update wishlist updated_at
            String updateSql = "UPDATE wishlist SET updated_at = CURRENT_TIMESTAMP WHERE id = ?";
            PreparedStatement updateStmt = conn.prepareStatement(updateSql);
            updateStmt.setInt(1, wishlistId);
            updateStmt.executeUpdate();
            
            JSONObject response = new JSONObject();
            response.put("success", true);
            response.put("itemId", newId);
            response.put("message", "添加成功");
            out.print(response.toJSONString());
        }
    }
    
    private void handleUpdate(HttpServletRequest request, int userId, int wishlistId, PrintWriter out) throws SQLException {
        String name = request.getParameter("name");
        
        String sql = "UPDATE wishlist SET name = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ? AND user_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, name);
            pstmt.setInt(2, wishlistId);
            pstmt.setInt(3, userId);
            int rows = pstmt.executeUpdate();
            
            if (rows > 0) {
                out.print("{\"success\":true,\"message\":\"更新成功\"}");
            } else {
                out.print("{\"success\":false,\"message\":\"Wishlist not found\"}");
            }
        }
    }
    
    private void handleDelete(int userId, int wishlistId, PrintWriter out) throws SQLException {
        String sql = "DELETE FROM wishlist WHERE id = ? AND user_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, wishlistId);
            pstmt.setInt(2, userId);
            int rows = pstmt.executeUpdate();
            
            if (rows > 0) {
                out.print("{\"success\":true,\"message\":\"删除成功\"}");
            } else {
                out.print("{\"success\":false,\"message\":\"Wishlist not found\"}");
            }
        }
    }
    
    private void handleDeleteItem(int userId, int wishlistId, int itemId, PrintWriter out) throws SQLException {
        // First verify ownership
        String verifySql = "SELECT 1 FROM wishlist WHERE id = ? AND user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement verifyStmt = conn.prepareStatement(verifySql)) {
            
            verifyStmt.setInt(1, wishlistId);
            verifyStmt.setInt(2, userId);
            if (!verifyStmt.executeQuery().next()) {
                out.print("{\"success\":false,\"message\":\"Wishlist not found\"}");
                return;
            }
            
            String sql = "DELETE FROM wishlist_items WHERE id = ? AND wishlist_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, itemId);
            pstmt.setInt(2, wishlistId);
            int rows = pstmt.executeUpdate();
            
            if (rows > 0) {
                out.print("{\"success\":true,\"message\":\"删除成功\"}");
            } else {
                out.print("{\"success\":false,\"message\":\"Item not found\"}");
            }
        }
    }
}
