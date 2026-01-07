<%-- Created by IntelliJ IDEA. User: 35389 Date: 2025/6/19 Time: 11:25 To change this template use File | Settings |
    File Templates. --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <% String username=(String) session.getAttribute("username"); Integer userId=(Integer)
            session.getAttribute("userId"); Integer userScore=(Integer) session.getAttribute("userScore"); String
            userProvince=(String) session.getAttribute("userProvince"); String userSubject=(String)
            session.getAttribute("userSubject"); boolean isLoggedIn=(username !=null && userId !=null); %>
            <html>

            <head>
                <title>高考志愿智能填报推荐系统 - 主页面</title>
                <%--引入jquery工具类--%>
                    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Ma+Shan+Zheng&family=ZCOOL+QingKe+HuangYou&family=ZCOOL+XiaoWei&display=swap"
                        rel="stylesheet">
                    <style>
                        /* 全局样式 - 与index页面一致的蓝天白云背景 */
                        * {
                            margin: 0;
                            padding: 0;
                            box-sizing: border-box;
                        }

                        body {
                            font-family: 'ZCOOL XiaoWei', 'Microsoft YaHei', sans-serif;
                            background: linear-gradient(to bottom,
                                    #87CEEB 0%,
                                    /* 天空蓝 */
                                    #B0E2FF 40%,
                                    /* 浅天蓝 */
                                    #87CEEB 80%,
                                    /* 天空蓝 */
                                    #4682B4 100%
                                    /* 钢蓝色 */
                                );
                            min-height: 100vh;
                            overflow: hidden;
                            position: relative;
                            width: 100vw;
                            height: 100vh;
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
                                    transparent 80%);
                            border-radius: 50%;
                            animation: sunPulse 8s ease-in-out infinite;
                            z-index: 1;
                            filter: blur(5px);
                        }

                        @keyframes sunPulse {

                            0%,
                            100% {
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

                        /* 右上角登录注册按钮 */
                        .auth-buttons {
                            position: absolute;
                            top: 30px;
                            right: 40px;
                            z-index: 10;
                            display: flex;
                            gap: 15px;
                        }

                        .auth-btn {
                            background: rgba(255, 255, 255, 0.85);
                            backdrop-filter: blur(10px);
                            border: none;
                            padding: 10px 25px;
                            border-radius: 25px;
                            font-family: 'ZCOOL QingKe HuangYou', sans-serif;
                            font-size: 1em;
                            color: #1E3A5F;
                            cursor: pointer;
                            box-shadow:
                                0 4px 15px rgba(0, 0, 0, 0.1),
                                0 0 0 1px rgba(255, 255, 255, 0.4);
                            transition: all 0.3s ease;
                        }

                        .auth-btn:hover {
                            background: rgba(255, 255, 255, 0.95);
                            transform: translateY(-2px);
                            box-shadow:
                                0 6px 20px rgba(0, 0, 0, 0.15),
                                0 0 0 1px rgba(255, 255, 255, 0.6);
                        }

                        .login-btn {
                            background: linear-gradient(135deg, rgba(43, 108, 176, 0.9), rgba(44, 82, 130, 0.9));
                            color: white;
                        }

                        .user-welcome {
                            background: rgba(255, 255, 255, 0.9);
                            backdrop-filter: blur(10px);
                            padding: 10px 20px;
                            border-radius: 20px;
                            font-family: 'ZCOOL QingKe HuangYou', sans-serif;
                            font-size: 1em;
                            color: #1E3A5F;
                            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                        }

                        /* 用户信息区域 - 现在在右上角登录按钮下方 */
                        .user-info-section {
                            position: absolute;
                            top: 100px;
                            right: 40px;
                            z-index: 10;
                            background: rgba(255, 255, 255, 0.9);
                            backdrop-filter: blur(10px);
                            padding: 15px 20px;
                            border-radius: 15px;
                            box-shadow:
                                0 8px 25px rgba(0, 0, 0, 0.15),
                                0 0 0 1px rgba(255, 255, 255, 0.6);
                            min-width: 280px;
                        }

                        .input-score-btn {
                            background: linear-gradient(135deg, rgba(43, 108, 176, 0.9), rgba(44, 82, 130, 0.9));
                            color: white;
                            border: none;
                            padding: 12px 30px;
                            border-radius: 25px;
                            font-family: 'ZCOOL QingKe HuangYou', sans-serif;
                            font-size: 1.1em;
                            cursor: pointer;
                            box-shadow: 0 5px 15px rgba(43, 108, 176, 0.3);
                            transition: all 0.3s ease;
                            width: 100%;
                        }

                        .input-score-btn:hover {
                            transform: translateY(-2px);
                            box-shadow: 0 8px 20px rgba(43, 108, 176, 0.4);
                        }

                        .input-hint {
                            font-family: 'ZCOOL XiaoWei', serif;
                            color: #2C5282;
                            font-size: 0.9em;
                            text-align: center;
                            margin-top: 10px;
                            opacity: 0.8;
                        }

                        /* 冲稳保指标 - 初始状态为小尺寸、半透明、上移 */
                        .rank-indicator {
                            position: absolute;
                            top: 120px;
                            /* 初始位置更高 */
                            left: 50%;
                            transform: translateX(-50%) scale(0.8);
                            /* 初始缩小 */
                            z-index: 10;
                            display: flex;
                            gap: 20px;
                            /* 初始间隙小一些 */
                            background: rgba(255, 255, 255, 0.9);
                            backdrop-filter: blur(10px);
                            padding: 10px 25px;
                            /* 初始内边距小 */
                            border-radius: 40px;
                            /* 初始圆角小 */
                            box-shadow:
                                0 5px 15px rgba(0, 0, 0, 0.1),
                                0 0 0 1px rgba(255, 255, 255, 0.6);
                            opacity: 0.3;
                            /* 初始半透明 */
                            transition: all 0.5s cubic-bezier(0.34, 1.56, 0.64, 1);
                            /* 平滑过渡 */
                        }

                        /* 有数据后的状态 - 大尺寸、不透明、正常位置 */
                        .rank-indicator.has-data {
                            top: 180px;
                            /* 下移到正常位置 */
                            transform: translateX(-50%) scale(1);
                            /* 恢复原大小 */
                            opacity: 1;
                            gap: 30px;
                            padding: 15px 40px;
                            border-radius: 50px;
                            box-shadow:
                                0 10px 30px rgba(0, 0, 0, 0.15),
                                0 0 0 1px rgba(255, 255, 255, 0.6);
                        }

                        .rank-item {
                            text-align: center;
                            min-width: 80px;
                            /* 初始小一些 */
                            transition: all 0.5s ease;
                        }

                        .rank-indicator.has-data .rank-item {
                            min-width: 100px;
                            /* 有数据后变大 */
                        }

                        .rank-value {
                            font-family: 'ZCOOL QingKe HuangYou', sans-serif;
                            font-size: 1.5em;
                            /* 初始小一些 */
                            font-weight: 600;
                            display: block;
                            line-height: 1.2;
                            transition: all 0.5s ease;
                        }

                        .rank-indicator.has-data .rank-value {
                            font-size: 1.8em;
                            /* 有数据后变大 */
                        }

                        .rank-label {
                            font-family: 'ZCOOL XiaoWei', serif;
                            font-size: 0.9em;
                            opacity: 0.9;
                            margin-top: 5px;
                            transition: all 0.5s ease;
                        }

                        /* 颜色设置 */
                        .rank-impact .rank-value {
                            color: #E53E3E;
                            text-shadow: 0 2px 8px rgba(229, 62, 62, 0.3);
                        }

                        .rank-safe .rank-value {
                            color: #2B6CB0;
                            text-shadow: 0 2px 8px rgba(43, 108, 176, 0.3);
                        }

                        .rank-backup .rank-value {
                            color: #38A169;
                            text-shadow: 0 2px 8px rgba(56, 161, 105, 0.3);
                        }

                        /* 输入成绩的模态框 */
                        .score-input-modal {
                            display: none;
                            position: fixed;
                            top: 0;
                            left: 0;
                            width: 100%;
                            height: 100%;
                            background: rgba(0, 0, 0, 0.7);
                            z-index: 1000;
                            justify-content: center;
                            align-items: center;
                            backdrop-filter: blur(3px);
                        }

                        .modal-content {
                            background: white;
                            padding: 30px;
                            border-radius: 15px;
                            min-width: 350px;
                            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.25);
                            position: relative;
                        }

                        .modal-title {
                            font-family: 'ZCOOL QingKe HuangYou', sans-serif;
                            font-size: 1.6em;
                            color: #1E3A5F;
                            margin-bottom: 20px;
                            text-align: center;
                        }

                        .input-group {
                            margin-bottom: 20px;
                        }

                        .input-group label {
                            display: block;
                            font-family: 'ZCOOL XiaoWei', serif;
                            color: #2C5282;
                            margin-bottom: 5px;
                            font-size: 1em;
                        }

                        .input-group select,
                        .input-group input {
                            width: 100%;
                            padding: 10px 15px;
                            border: 2px solid #E2E8F0;
                            border-radius: 8px;
                            font-family: 'ZCOOL XiaoWei', serif;
                            font-size: 1em;
                            color: #2C5282;
                            transition: all 0.3s ease;
                        }

                        .input-group select:focus,
                        .input-group input:focus {
                            outline: none;
                            border-color: #2B6CB0;
                            box-shadow: 0 0 0 3px rgba(43, 108, 176, 0.1);
                        }

                        .modal-buttons {
                            display: flex;
                            gap: 15px;
                            justify-content: center;
                            margin-top: 25px;
                        }

                        .modal-btn {
                            padding: 10px 25px;
                            border: none;
                            border-radius: 25px;
                            font-family: 'ZCOOL QingKe HuangYou', sans-serif;
                            font-size: 1em;
                            cursor: pointer;
                            transition: all 0.3s ease;
                        }

                        .btn-submit {
                            background: linear-gradient(135deg, #2B6CB0, #2C5282);
                            color: white;
                            box-shadow: 0 5px 15px rgba(43, 108, 176, 0.3);
                        }

                        .btn-cancel {
                            background: #E2E8F0;
                            color: #4A5568;
                        }

                        .btn-submit:hover {
                            transform: translateY(-2px);
                            box-shadow: 0 8px 20px rgba(43, 108, 176, 0.4);
                        }

                        .btn-cancel:hover {
                            background: #CBD5E0;
                            transform: translateY(-2px);
                        }

                        .close-modal {
                            position: absolute;
                            top: 15px;
                            right: 15px;
                            background: none;
                            border: none;
                            font-size: 1.5em;
                            color: #718096;
                            cursor: pointer;
                            padding: 5px;
                            border-radius: 50%;
                            transition: all 0.3s ease;
                        }

                        .close-modal:hover {
                            background: #F7FAFC;
                            color: #2D3748;
                        }

                        /* 主内容容器 - 采用简化版的布局 */
                        .main-container {
                            position: relative;
                            z-index: 2;
                            width: 90%;
                            max-width: 1000px;
                            height: calc(100vh - 250px);
                            margin: 180px auto 0;
                            display: flex;
                            flex-direction: column;
                        }

                        /* 大模块容器 */
                        .large-modules-container {
                            display: flex;
                            justify-content: center;
                            gap: 30px;
                            margin-bottom: 40px;
                            flex: 1;
                            align-items: center;
                        }

                        /* 小模块容器 */
                        .small-modules-container {
                            display: grid;
                            grid-template-columns: repeat(4, 1fr);
                            gap: 20px;
                            height: 35%;
                        }

                        /* 功能模块通用样式 - 清新清透颜色 */
                        .function-module {
                            border-radius: 20px;
                            border: 1px solid rgba(255, 255, 255, 0.4);
                            box-shadow:
                                0 10px 30px rgba(0, 0, 0, 0.1),
                                0 0 20px rgba(255, 255, 255, 0.3),
                                inset 0 1px 1px rgba(255, 255, 255, 0.5);
                            padding: 25px 20px;
                            display: flex;
                            flex-direction: column;
                            justify-content: center;
                            align-items: center;
                            text-decoration: none;
                            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                            position: relative;
                            overflow: hidden;
                            cursor: pointer;
                            backdrop-filter: blur(8px);
                        }

                        /* 大模块样式 */
                        .large-module {
                            width: 300px;
                            height: 250px;
                        }

                        /* 小模块样式 */
                        .small-module {
                            height: 100%;
                        }

                        /* 模块颜色 - 清新清透 */
                        .module-blue {
                            background: linear-gradient(135deg,
                                    rgba(66, 153, 225, 0.9) 0%,
                                    rgba(100, 179, 244, 0.8) 50%,
                                    rgba(66, 153, 225, 0.7) 100%);
                            color: white;
                        }

                        .module-green {
                            background: linear-gradient(135deg,
                                    rgba(72, 187, 120, 0.9) 0%,
                                    rgba(104, 211, 145, 0.8) 50%,
                                    rgba(72, 187, 120, 0.7) 100%);
                            color: white;
                        }

                        .module-purple {
                            background: linear-gradient(135deg,
                                    rgba(159, 122, 234, 0.9) 0%,
                                    rgba(183, 148, 244, 0.8) 50%,
                                    rgba(159, 122, 234, 0.7) 100%);
                            color: white;
                        }

                        .module-orange {
                            background: linear-gradient(135deg,
                                    rgba(237, 137, 54, 0.9) 0%,
                                    rgba(246, 173, 85, 0.8) 50%,
                                    rgba(237, 137, 54, 0.7) 100%);
                            color: white;
                        }

                        .module-pink {
                            background: linear-gradient(135deg,
                                    rgba(245, 101, 101, 0.9) 0%,
                                    rgba(251, 146, 146, 0.8) 50%,
                                    rgba(245, 101, 101, 0.7) 100%);
                            color: white;
                        }

                        .module-teal {
                            background: linear-gradient(135deg,
                                    rgba(56, 178, 172, 0.9) 0%,
                                    rgba(88, 203, 196, 0.8) 50%,
                                    rgba(56, 178, 172, 0.7) 100%);
                            color: white;
                        }

                        /* 模块图标 */
                        .module-icon {
                            width: 70px;
                            height: 70px;
                            margin-bottom: 20px;
                            background: rgba(255, 255, 255, 0.25);
                            border-radius: 18px;
                            display: flex;
                            justify-content: center;
                            align-items: center;
                            box-shadow:
                                0 6px 20px rgba(0, 0, 0, 0.15),
                                inset 0 1px 2px rgba(255, 255, 255, 0.4);
                            font-size: 2em;
                            backdrop-filter: blur(5px);
                        }

                        /* 小模块图标 */
                        .small-module .module-icon {
                            width: 50px;
                            height: 50px;
                            font-size: 1.6em;
                            margin-bottom: 15px;
                        }

                        /* 模块标题 */
                        .module-title {
                            font-family: 'ZCOOL QingKe HuangYou', sans-serif;
                            font-size: 1.8em;
                            font-weight: 600;
                            margin-bottom: 10px;
                            text-align: center;
                            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                        }

                        /* 小模块标题 */
                        .small-module .module-title {
                            font-size: 1.4em;
                            margin-bottom: 8px;
                        }

                        /* 模块描述 */
                        .module-description {
                            font-family: 'ZCOOL XiaoWei', serif;
                            font-size: 1em;
                            text-align: center;
                            line-height: 1.4;
                            opacity: 0.95;
                            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
                        }

                        /* 小模块描述 */
                        .small-module .module-description {
                            font-size: 0.9em;
                            line-height: 1.3;
                        }

                        /* 模块悬停效果 - 光影效果 */
                        .function-module:hover {
                            transform: translateY(-8px) scale(1.05);
                            box-shadow:
                                0 20px 40px rgba(0, 0, 0, 0.2),
                                0 0 40px rgba(255, 255, 255, 0.5),
                                inset 0 1px 1px rgba(255, 255, 255, 0.6);
                            border-color: rgba(255, 255, 255, 0.7);
                        }

                        .small-module:hover {
                            transform: translateY(-5px) scale(1.03);
                        }

                        /* 模块点击效果 */
                        .function-module:active {
                            transform: translateY(-3px) scale(0.98);
                            transition: all 0.1s ease;
                        }

                        /* 模块光晕效果 */
                        .function-module::before {
                            content: '';
                            position: absolute;
                            top: 0;
                            left: -100%;
                            width: 100%;
                            height: 100%;
                            background: linear-gradient(90deg,
                                    transparent,
                                    rgba(255, 255, 255, 0.3),
                                    transparent);
                            transition: left 0.6s ease;
                        }

                        .function-module:hover::before {
                            left: 100%;
                        }

                        /* 返回首页按钮 */
                        .back-home {
                            position: fixed;
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
                        }

                        .back-home:hover {
                            background: rgba(30, 58, 95, 0.9);
                            transform: translateY(-3px);
                            box-shadow:
                                0 8px 25px rgba(43, 108, 176, 0.4),
                                0 0 20px rgba(43, 108, 176, 0.3);
                        }

                        /* 响应式设计 */
                        @media (max-width: 1200px) {
                            .main-container {
                                width: 95%;
                                height: calc(100vh - 220px);
                                margin-top: 160px;
                            }

                            .large-modules-container {
                                gap: 25px;
                            }

                            .small-modules-container {
                                gap: 15px;
                            }

                            .large-module {
                                width: 280px;
                                height: 230px;
                            }

                            .module-icon {
                                width: 60px;
                                height: 60px;
                                font-size: 1.8em;
                            }

                            .small-module .module-icon {
                                width: 45px;
                                height: 45px;
                                font-size: 1.5em;
                            }

                            .module-title {
                                font-size: 1.6em;
                            }

                            .small-module .module-title {
                                font-size: 1.3em;
                            }

                            .rank-indicator {
                                padding: 12px 25px;
                            }

                            .rank-item {
                                min-width: 90px;
                            }

                            .rank-value {
                                font-size: 1.6em;
                            }
                        }

                        @media (max-width: 992px) {
                            .small-modules-container {
                                grid-template-columns: repeat(2, 1fr);
                                grid-template-rows: repeat(2, 1fr);
                                gap: 15px;
                                height: 50%;
                            }

                            .large-modules-container {
                                margin-bottom: 30px;
                            }

                            .main-container {
                                height: 80vh;
                                overflow-y: auto;
                                padding-bottom: 20px;
                            }

                            /* 在移动端允许垂直滚动 */
                            body.mobile-view {
                                overflow-y: auto;
                            }

                            body.mobile-view .main-container {
                                height: auto;
                                min-height: calc(100vh - 200px);
                            }

                            .rank-indicator {
                                flex-direction: column;
                                gap: 10px;
                                border-radius: 20px;
                                width: 200px;
                            }

                            .rank-item {
                                min-width: auto;
                            }
                        }

                        @media (max-width: 768px) {
                            .main-container {
                                margin-top: 180px;
                                padding: 0 15px;
                            }

                            .large-modules-container {
                                flex-direction: column;
                                gap: 20px;
                                margin-bottom: 25px;
                            }

                            .large-module {
                                width: 100%;
                                max-width: 400px;
                                height: 200px;
                            }

                            .small-modules-container {
                                gap: 12px;
                            }

                            .function-module {
                                padding: 20px 15px;
                                border-radius: 15px;
                            }

                            .module-icon {
                                width: 55px;
                                height: 55px;
                                font-size: 1.6em;
                                margin-bottom: 15px;
                            }

                            .small-module .module-icon {
                                width: 40px;
                                height: 40px;
                                font-size: 1.4em;
                            }

                            .module-title {
                                font-size: 1.4em;
                            }

                            .small-module .module-title {
                                font-size: 1.2em;
                            }

                            .module-description {
                                font-size: 0.9em;
                                line-height: 1.3;
                            }

                            .small-module .module-description {
                                font-size: 0.85em;
                            }

                            .corner-logo {
                                top: 20px;
                                left: 20px;
                            }

                            .logo-text {
                                font-size: 1.8em;
                            }

                            .auth-buttons {
                                top: 20px;
                                right: 20px;
                                flex-direction: column;
                                gap: 10px;
                            }

                            .auth-btn {
                                padding: 8px 20px;
                                font-size: 0.9em;
                            }

                            .rank-indicator {
                                top: 140px;
                                padding: 10px 20px;
                            }

                            .back-home {
                                bottom: 20px;
                                left: 20px;
                                padding: 8px 20px;
                                font-size: 0.9em;
                            }
                        }

                        @media (max-width: 480px) {
                            .main-container {
                                margin-top: 200px;
                            }

                            .small-modules-container {
                                grid-template-columns: 1fr;
                                grid-template-rows: repeat(4, 1fr);
                                height: 60%;
                                gap: 10px;
                            }

                            .function-module {
                                padding: 18px 12px;
                            }

                            .module-icon {
                                width: 45px;
                                height: 45px;
                                font-size: 1.4em;
                            }

                            .small-module .module-icon {
                                width: 35px;
                                height: 35px;
                                font-size: 1.2em;
                            }

                            .module-title {
                                font-size: 1.2em;
                            }

                            .small-module .module-title {
                                font-size: 1.1em;
                            }

                            .module-description {
                                font-size: 0.85em;
                                line-height: 1.2;
                            }

                            .small-module .module-description {
                                font-size: 0.8em;
                            }

                            .corner-logo {
                                left: 15px;
                            }

                            .logo-text {
                                font-size: 1.6em;
                            }

                            .rank-indicator {
                                top: 160px;
                                width: 180px;
                            }
                        }
                    </style>
            </head>

            <body>
                <!-- 蓝天白云背景 -->
                <div class="sky-background">
                    <div class="sun-glow"></div>
                    <!-- 添加云朵 -->
                    <div class="cloud cloud-1">
                        <div class="cloud-part"></div>
                    </div>
                    <div class="cloud cloud-2">
                        <div class="cloud-part"></div>
                    </div>
                    <div class="cloud cloud-3">
                        <div class="cloud-part"></div>
                    </div>
                    <div class="cloud cloud-4">
                        <div class="cloud-part"></div>
                    </div>
                </div>

                <!-- 左上角logo - 无框设计 -->
                <div class="corner-logo">
                    <div class="logo-text">智选志愿</div>
                    <div class="sub-logo">INTELLIGENT SELECTION</div>
                </div>

                <!-- 右上角登录注册按钮 -->
                <div class="auth-buttons">
                    <% if (isLoggedIn) { %>
                        <span class="user-welcome">欢迎, <%= username %></span>
                        <a href="logout" class="auth-btn">退出</a>
                        <% } else { %>
                            <button class="auth-btn login-btn" id="loginBtn">登录</button>
                            <button class="auth-btn" id="registerBtn">注册</button>
                            <% } %>
                </div>

                <!-- 用户信息区域 - 在登录按钮下方 -->
                <div class="user-info-section" id="userInfoSection">
                    <button class="input-score-btn" id="inputScoreBtn">
                        <% if (userScore !=null) { %>
                            我的成绩: <%= userScore %>分
                                <% } else { %>
                                    输入成绩
                                    <% } %>
                    </button>
                    <div class="input-hint">
                        <% if (userScore !=null && userProvince !=null) { %>
                            <%= userProvince %> | <%= userSubject !=null ? userSubject : "未设置选科" %>
                                    <% } else { %>
                                        点击输入成绩，获取个性化推荐
                                        <% } %>
                    </div>
                </div>

                <!-- 冲稳保指标 - 初始显示占位符 -->
                <div class="rank-indicator" id="rankIndicator">
                    <div class="rank-item rank-impact">
                        <span class="rank-value">--</span>
                        <span class="rank-label">可冲击</span>
                    </div>
                    <div class="rank-item rank-safe">
                        <span class="rank-value">--</span>
                        <span class="rank-label">较稳妥</span>
                    </div>
                    <div class="rank-item rank-backup">
                        <span class="rank-value">--</span>
                        <span class="rank-label">可保底</span>
                    </div>
                </div>

                <!-- 输入成绩的模态框 -->
                <div class="score-input-modal" id="scoreInputModal">
                    <div class="modal-content">
                        <button class="close-modal" id="closeModal">×</button>
                        <h3 class="modal-title">输入成绩信息</h3>

                        <div class="input-group">
                            <label for="province">选择省份</label>
                            <select id="province">
                                <option value="">请选择省份</option>
                                <option value="北京">北京</option>
                                <option value="天津">天津</option>
                                <option value="河北">河北</option>
                                <option value="山西">山西</option>
                                <option value="内蒙古">内蒙古</option>
                                <option value="辽宁">辽宁</option>
                                <option value="吉林">吉林</option>
                                <option value="黑龙江">黑龙江</option>
                                <option value="上海">上海</option>
                                <option value="江苏">江苏</option>
                                <option value="浙江">浙江</option>
                                <option value="安徽">安徽</option>
                                <option value="福建">福建</option>
                                <option value="江西">江西</option>
                                <option value="山东">山东</option>
                                <option value="河南">河南</option>
                                <option value="湖北">湖北</option>
                                <option value="湖南">湖南</option>
                                <option value="广东">广东</option>
                                <option value="广西">广西</option>
                                <option value="海南">海南</option>
                                <option value="重庆">重庆</option>
                                <option value="四川">四川</option>
                                <option value="贵州">贵州</option>
                                <option value="云南">云南</option>
                                <option value="西藏">西藏</option>
                                <option value="陕西">陕西</option>
                                <option value="甘肃">甘肃</option>
                                <option value="青海">青海</option>
                                <option value="宁夏">宁夏</option>
                                <option value="新疆">新疆</option>
                            </select>
                        </div>

                        <div class="input-group">
                            <label for="subject">选择选科</label>
                            <select id="subject">
                                <option value="">请选择选科</option>
                                <option value="物化生">物化生</option>
                                <option value="物化地">物化地</option>
                                <option value="物生地">物生地</option>
                                <option value="历政地">历政地</option>
                                <option value="历化政">历化政</option>
                                <option value="历生地">历生地</option>
                            </select>
                        </div>
                        <!-- 新增偏好选择 -->
                        <div class="input-group">
                            <label for="preference">专业偏好</label>
                            <select id="preference">
                                <option value="">请选择专业偏好</option>
                                <option value="工科">工科</option>
                                <option value="理学">理学</option>
                                <option value="文学">文学</option>
                                <option value="医学">医学</option>
                                <option value="财经">财经</option>
                                <option value="师范">师范</option>
                                <option value="农学">农学</option>
                                <option value="艺术">艺术</option>
                            </select>
                        </div>


                        <div class="input-group">
                            <label for="score">高考分数</label>
                            <input type="number" id="score" placeholder="请输入高考分数" min="0" max="750">
                        </div>

                        <!-- 全省排名字段已移除，由系统根据一分一段表自动计算 -->

                        <div class="modal-buttons">
                            <button class="modal-btn btn-cancel" id="cancelBtn">取消</button>
                            <button class="modal-btn btn-submit" id="submitBtn">确定</button>
                        </div>
                    </div>
                </div>

                <!-- 主内容区域 -->
                <div class="main-container" id="mainContainer">
                    <!-- 上面：两个大模块在中间 -->
                    <div class="large-modules-container">
                        <a href="/1SmartMajors.jsp" class="function-module large-module module-blue"
                            id="smartSelection">
                            <div class="module-icon">🎯</div>
                            <h2 class="module-title">智能选志愿</h2>
                            <p class="module-description">根据您的信息智能推荐院校和专业</p>
                        </a>

                        <a href="/MyIdea.jsp" class="function-module large-module module-green" id="myVolunteer">
                            <div class="module-icon">📋</div>
                            <h2 class="module-title">我的志愿表</h2>
                            <p class="module-description">管理收藏的院校和专业方案</p>
                        </a>
                    </div>

                    <!-- 下面：四个小模块 -->
                    <div class="small-modules-container">
                        <a href="/1University.jsp" class="function-module small-module module-purple"
                            id="searchUniversity">
                            <div class="module-icon">🏫</div>
                            <h2 class="module-title">查大学</h2>
                            <p class="module-description">高校信息查询与对比</p>
                        </a>

                        <a href="/1SearchMajor.jsp" class="function-module small-module module-orange" id="searchMajor">
                            <div class="module-icon">📚</div>
                            <h2 class="module-title">查专业</h2>
                            <p class="module-description">专业详情与就业前景</p>
                        </a>

                        <a href="/1SameScore.jsp" class="function-module small-module module-pink" id="sameScore">
                            <div class="module-icon">📊</div>
                            <h2 class="module-title">同分去向</h2>
                            <p class="module-description">查看相同分数考生去向</p>
                        </a>

                        <a href="/1segment.jsp" class="function-module small-module module-teal" id="provincialLine">
                            <div class="module-icon">📈</div>
                            <h2 class="module-title">一分一段</h2>
                            <p class="module-description">全省分数段人数分布速查</p>
                        </a>
                    </div>
                </div>

                <!-- 返回首页按钮 -->
                <a href="index.jsp" class="back-home">返回首页</a>

                <script>
                    // 页面加载动画
                    $(document).ready(function () {
                        // 检测是否为移动设备
                        const isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
                        if (isMobile) {
                            $('body').addClass('mobile-view');
                        }

                        // 如果用户有分数，加载冲稳保数据
                        <% if (userScore != null && userScore > 0) { %>
                            $.ajax({
                                url: '/api/analysis/strategy',
                                type: 'GET',
                                data: {
                                    score: <%= userScore %>,
                                province: '<%= userProvince != null ? userProvince : "" %>'
                            },
                                dataType: 'json',
                                success: function (strategyData) {
                                    if (strategyData.success) {
                                        $('#rankIndicator').find('.rank-impact .rank-value').text(strategyData.impactCount);
                                        $('#rankIndicator').find('.rank-safe .rank-value').text(strategyData.safeCount);
                                        $('#rankIndicator').find('.rank-backup .rank-value').text(strategyData.backupCount);
                                        $('#rankIndicator').addClass('has-data');
                                    }
                                }
                        });
                        <% } %>

                        // 初始状态设置
                        $('.corner-logo').css({
                            'opacity': '0',
                            'transform': 'translateX(-30px) translateY(-15px)'
                        });

                    $('.auth-buttons').css({
                        'opacity': '0',
                        'transform': 'translateX(30px) translateY(-15px)'
                    });

                    $('.user-info-section').css({
                        'opacity': '0',
                        'transform': 'translateX(30px) translateY(-10px)'
                    });

                    $('.rank-indicator').css({
                        'opacity': '0.3', // 初始半透明
                        'transform': 'translateX(-50%) scale(0.8) translateY(-20px)'
                    });

                    $('.large-module').css({
                        'opacity': '0',
                        'transform': 'translateY(40px) scale(0.95)'
                    });

                    $('.small-module').css({
                        'opacity': '0',
                        'transform': 'translateY(30px) scale(0.97)'
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
                        $('.auth-buttons').css({
                            'opacity': '1',
                            'transform': 'translateX(0) translateY(0)',
                            'transition': 'all 0.8s cubic-bezier(0.34, 1.56, 0.64, 1)'
                        });
                    }, 500);

                    setTimeout(() => {
                        $('.user-info-section').css({
                            'opacity': '1',
                            'transform': 'translateX(0) translateY(0)',
                            'transition': 'all 0.8s cubic-bezier(0.34, 1.56, 0.64, 1)'
                        });
                    }, 700);

                    setTimeout(() => {
                        $('.rank-indicator').css({
                            'transform': 'translateX(-50%) scale(0.8) translateY(0)',
                            'transition': 'all 0.6s ease'
                        });
                    }, 900);

                    // 大模块动画
                    setTimeout(() => {
                        $('.large-module').each(function (index) {
                            $(this).css({
                                'opacity': '1',
                                'transform': 'translateY(0) scale(1)',
                                'transition': `all 0.7s cubic-bezier(0.34, 1.56, 0.64, 1) ${index * 0.2}s`
                            });
                        });
                    }, 1100);

                    // 小模块动画
                    setTimeout(() => {
                        $('.small-module').each(function (index) {
                            $(this).css({
                                'opacity': '1',
                                'transform': 'translateY(0) scale(1)',
                                'transition': `all 0.7s cubic-bezier(0.34, 1.56, 0.64, 1) ${index * 0.1}s`
                            });
                        });
                    }, 1400);

                    // 返回按钮动画
                    setTimeout(() => {
                        $('.back-home').css({
                            'opacity': '1',
                            'transform': 'translateX(0)',
                            'transition': 'all 0.6s ease'
                        });
                    }, 1700);

                    // 输入成绩按钮点击事件
                    $('#inputScoreBtn').click(function () {
                        $('#scoreInputModal').fadeIn();
                    });

                    // 关闭模态框
                    $('#closeModal, #cancelBtn').click(function () {
                        $('#scoreInputModal').fadeOut();
                    });

                    // 点击模态框外部关闭
                    $('#scoreInputModal').click(function (e) {
                        if (e.target === this) {
                            $(this).fadeOut();
                        }
                    });

                    // 重置状态函数
                    function resetScoreData() {
                        // 重置冲稳保显示
                        $('#rankIndicator').find('.rank-impact .rank-value').text('--');
                        $('#rankIndicator').find('.rank-safe .rank-value').text('--');
                        $('#rankIndicator').find('.rank-backup .rank-value').text('--');

                        // 移除has-data类，恢复到初始状态
                        $('#rankIndicator').removeClass('has-data');

                        // 重置按钮文本
                        $('#inputScoreBtn').text('输入成绩');
                    }

                    // 输入成绩按钮点击事件（含重置逻辑）
                    $('#inputScoreBtn').click(function () {
                        const currentText = $(this).text();
                        if (currentText === '修改成绩') {
                            // 如果当前已有数据，点击修改成绩时重置状态
                            resetScoreData();
                        }
                        $('#scoreInputModal').fadeIn();
                    });

                    // 提交成绩信息
                    $('#submitBtn').click(function () {
                        // 获取表单数据
                        const province = $('#province').val();
                        const subject = $('#subject').val();
                        const preference = $('#preference').val();
                        const score = $('#score').val();

                        // 简单验证
                        if (!province || !score) {
                            alert('请至少填写省份和分数！');
                            return;
                        }

                        // 调用后端API保存成绩信息
                        $.ajax({
                            url: '/api/user/score',
                            type: 'POST',
                            data: {
                                province: province,
                                subject: subject,
                                preference: preference,
                                score: score
                            },
                            dataType: 'json',
                            success: function (data) {
                                if (data.success) {
                                    // 调用真实API获取冲稳保数据
                                    $.ajax({
                                        url: '/api/analysis/strategy',
                                        type: 'GET',
                                        data: { score: score, province: province },
                                        dataType: 'json',
                                        success: function (strategyData) {
                                            if (strategyData.success) {
                                                $('#rankIndicator').find('.rank-impact .rank-value').text(strategyData.impactCount);
                                                $('#rankIndicator').find('.rank-safe .rank-value').text(strategyData.safeCount);
                                                $('#rankIndicator').find('.rank-backup .rank-value').text(strategyData.backupCount);
                                                $('#rankIndicator').addClass('has-data');
                                            }
                                        }
                                    });

                                    // 关闭模态框
                                    $('#scoreInputModal').fadeOut();

                                    // 刷新页面以显示更新后的session信息
                                    setTimeout(function () {
                                        location.reload();
                                    }, 500);
                                } else {
                                    alert(data.message || '保存失败');
                                }
                            },
                            error: function () {
                                alert('网络错误，请重试');
                            }
                        });
                    });

                    // 模块点击效果 - 使用mousedown添加视觉反馈，不阻止链接跳转
                    $('.function-module').on('mousedown', function () {
                        $(this).css({
                            'transform': $(this).hasClass('large-module') ? 'translateY(-5px) scale(0.98)' : 'translateY(-3px) scale(0.98)',
                            'transition': 'all 0.1s ease'
                        });
                    }).on('mouseup mouseleave', function () {
                        $(this).css({
                            'transform': 'translateY(0) scale(1)',
                            'transition': 'all 0.3s ease'
                        });
                    });
                    // 点击时直接跳转（<a>标签的href会自动处理）

                    // 登录注册按钮点击事件
                    $('#loginBtn').click(function () {
                        console.log('点击登录按钮');
                        window.location.href = 'login.jsp';
                    });

                    $('#registerBtn').click(function () {
                        console.log('点击注册按钮');
                        window.location.href = 'register.jsp';
                    });

                    // 在桌面端禁止页面滚动
                    if (!isMobile) {
                        $('body').on('wheel', function (e) {
                            if (e.originalEvent.deltaY !== 0) {
                                e.preventDefault();
                            }
                        });

                        document.body.style.overflow = 'hidden';
                        document.documentElement.style.overflow = 'hidden';
                    }
                    });
                </script>
            </body>

            </html>