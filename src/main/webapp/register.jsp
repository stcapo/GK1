<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册 - 智选志愿</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Ma+Shan+Zheng&family=ZCOOL+QingKe+HuangYou&family=ZCOOL+XiaoWei&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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

        /* 注册容器 */
        .register-container {
            max-width: 450px;
            padding: 40px;
            border-radius: 20px;
            background: rgba(255, 255, 255, 0.92);
            backdrop-filter: blur(15px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.1),
            0 0 0 1px rgba(255, 255, 255, 0.4);
            position: relative;
            z-index: 10;
            border: 1px solid rgba(66, 153, 225, 0.1);
        }

        .register-container:hover {
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.15),
            0 0 0 1px rgba(66, 153, 225, 0.2);
        }

        /* Logo样式 */
        .logo-container {
            margin-bottom: 30px;
            text-align: center;
        }

        .register-logo-text {
            font-family: 'Ma Shan Zheng', cursive;
            font-size: 2.8em;
            color: #1E3A5F;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.15),
            0 0 15px rgba(255, 255, 255, 0.8);
            margin-bottom: 5px;
        }

        .register-sub-logo {
            font-family: 'ZCOOL QingKe HuangYou', sans-serif;
            font-size: 1.1em;
            color: #2C5282;
            letter-spacing: 3px;
            font-weight: 300;
            text-shadow: 1px 1px 4px rgba(255, 255, 255, 0.7);
        }

        .register-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .register-header h2 {
            color: #2B6CB0;
            font-size: 1.8em;
            margin-bottom: 10px;
            font-family: 'ZCOOL QingKe HuangYou', sans-serif;
        }

        .register-header p {
            color: #718096;
            font-size: 1em;
            font-family: 'ZCOOL XiaoWei', serif;
        }

        /* 表单样式 */
        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-group i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #718096;
            font-size: 18px;
            z-index: 2;
        }

        .form-group input {
            width: 100%;
            padding: 14px 15px 14px 45px;
            border: 2px solid #E2E8F0;
            border-radius: 10px;
            font-size: 16px;
            font-family: 'ZCOOL XiaoWei', serif;
            color: #2D3748;
            background: white;
            transition: all 0.3s ease;
        }

        .form-group input:focus {
            border-color: #4299E1;
            outline: none;
            box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.1);
        }

        /* 按钮样式 */
        .btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #4299E1, #2B6CB0);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            font-family: 'ZCOOL QingKe HuangYou', sans-serif;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            letter-spacing: 1px;
            box-shadow: 0 5px 15px rgba(66, 153, 225, 0.3);
        }

        .btn i {
            margin-right: 10px;
            font-size: 18px;
            transition: transform 0.3s ease;
        }

        .btn:hover {
            background: linear-gradient(135deg, #2B6CB0, #1E3A5F);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(66, 153, 225, 0.4);
        }

        .btn:hover i {
            transform: translateX(5px);
        }

        /* 错误提示 */
        .error-message {
            padding: 12px 15px;
            border-radius: 8px;
            margin-top: 20px;
            text-align: center;
            font-size: 14px;
            font-family: 'ZCOOL XiaoWei', serif;
            background-color: rgba(245, 101, 101, 0.1);
            color: #C53030;
            border: 1px solid rgba(245, 101, 101, 0.3);
        }

        .error-message i {
            margin-right: 8px;
        }

        /* 登录链接 */
        .login-link {
            text-align: center;
            margin-top: 25px;
            font-size: 14px;
            font-family: 'ZCOOL XiaoWei', serif;
            color: #718096;
        }

        .login-link a {
            color: #4299E1;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .login-link a:hover {
            color: #2B6CB0;
            text-decoration: underline;
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

        /* 装饰元素 */
        .decoration {
            position: absolute;
            z-index: 5;
        }

        .decoration-1 {
            top: 20px;
            left: 20px;
            font-size: 1.8em;
            color: rgba(66, 153, 225, 0.3);
        }

        .decoration-2 {
            bottom: 20px;
            right: 20px;
            font-size: 1.8em;
            color: rgba(66, 153, 225, 0.3);
        }

        /* 密码强度提示 */
        .password-strength {
            margin-top: 8px;
            font-size: 12px;
            font-family: 'ZCOOL XiaoWei', serif;
            color: #718096;
            display: none;
        }

        .strength-bar {
            height: 4px;
            width: 0;
            background: #E53E3E;
            border-radius: 2px;
            margin-top: 5px;
            transition: width 0.3s ease, background 0.3s ease;
        }

        .strength-text {
            font-size: 11px;
            margin-top: 3px;
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            body {
                overflow-y: auto;
                padding: 20px;
            }

            .register-container {
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

            .register-logo-text {
                font-size: 2.2em;
            }

            .register-sub-logo {
                font-size: 0.9em;
                letter-spacing: 2px;
            }

            .register-header h2 {
                font-size: 1.6em;
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
            .register-container {
                width: 95%;
                padding: 25px 15px;
            }

            .corner-logo {
                left: 15px;
            }

            .logo-text {
                font-size: 1.6em;
            }

            .register-logo-text {
                font-size: 1.8em;
            }

            .register-header h2 {
                font-size: 1.4em;
                margin-bottom: 8px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-group input {
                padding: 12px 12px 12px 40px;
                font-size: 14px;
            }

            .form-group i {
                left: 12px;
                font-size: 16px;
            }

            .btn {
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

<!-- 注册容器 -->
<div class="register-container">
    <!-- Logo -->
    <div class="logo-container">
        <div class="register-logo-text">智选志愿</div>
        <div class="register-sub-logo">INTELLIGENT SELECTION</div>
    </div>

    <!-- 装饰元素 -->
    <div class="decoration decoration-1">🎓</div>
    <div class="decoration decoration-2">📚</div>

    <div class="register-header">
        <h2>用户注册</h2>
        <p>创建账号，开启智能志愿填报之旅</p>
    </div>

    <form action="register" method="post" id="registerForm">
        <div class="form-group">
            <i class="fas fa-user"></i>
            <input type="text" name="username" id="username" placeholder="请输入用户名" required>
        </div>
        <div class="form-group">
            <i class="fas fa-lock"></i>
            <input type="password" name="password" id="password" placeholder="请输入密码" required>
            <div class="password-strength" id="passwordStrength">
                <div class="strength-bar" id="strengthBar"></div>
                <div class="strength-text" id="strengthText">密码强度：弱</div>
            </div>
        </div>
        <div class="form-group">
            <i class="fas fa-lock"></i>
            <input type="password" name="confirmPassword" id="confirmPassword" placeholder="请确认密码" required>
        </div>
        <button type="submit" class="btn">
            <i class="fas fa-user-plus"></i> 立即注册
        </button>

        <% if (request.getAttribute("error") != null) { %>
        <div class="error-message">
            <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <div class="login-link">
            已有账号？<a href="login.jsp">立即登录</a>
        </div>
    </form>
</div>

<!-- 返回主页按钮 -->
<a href="main.jsp" class="back-home">← 返回主页</a>

<script>
    // 页面加载动画
    $(document).ready(function() {
        // 初始状态设置
        $('.corner-logo').css({
            'opacity': '0',
            'transform': 'translateX(-30px) translateY(-15px)'
        });

        $('.register-container').css({
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
            $('.register-container').css({
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

        // 密码强度检测
        $('#password').on('input', function() {
            const password = $(this).val();
            const strengthBar = $('#strengthBar');
            const strengthText = $('#strengthText');
            const passwordStrength = $('#passwordStrength');

            if (password.length === 0) {
                passwordStrength.hide();
                return;
            }

            passwordStrength.show();

            let strength = 0;
            let text = '密码强度：弱';
            let color = '#E53E3E';
            let width = '33%';

            // 长度检测
            if (password.length >= 8) strength++;

            // 大小写字母检测
            if (/[a-z]/.test(password) && /[A-Z]/.test(password)) strength++;

            // 数字检测
            if (/\d/.test(password)) strength++;

            // 特殊字符检测
            if (/[!@#$%^&*(),.?":{}|<>]/.test(password)) strength++;

            // 根据强度设置显示
            switch(strength) {
                case 1:
                    text = '密码强度：弱';
                    color = '#E53E3E';
                    width = '33%';
                    break;
                case 2:
                    text = '密码强度：中';
                    color = '#D69E2E';
                    width = '66%';
                    break;
                case 3:
                    text = '密码强度：强';
                    color = '#38A169';
                    width = '85%';
                    break;
                case 4:
                    text = '密码强度：很强';
                    color = '#2B6CB0';
                    width = '100%';
                    break;
            }

            strengthBar.css({
                'width': width,
                'background': color
            });

            strengthText.text(text);
            strengthText.css('color', color);
        });

        // 密码确认验证
        $('#confirmPassword').on('input', function() {
            const password = $('#password').val();
            const confirmPassword = $(this).val();

            if (confirmPassword && password !== confirmPassword) {
                $(this).css('border-color', '#E53E3E');
            } else if (confirmPassword) {
                $(this).css('border-color', '#38A169');
            } else {
                $(this).css('border-color', '#E2E8F0');
            }
        });

        // 表单提交验证
        $('#registerForm').submit(function(e) {
            const username = $('#username').val();
            const password = $('#password').val();
            const confirmPassword = $('#confirmPassword').val();

            // 用户名验证
            if (!username || username.length < 3) {
                alert('用户名至少需要3个字符');
                e.preventDefault();
                return false;
            }

            // 密码验证
            if (!password || password.length < 6) {
                alert('密码至少需要6个字符');
                e.preventDefault();
                return false;
            }

            // 密码确认验证
            if (password !== confirmPassword) {
                alert('两次输入的密码不一致');
                e.preventDefault();
                return false;
            }

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
                $('.cloud').css({
                    'filter': 'blur(2px)'
                });

                $('body').css('overflow-y', 'auto');
            } else {
                $('body').css('overflow-y', 'hidden');
            }
        }

        adjustForMobile();
        $(window).resize(adjustForMobile);
    });
</script>
</body>
</html>