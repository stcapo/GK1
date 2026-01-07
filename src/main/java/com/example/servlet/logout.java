package com.example.servlet;


import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/logout")
public class logout extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 使session失效
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // 重定向到登录页面
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
}