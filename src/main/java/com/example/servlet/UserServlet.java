package com.example.servlet;

import com.example.util.DBUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.sql.*;

@WebServlet("/api/user/*")
public class UserServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String pathInfo = request.getPathInfo();
        PrintWriter out = response.getWriter();
        
        if ("/info".equals(pathInfo)) {
            // Get current user info
            HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("userId");
            String username = (String) session.getAttribute("username");
            
            JSONObject result = new JSONObject();
            if (userId != null && username != null) {
                result.put("success", true);
                result.put("userId", userId);
                result.put("username", username);
                result.put("score", session.getAttribute("userScore"));
                result.put("province", session.getAttribute("userProvince"));
                result.put("subject", session.getAttribute("userSubject"));
                result.put("preference", session.getAttribute("userPreference"));
            } else {
                result.put("success", false);
                result.put("message", "未登录");
            }
            out.print(result.toJSONString());
        } else {
            response.setStatus(404);
            out.print("{\"error\":\"Not found\"}");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String pathInfo = request.getPathInfo();
        PrintWriter out = response.getWriter();
        
        if ("/score".equals(pathInfo)) {
            // Save user score info
            HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("userId");
            
            JSONObject result = new JSONObject();
            
            // Get parameters
            String scoreStr = request.getParameter("score");
            String province = request.getParameter("province");
            String subject = request.getParameter("subject");
            String preference = request.getParameter("preference");
            
            if (scoreStr == null || scoreStr.isEmpty()) {
                result.put("success", false);
                result.put("message", "分数不能为空");
                out.print(result.toJSONString());
                return;
            }
            
            int score;
            try {
                score = Integer.parseInt(scoreStr);
            } catch (NumberFormatException e) {
                result.put("success", false);
                result.put("message", "分数格式错误");
                out.print(result.toJSONString());
                return;
            }
            
            // Save to session
            session.setAttribute("userScore", score);
            session.setAttribute("userProvince", province);
            session.setAttribute("userSubject", subject);
            session.setAttribute("userPreference", preference);
            
            // If user is logged in, also save to database
            if (userId != null) {
                try (Connection conn = DBUtil.getConnection()) {
                    String sql = "UPDATE user SET score = ?, province = ? WHERE user_id = ?";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setInt(1, score);
                    stmt.setString(2, province);
                    stmt.setInt(3, userId);
                    stmt.executeUpdate();
                    
                    result.put("success", true);
                    result.put("message", "成绩信息已保存");
                    result.put("savedToDb", true);
                } catch (SQLException e) {
                    e.printStackTrace();
                    result.put("success", true);
                    result.put("message", "成绩信息已保存到会话（数据库保存失败）");
                    result.put("savedToDb", false);
                }
            } else {
                result.put("success", true);
                result.put("message", "成绩信息已保存到会话");
                result.put("savedToDb", false);
            }
            
            out.print(result.toJSONString());
        } else {
            response.setStatus(404);
            out.print("{\"error\":\"Not found\"}");
        }
    }
}
