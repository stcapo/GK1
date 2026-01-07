<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>智选志愿 - 登录</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Ma+Shan+Zheng&family=ZCOOL+QingKe+HuangYou&family=ZCOOL+XiaoWei&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'ZCOOL XiaoWei', 'Microsoft YaHei', sans-serif;
            background: linear-gradient(to bottom,
            #87CEEB 0%,      /* 天空蓝 */
            #B0E2FF 40%,     /* 浅天蓝 */
            #87CEEB 80%,     /* 天空蓝 */
            #4682B4 100%     /* 钢蓝色 */
            );
            min-height: 100vh;
            overflow: hidden;
            position: relative;
            width: 100vw;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* 天空云朵背景层 */
        .sky-background {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 0;
            overflow: hidden;
        }

        /* 正常的云朵形状 - 使用多个圆形组合 */
        .cloud {
            position: absolute;
            background: rgba(255, 255, 255, 0.95);
            z-index: 1;
            filter: blur(1px);
        }

        /* 云朵1 - 自然云朵形状 */
        .cloud-1 {
            width: 180px;
            height: 60px;
            top: 20%;
            left: 10%;
            border-radius: 60px;
            animation: cloudFloat1 20s ease-in-out infinite alternate;
            box-shadow:
                    0 0 25px rgba(255, 255, 255, 0.9),
                    inset 0 0 12px rgba(255, 255, 255, 0.8);
        }

        .cloud-1::before,
        .cloud-1::after {
            content: '';
            position: absolute;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 50%;
            box-shadow:
                    0 0 15px rgba(255, 255, 255, 0.8),
                    inset 0 0 8px rgba(255, 255, 255, 0.9);
        }

        .cloud-1::before {
            width: 80px;
            height: 80px;
            top: -40px;
            left: 15px;
        }

        .cloud-1::after {
            width: 100px;
            height: 100px;
            top: -50px;
            left: 60px;
        }

        .cloud-1 .cloud-part {
            position: absolute;
            width: 70px;
            height: 70px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 50%;
            top: -35px;
            left: 120px;
            box-shadow:
                    0 0 15px rgba(255, 255, 255, 0.8),
                    inset 0 0 8px rgba(255, 255, 255, 0.9);
        }

        /* 云朵2 */
        .cloud-2 {
            width: 220px;
            height: 70px;
            top: 40%;
            right: 15%;
            border-radius: 70px;
            animation: cloudFloat2 25s ease-in-out infinite alternate;
            animation-delay: 5s;
            box-shadow:
                    0 0 25px rgba(255, 255, 255, 0.9),
                    inset 0 0 12px rgba(255, 255, 255, 0.8);
        }

        .cloud-2::before,
        .cloud-2::after {
            content: '';
            position: absolute;
            background: rgba(255, 255, 255, 0.92);
            border-radius: 50%;
            box-shadow:
                    0 0 15px rgba(255, 255, 255, 0.8),
                    inset 0 0 8px rgba(255, 255, 255, 0.9);
        }

        .cloud-2::before {
            width: 90px;
            height: 90px;
            top: -45px;
            left: 25px;
        }

        .cloud-2::after {
            width: 110px;
            height: 110px;
            top: -55px;
            left: 85px;
        }

        .cloud-2 .cloud-part {
            position: absolute;
            width: 85px;
            height: 85px;
            background: rgba(255, 255, 255, 0.92);
            border-radius: 50%;
            top: -42px;
            left: 150px;
            box-shadow:
                    0 0 15px rgba(255, 255, 255, 0.8),
                    inset 0 0 8px rgba(255, 255, 255, 0.9);
        }

        /* 云朵3 */
        .cloud-3 {
            width: 160px;
            height: 55px;
            top: 70%;
            left: 20%;
            border-radius: 55px;
            animation: cloudFloat3 18s ease-in-out infinite alternate;
            animation-delay: 10s;
            box-shadow:
                    0 0 20px rgba(255, 255, 255, 0.9),
                    inset 0 0 10px rgba(255, 255, 255, 0.8);
        }

        .cloud-3::before,
        .cloud-3::after {
            content: '';
            position: absolute;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 50%;
            box-shadow:
                    0 0 12px rgba(255, 255, 255, 0.8),
                    inset 0 0 6px rgba(255, 255, 255, 0.9);
        }

        .cloud-3::before {
            width: 70px;
            height: 70px;
            top: -35px;
            left: 10px;
        }

        .cloud-3::after {
            width: 80px;
            height: 80px;
            top: -40px;
            left: 60px;
        }

        .cloud-3 .cloud-part {
            position: absolute;
            width: 60px;
            height: 60px;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 50%;
            top: -30px;
            left: 110px;
            box-shadow:
                    0 0 12px rgba(255, 255, 255, 0.8),
                    inset 0 0 6px rgba(255, 255, 255, 0.9);
        }

        /* 云朵4 */
        .cloud-4 {
            width: 200px;
            height: 65px;
            top: 30%;
            right: 5%;
            border-radius: 65px;
            animation: cloudFloat4 22s ease-in-out infinite alternate;
            animation-delay: 15s;
            box-shadow:
                    0 0 22px rgba(255, 255, 255, 0.9),
                    inset 0 0 11px rgba(255, 255, 255, 0.8);
        }

        .cloud-4::before,
        .cloud-4::after {
            content: '';
            position: absolute;
            background: rgba(255, 255, 255, 0.93);
            border-radius: 50%;
            box-shadow:
                    0 0 18px rgba(255, 255, 255, 0.8),
                    inset 0 0 9px rgba(255, 255, 255, 0.9);
        }

        .cloud-4::before {
            width: 85px;
            height: 85px;
            top: -42px;
            left: 20px;
        }

        .cloud-4::after {
            width: 100px;
            height: 100px;
            top: -50px;
            left: 85px;
        }

        .cloud-4 .cloud-part {
            position: absolute;
            width: 75px;
            height: 75px;
            background: rgba(255, 255, 255, 0.93);
            border-radius: 50%;
            top: -37px;
            left: 145px;
            box-shadow:
                    0 0 18px rgba(255, 255, 255, 0.8),
                    inset 0 0 9px rgba(255, 255, 255, 0.9);
        }

        /* 云朵飘动动画 */
        @keyframes cloudFloat1 {
            0% {
                transform: translate(0, 0);
            }
            25% {
                transform: translate(15px, -10px);
            }
            50% {
                transform: translate(0, 5px);
            }
            75% {
                transform: translate(-10px, -5px);
            }
            100% {
                transform: translate(5px, 10px);
            }
        }

        @keyframes cloudFloat2 {
            0% {
                transform: translate(0, 0);
            }
            33% {
                transform: translate(-12px, 8px);
            }
            66% {
                transform: translate(8px, -8px);
            }
            100% {
                transform: translate(-5px, 12px);
            }
        }

        @keyframes cloudFloat3 {
            0% {
                transform: translate(0, 0);
            }
            25% {
                transform: translate(10px, 5px);
            }
            50% {
                transform: translate(-5px, -10px);
            }
            75% {
                transform: translate(15px, -5px);
            }
            100% {
                transform: translate(-8px, 8px);
            }
        }

        @keyframes cloudFloat4 {
            0% {
                transform: translate(0, 0);
            }
            20% {
                transform: translate(-8px, -12px);
            }
            40% {
                transform: translate(12px, -5px);
            }
            60% {
                transform: translate(-10px, 10px);
            }
            80% {
                transform: translate(8px, 8px);
            }
            100% {
                transform: translate(-5px, -8px);
            }
        }

        /* 阳光光晕 */
        .sun-glow {
            position: absolute;
            top: 8%;
            right: 8%;
            width: 120px;
            height: 120px;
            background: radial-gradient(circle,
            rgba(255, 255, 180, 0.9) 0%,
            rgba(255, 255, 140, 0.7) 30%,
            rgba(255, 255, 100, 0.4) 60%,
            transparent 80%
            );
            border-radius: 50%;
            animation: sunPulse 8s ease-in-out infinite;
            z-index: 1;
            filter: blur(5px);
        }

        @keyframes sunPulse {
            0%, 100% {
                transform: scale(1);
                opacity: 0.8;
            }
            50% {
                transform: scale(1.1);
                opacity: 1;
            }
        }

        /* 左上角logo - 无框设计 */
        .corner-logo {
            position: absolute;
            top: 30px;
            left: 40px;
            z-index: 10;
            background: transparent;
            padding: 0;
            border: none;
            box-shadow: none;
        }

        .logo-text {
            font-family: 'Ma Shan Zheng', cursive;
            font-size: 2.2em;
            color: #1E3A5F;
            text-shadow:
                    2px 2px 8px rgba(0, 0, 0, 0.15),
                    0 0 15px rgba(255, 255, 255, 0.8);
            position: relative;
            display: inline-block;
            letter-spacing: 2px;
        }

        .sub-logo {
            font-family: 'ZCOOL QingKe HuangYou', sans-serif;
            font-size: 0.9em;
            color: #2C5282;
            margin-top: 5px;
            letter-spacing: 2px;
            font-weight: 300;
            text-shadow: 1px 1px 4px rgba(255, 255, 255, 0.7);
        }

        /* 登录容器 */
        .login-container {
            background-color: rgba(255, 255, 255, 0.92);
            backdrop-filter: blur(15px);
            border-radius: 20px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.1),
            0 0 0 1px rgba(255, 255, 255, 0.4);
            padding: 40px;
            width: 400px;
            text-align: center;
            position: relative;
            z-index: 10;
            border: 1px solid rgba(66, 153, 225, 0.1);
        }

        /* Logo样式 */
        .logo-container {
            margin-bottom: 30px;
        }

        .login-logo-text {
            font-family: 'Ma Shan Zheng', cursive;
            font-size: 3em;
            color: #1E3A5F;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.15),
            0 0 15px rgba(255, 255, 255, 0.8);
            margin-bottom: 5px;
        }

        .login-sub-logo {
            font-family: 'ZCOOL QingKe HuangYou', sans-serif;
            font-size: 1.1em;
            color: #2C5282;
            letter-spacing: 3px;
            font-weight: 300;
            text-shadow: 1px 1px 4px rgba(255, 255, 255, 0.7);
        }

        h2 {
            color: #2B6CB0;
            margin-bottom: 30px;
            font-family: 'ZCOOL QingKe HuangYou', sans-serif;
            font-size: 1.8em;
        }

        .form-group {
            margin-bottom: 25px;
            text-align: left;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #2C5282;
            font-weight: 500;
            font-family: 'ZCOOL XiaoWei', serif;
            font-size: 1.1em;
        }

        input {
            width: 100%;
            padding: 14px;
            border: 2px solid #E2E8F0;
            border-radius: 10px;
            box-sizing: border-box;
            font-size: 16px;
            font-family: 'ZCOOL XiaoWei', serif;
            color: #2D3748;
            background: white;
            transition: all 0.3s ease;
        }

        input:focus {
            outline: none;
            border-color: #4299E1;
            box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.1);
        }

        button {
            background: linear-gradient(135deg, #4299E1, #2B6CB0);
            color: white;
            border: none;
            padding: 15px 20px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
            transition: all 0.3s ease;
            font-family: 'ZCOOL QingKe HuangYou', sans-serif;
            font-weight: 600;
            letter-spacing: 1px;
            box-shadow: 0 5px 15px rgba(66, 153, 225, 0.3);
        }

        button:hover {
            background: linear-gradient(135deg, #2B6CB0, #1E3A5F);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(66, 153, 225, 0.4);
        }

        .error {
            color: #C53030;
            background-color: rgba(245, 101, 101, 0.1);
            padding: 12px;
            border-radius: 8px;
            margin-top: 20px;
            font-size: 14px;
            font-family: 'ZCOOL XiaoWei', serif;
            border: 1px solid rgba(245, 101, 101, 0.3);
        }

        .footer {
            margin-top: 30px;
            color: #718096;
            font-size: 13px;
            font-family: 'ZCOOL XiaoWei', serif;
        }

        .register-link {
            display: block;
            margin-top: 20px;
            color: #4299E1;
            text-decoration: none;
            font-family: 'ZCOOL XiaoWei', serif;
            font-size: 1em;
            transition: color 0.3s ease;
        }

        .register-link:hover {
            color: #2B6CB0;
            text-decoration: underline;
        }

        /* 装饰元素 */
        .decoration {
            position: absolute;
            z-index: 5;
        }

        .decoration-1 {
            top: 20px;
            left: 20px;
            font-size: 2em;
            color: rgba(66, 153, 225, 0.3);
        }

        .decoration-2 {
            bottom: 20px;
            right: 20px;
            font-size: 2em;
            color: rgba(66, 153, 225, 0.3);
        }

        /* 返回主页按钮 */
        .back-home {
            position: absolute;
            bottom: 30px;
            left: 40px;
            z-index: 10;
            background: rgba(43, 108, 176, 0.9);
            color: white;
            padding: 10px 25px;
            border-radius: 25px;
            font-family: 'ZCOOL QingKe HuangYou', sans-serif;
            font-size: 1em;
            text-decoration: none;
            border: 1px solid rgba(255, 255, 255, 0.5);
            box-shadow:
                    0 5px 20px rgba(43, 108, 176, 0.3),
                    0 0 15px rgba(43, 108, 176, 0.2);
            transition: all 0.3s ease;
            backdrop-filter: blur(5px);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .back-home:hover {
            background: rgba(30, 58, 95, 0.9);
            transform: translateY(-3px);
            box-shadow:
                    0 8px 25px rgba(43, 108, 176, 0.4),
                    0 0 20px rgba(43, 108, 176, 0.3);
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            body {
                overflow-y: auto;
                padding: 20px;
            }

            .login-container {
                width: 90%;
                padding: 30px 20px;
                margin-top: 60px;
            }

            .corner-logo {
                top: 20px;
                left: 20px;
            }

            .logo-text {
                font-size: 1.8em;
            }

            .login-logo-text {
                font-size: 2.5em;
            }

            .login-sub-logo {
                font-size: 1em;
                letter-spacing: 2px;
            }

            .back-home {
                bottom: 20px;
                left: 20px;
                padding: 8px 20px;
                font-size: 0.9em;
            }

            .cloud-1 {
                left: 5%;
                width: 150px;
            }

            .cloud-2 {
                right: 5%;
                width: 180px;
            }

            .cloud-3 {
                left: 10%;
                width: 130px;
            }

            .cloud-4 {
                right: 3%;
                width: 160px;
            }
        }

        @media (max-width: 480px) {
            .login-container {
                width: 95%;
                padding: 25px 15px;
            }

            .corner-logo {
                left: 15px;
            }

            .logo-text {
                font-size: 1.6em;
            }

            .login-logo-text {
                font-size: 2em;
            }

            h2 {
                font-size: 1.5em;
                margin-bottom: 20px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            input {
                padding: 12px;
                font-size: 14px;
            }

            button {
                padding: 12px;
                font-size: 15px;
            }

            .back-home {
                left: 15px;
                padding: 6px 15px;
                font-size: 0.85em;
            }
        }
    </style>
</head>
<body>
<!-- 蓝天白云背景 -->
<div class="sky-background">
    <div class="sun-glow"></div>
    <!-- 添加云朵 -->
    <div class="cloud cloud-1"><div class="cloud-part"></div></div>
    <div class="cloud cloud-2"><div class="cloud-part"></div></div>
    <div class="cloud cloud-3"><div class="cloud-part"></div></div>
    <div class="cloud cloud-4"><div class="cloud-part"></div></div>
</div>

<!-- 左上角logo - 无框设计 -->
<div class="corner-logo">
    <div class="logo-text">智选志愿</div>
    <div class="sub-logo">INTELLIGENT SELECTION</div>
</div>

<!-- 登录容器 -->
<div class="login-container">
    <!-- Logo -->
    <div class="logo-container">
        <div class="login-logo-text">智选志愿</div>
        <div class="login-sub-logo">INTELLIGENT SELECTION</div>
    </div>

    <!-- 装饰元素 -->
    <div class="decoration decoration-1">🎓</div>
    <div class="decoration decoration-2">📚</div>

    <h2>用户登录</h2>
    <form action="login" method="post">
        <div class="form-group">
            <label for="username">用户名</label>
            <input type="text" id="username" name="username" required placeholder="请输入用户名">
        </div>
        <div class="form-group">
            <label for="password">密码</label>
            <input type="password" id="password" name="password" required placeholder="请输入密码">
        </div>
        <button type="submit">登 录</button>
    </form>

    <a href="register.jsp" class="register-link">还没有账号？立即注册</a>

    <% if (request.getAttribute("error") != null) { %>
    <div class="error"><%= request.getAttribute("error") %></div>
    <% } %>

    <div class="footer">
        智选志愿系统 © 2025 - 为您提供智能的志愿填报服务
    </div>
</div>

<!-- 返回主页按钮 -->
<a href="index.jsp" class="back-home">← 返回</a>

<script>
    // 页面加载动画
    $(document).ready(function() {
        // 初始状态设置
        $('.corner-logo').css({
            'opacity': '0',
            'transform': 'translateX(-30px) translateY(-15px)'
        });

        $('.login-container').css({
            'opacity': '0',
            'transform': 'translateY(50px)'
        });

        $('.back-home').css({
            'opacity': '0',
            'transform': 'translateX(-15px)'
        });

        // 逐步显示动画
        setTimeout(() => {
            $('.corner-logo').css({
                'opacity': '1',
                'transform': 'translateX(0) translateY(0)',
                'transition': 'all 0.8s cubic-bezier(0.34, 1.56, 0.64, 1)'
            });
        }, 300);

        setTimeout(() => {
            $('.login-container').css({
                'opacity': '1',
                'transform': 'translateY(0)',
                'transition': 'all 0.8s cubic-bezier(0.34, 1.56, 0.64, 1)'
            });
        }, 600);

        setTimeout(() => {
            $('.back-home').css({
                'opacity': '1',
                'transform': 'translateX(0)',
                'transition': 'all 0.6s ease'
            });
        }, 900);

        // 云朵动画
        $('.cloud').each(function(index) {
            $(this).css({
                'opacity': '0',
                'transform': 'translateY(20px) scale(0.9)',
                'transition': `all 1s cubic-bezier(0.34, 1.56, 0.64, 1) ${index * 0.3}s`
            });
        });

        setTimeout(() => {
            $('.cloud').css({
                'opacity': '1',
                'transform': 'translateY(0) scale(1)'
            });
        }, 300);

        // 阳光动画
        $('.sun-glow').css({
            'opacity': '0',
            'transform': 'scale(0.8)'
        });

        setTimeout(() => {
            $('.sun-glow').css({
                'opacity': '0.8',
                'transform': 'scale(1)',
                'transition': 'all 1.5s cubic-bezier(0.34, 1.56, 0.64, 1)'
            });
        }, 1000);

        // 表单提交动画
        $('form').submit(function(e) {
            // 可以在这里添加表单验证
            const username = $('#username').val();
            const password = $('#password').val();

            if (!username || !password) {
                e.preventDefault();
                return false;
            }

            // 这里可以添加登录逻辑
            return true;
        });

        // 表单聚焦效果
        $('input').focus(function() {
            $(this).parent().css('transform', 'translateY(-2px)');
        });

        $('input').blur(function() {
            $(this).parent().css('transform', 'translateY(0)');
        });

        // 按钮点击效果
        $('button[type="submit"]').click(function() {
            $(this).css({
                'transform': 'scale(0.98)',
                'transition': 'all 0.1s ease'
            });

            setTimeout(() => {
                $(this).css({
                    'transform': 'scale(1)',
                    'transition': 'all 0.3s ease'
                });
            }, 200);
        });

        // 响应式调整
        function adjustForMobile() {
            const isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);

            if (isMobile && window.innerWidth <= 768) {
                // 移动端调整云朵大小
                $('.cloud').css({
                    'filter': 'blur(2px)'
                });

                // 移动端启用滚动
                $('body').css('overflow-y', 'auto');
            } else {
                // 桌面端禁止滚动
                $('body').css('overflow-y', 'hidden');
            }
        }

        adjustForMobile();
        $(window).resize(adjustForMobile);
    });
</script>
</body>
</html>