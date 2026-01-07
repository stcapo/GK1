package com.example.servlet;

import com.example.DAO.WishlistDao;
import com.alibaba.fastjson.JSON;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 志愿单管理API Servlet
 * GET /wishlist - 获取用户志愿单
 * POST /wishlist?action=add&univId=xxx&majorId=xxx - 添加到志愿单
 * POST /wishlist?action=remove&id=xxx - 移除
 * POST /wishlist?action=reorder&id=xxx&priority=xxx - 调整排序
 */
@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {
    
    private WishlistDao wishlistDao = new WishlistDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        
        HttpSession session = request.getSession(false);
        Map<String, Object> result = new HashMap<>();
        
        if (session == null || session.getAttribute("user") == null) {
            result.put("success", false);
            result.put("error", "请先登录");
        } else {
            int userId = (int) session.getAttribute("userId");
            List<Object[]> wishlist = wishlistDao.getUserWishlist(userId);
            result.put("success", true);
            result.put("data", wishlist);
            result.put("count", wishlist.size());
        }
        
        PrintWriter out = response.getWriter();
        out.print(JSON.toJSONString(result));
        out.flush();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        
        HttpSession session = request.getSession(false);
        Map<String, Object> result = new HashMap<>();
        
        if (session == null || session.getAttribute("user") == null) {
            result.put("success", false);
            result.put("error", "请先登录");
        } else {
            int userId = (int) session.getAttribute("userId");
            String action = request.getParameter("action");
            
            try {
                if ("add".equals(action)) {
                    int univId = Integer.parseInt(request.getParameter("univId"));
                    String majorIdStr = request.getParameter("majorId");
                    Integer majorId = majorIdStr != null && !majorIdStr.isEmpty() 
                        ? Integer.parseInt(majorIdStr) : null;
                    
                    boolean success = wishlistDao.addToWishlist(userId, univId, majorId);
                    result.put("success", success);
                    result.put("message", success ? "已添加到志愿单" : "添加失败");
                    
                } else if ("remove".equals(action)) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    boolean success = wishlistDao.removeFromWishlist(userId, id);
                    result.put("success", success);
                    result.put("message", success ? "已从志愿单移除" : "移除失败");
                    
                } else if ("reorder".equals(action)) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    int priority = Integer.parseInt(request.getParameter("priority"));
                    boolean success = wishlistDao.updatePriority(userId, id, priority);
                    result.put("success", success);
                    result.put("message", success ? "排序已更新" : "更新失败");
                    
                } else {
                    result.put("success", false);
                    result.put("error", "Invalid action");
                }
            } catch (NumberFormatException e) {
                result.put("success", false);
                result.put("error", "Invalid parameter format");
            }
        }
        
        PrintWriter out = response.getWriter();
        out.print(JSON.toJSONString(result));
        out.flush();
    }
}
