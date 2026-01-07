<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>错误提示 - 医疗挂号平台</title>
    <style>
        :root {
            --primary-color: #2e7d32;
            --primary-dark: #1b5e20;
            --error-color: #d32f2f;
            --text-color: #333;
            --light-gray: #f5f5f5;
            --white: #ffffff;
            --shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: var(--text-color);
            background-color: #f5f9f5;
        }
        .header {
            background-color: var(--primary-color);
            color: var(--white);
            padding: 1.5rem 0;
            text-align: center;
            box-shadow: var(--shadow);
        }
        .container {
            width: 90%;
            max-width: 800px;
            margin: 3rem auto;
            padding: 0 1rem;
        }
        .error-card {
            background: var(--white);
            border-radius: 8px;
            box-shadow: var(--shadow);
            padding: 2rem;
            text-align: center;
        }
        .error-icon {
            font-size: 4rem;
            color: var(--error-color);
            margin-bottom: 1.5rem;
        }
        .error-title {
            font-size: 1.8rem;
            color: var(--error-color);
            margin-bottom: 1rem;
        }
        .error-message {
            font-size: 1.1rem;
            margin-bottom: 2rem;
            padding: 0 1rem;
        }
        .action-btns {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-top: 2rem;
        }
        .btn {
            padding: 0.8rem 1.5rem;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s;
        }
        .btn-primary {
            background-color: var(--primary-color);
            color: var(--white);
        }
        .btn-primary:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
        }
        .btn-secondary {
            border: 1px solid var(--primary-color);
            color: var(--primary-color);
        }
        .btn-secondary:hover {
            background-color: var(--light-gray);
        }
        .technical-details {
            margin-top: 2rem;
            padding: 1rem;
            background-color: var(--light-gray);
            border-radius: 6px;
            font-family: monospace;
            font-size: 0.9rem;
            text-align: left;
            display: none; /* 默认隐藏技术细节 */
        }
        .show-details {
            margin-top: 1rem;
            color: var(--primary-color);
            text-decoration: underline;
            cursor: pointer;
            font-size: 0.9rem;
        }
        @media (max-width: 768px) {
            .error-icon {
                font-size: 3rem;
            }
            .error-title {
                font-size: 1.5rem;
            }
            .action-btns {
                flex-direction: column;
            }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
<div class="header">
    <h1>医疗挂号平台</h1>
</div>

<div class="container">
    <div class="error-card">
        <div class="error-icon">
            <i class="fas fa-exclamation-triangle"></i>
        </div>
        <h2 class="error-title">抱歉，系统遇到问题</h2>

        <div class="error-message">
            <c:choose>
                <c:when test="${not empty error}">
                    ${error}
                </c:when>
                <c:otherwise>
                    发生未知错误，请稍后再试或联系管理员
                </c:otherwise>
            </c:choose>
        </div>

        <div class="action-btns">
            <a href="${ctx}/dashboard.jsp" class="btn btn-primary">
                <i class="fas fa-home"></i> 返回首页
            </a>
            <a href="javascript:history.back()" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> 返回上一页
            </a>
        </div>

        <%-- 开发环境显示技术细节 --%>
        <c:if test="${pageContext.request.serverName == 'localhost'}">
            <div class="show-details" onclick="toggleDetails()">
                <i class="fas fa-code"></i> 显示技术细节
            </div>
            <div class="technical-details" id="techDetails">
                <p><strong>错误类型：</strong> ${pageContext.exception['class'].name}</p>
                <p><strong>请求URI：</strong> ${pageContext.errorData.requestURI}</p>
                <p><strong>状态码：</strong> ${pageContext.errorData.statusCode}</p>
                <c:if test="${not empty pageContext.exception}">
                    <p><strong>堆栈跟踪：</strong></p>
                    <pre>${pageContext.exception.stackTrace}</pre>
                </c:if>
            </div>
        </c:if>
    </div>
</div>

<script>
    function toggleDetails() {
        const details = document.getElementById('techDetails');
        details.style.display = details.style.display === 'block' ? 'none' : 'block';
    }
</script>
</body>
</html>