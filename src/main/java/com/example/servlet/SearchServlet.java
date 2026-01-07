package com.example.servlet;

import com.example.DAO.UniversityDao;
import com.example.DAO.MajorDao;
import com.example.entity.University;
import com.example.entity.Major;
import com.alibaba.fastjson.JSON;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 搜索API Servlet
 * GET /search?type=university&q=xxx - 搜索大学
 * GET /search?type=major&q=xxx - 搜索专业
 * GET /search?type=province&q=xxx - 按省份筛选
 * GET /search?type=provinces - 获取所有省份
 */
@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    
    private UniversityDao universityDao = new UniversityDao();
    private MajorDao majorDao = new MajorDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        response.setHeader("Access-Control-Allow-Origin", "*");
        
        String type = request.getParameter("type");
        String query = request.getParameter("q");
        
        Map<String, Object> result = new HashMap<>();
        
        try {
            if ("university".equals(type) && query != null) {
                // 搜索大学
                List<University> universities = universityDao.searchByName(query);
                result.put("success", true);
                result.put("data", universities);
                result.put("count", universities.size());
                
            } else if ("major".equals(type) && query != null) {
                // 搜索专业
                List<Major> majors = majorDao.searchByName(query);
                result.put("success", true);
                result.put("data", majors);
                result.put("count", majors.size());
                
            } else if ("province".equals(type) && query != null) {
                // 按省份筛选大学
                List<University> universities = universityDao.getByProvince(query);
                result.put("success", true);
                result.put("data", universities);
                result.put("count", universities.size());
                
            } else if ("provinces".equals(type)) {
                // 获取所有省份列表
                List<String> provinces = universityDao.getAllProvinces();
                result.put("success", true);
                result.put("data", provinces);
                
            } else if ("probability".equals(type)) {
                // 获取大学录取概率（需要用户位次）
                String rankStr = request.getParameter("rank");
                int userRank = rankStr != null ? Integer.parseInt(rankStr) : 5000;
                List<Object[]> data = universityDao.getUniversityWithProbability(userRank);
                result.put("success", true);
                result.put("data", data);
                result.put("count", data.size());
                
            } else {
                result.put("success", false);
                result.put("error", "Invalid type or missing query parameter");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("error", e.getMessage());
        }
        
        PrintWriter out = response.getWriter();
        out.print(JSON.toJSONString(result));
        out.flush();
    }
}
