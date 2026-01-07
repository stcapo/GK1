<%--
  Created by IntelliJ IDEA.
  User: 35389
  Date: 2025/6/19
  Time: 11:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>智选志愿</title>
    <%--引入jquery工具类--%>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Ma+Shan+Zheng&family=ZCOOL+QingKe+HuangYou&family=ZCOOL+XiaoWei&display=swap" rel="stylesheet">
    <style>
        /* 全局样式 - 蓝天白云背景 */
        body {
            margin: 0;
            padding: 0;
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
            top: 15%;
            left: 10%;
            border-radius: 60px;
            animation: cloudFloat1 15s ease-in-out infinite alternate;
            box-shadow:
                    0 0 25px rgba(255, 255, 255, 0.9),
                    inset 0 0 12px rgba(255, 255, 255, 0.8);
        }

        /* 使用伪元素创建云朵的圆形部分 */
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

        /* 左边圆形部分 */
        .cloud-1::before {
            width: 80px;
            height: 80px;
            top: -40px;
            left: 15px;
        }

        /* 中间圆形部分 */
        .cloud-1::after {
            width: 100px;
            height: 100px;
            top: -50px;
            left: 60px;
        }

        /* 右边圆形部分 */
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
            top: 30%;
            right: 15%;
            border-radius: 70px;
            animation: cloudFloat2 18s ease-in-out infinite alternate;
            animation-delay: 2s;
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
            top: 55%;
            left: 20%;
            border-radius: 55px;
            animation: cloudFloat3 16s ease-in-out infinite alternate;
            animation-delay: 4s;
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
            top: 70%;
            right: 10%;
            border-radius: 65px;
            animation: cloudFloat4 20s ease-in-out infinite alternate;
            animation-delay: 6s;
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

        /* 云朵5 - 上面的中间 */
        .cloud-5 {
            width: 170px;
            height: 58px;
            top: 10%;
            left: 50%;
            transform: translateX(-50%);
            border-radius: 58px;
            animation: cloudFloat5 14s ease-in-out infinite alternate;
            animation-delay: 1s;
            box-shadow:
                    0 0 20px rgba(255, 255, 255, 0.9),
                    inset 0 0 10px rgba(255, 255, 255, 0.8);
        }

        .cloud-5::before,
        .cloud-5::after {
            content: '';
            position: absolute;
            background: rgba(255, 255, 255, 0.94);
            border-radius: 50%;
            box-shadow:
                    0 0 14px rgba(255, 255, 255, 0.8),
                    inset 0 0 7px rgba(255, 255, 255, 0.9);
        }

        .cloud-5::before {
            width: 75px;
            height: 75px;
            top: -37px;
            left: 12px;
        }

        .cloud-5::after {
            width: 90px;
            height: 90px;
            top: -45px;
            left: 65px;
        }

        .cloud-5 .cloud-part {
            position: absolute;
            width: 65px;
            height: 65px;
            background: rgba(255, 255, 255, 0.94);
            border-radius: 50%;
            top: -32px;
            left: 115px;
            box-shadow:
                    0 0 14px rgba(255, 255, 255, 0.8),
                    inset 0 0 7px rgba(255, 255, 255, 0.9);
        }

        /* 云朵6 - 左下角 */
        .cloud-6 {
            width: 190px;
            height: 62px;
            top: 85%;
            left: 5%;
            border-radius: 62px;
            animation: cloudFloat6 17s ease-in-out infinite alternate;
            animation-delay: 3s;
            box-shadow:
                    0 0 23px rgba(255, 255, 255, 0.9),
                    inset 0 0 11px rgba(255, 255, 255, 0.8);
        }

        .cloud-6::before,
        .cloud-6::after {
            content: '';
            position: absolute;
            background: rgba(255, 255, 255, 0.91);
            border-radius: 50%;
            box-shadow:
                    0 0 16px rgba(255, 255, 255, 0.8),
                    inset 0 0 8px rgba(255, 255, 255, 0.9);
        }

        .cloud-6::before {
            width: 82px;
            height: 82px;
            top: -41px;
            left: 18px;
        }

        .cloud-6::after {
            width: 95px;
            height: 95px;
            top: -47px;
            left: 75px;
        }

        .cloud-6 .cloud-part {
            position: absolute;
            width: 72px;
            height: 72px;
            background: rgba(255, 255, 255, 0.91);
            border-radius: 50%;
            top: -36px;
            left: 130px;
            box-shadow:
                    0 0 16px rgba(255, 255, 255, 0.8),
                    inset 0 0 8px rgba(255, 255, 255, 0.9);
        }

        /* 云朵小范围浮动动画 */
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

        /* 云朵5动画 - 上面的中间 */
        @keyframes cloudFloat5 {
            0% {
                transform: translateX(-50%) translateY(0);
            }
            25% {
                transform: translateX(calc(-50% + 10px)) translateY(-8px);
            }
            50% {
                transform: translateX(calc(-50% - 5px)) translateY(6px);
            }
            75% {
                transform: translateX(calc(-50% + 8px)) translateY(-4px);
            }
            100% {
                transform: translateX(calc(-50% - 3px)) translateY(9px);
            }
        }

        /* 云朵6动画 - 左下角 */
        @keyframes cloudFloat6 {
            0% {
                transform: translate(0, 0);
            }
            30% {
                transform: translate(12px, -6px);
            }
            50% {
                transform: translate(-8px, 4px);
            }
            70% {
                transform: translate(6px, 10px);
            }
            100% {
                transform: translate(-10px, -8px);
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

        /* 左上角logo */
        .corner-logo {
            position: absolute;
            top: 30px;
            left: 40px;
            z-index: 10;
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(8px);
            padding: 15px 25px;
            border-radius: 12px;
            box-shadow:
                    0 4px 15px rgba(0, 0, 0, 0.15),
                    inset 0 1px 1px rgba(255, 255, 255, 0.3);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .logo-text {
            font-family: 'Ma Shan Zheng', cursive;
            font-size: 3.2em;
            color: #1E3A5F;
            text-shadow:
                    2px 2px 4px rgba(0, 0, 0, 0.1),
                    0 0 10px rgba(255, 255, 255, 0.5);
            position: relative;
            display: inline-block;
            letter-spacing: 3px;
        }

        .logo-text::before {
            content: '';
            position: absolute;
            top: -5px;
            left: -10px;
            right: -10px;
            bottom: -5px;
            background: linear-gradient(45deg,
            transparent 0%,
            rgba(255, 255, 255, 0.2) 50%,
            transparent 100%
            );
            border-radius: 5px;
            z-index: -1;
        }

        .sub-logo {
            font-family: 'ZCOOL QingKe HuangYou', sans-serif;
            font-size: 1.2em;
            color: #2C5282;
            margin-top: 8px;
            letter-spacing: 4px;
            font-weight: 300;
            text-shadow: 1px 1px 2px rgba(255, 255, 255, 0.6);
        }

        /* 纸飞机容器 */
        .paper-plane-container {
            position: absolute;
            top: 40%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 5;
            transition: transform 0.3s ease;
        }

        /* 白色纸飞机 */
        .paper-plane {
            width: 120px;
            height: 120px;
            position: relative;
            animation: planeFloat 3s ease-in-out infinite;
            filter: drop-shadow(0 4px 8px rgba(0, 0, 0, 0.2));
        }

        .paper-plane::before,
        .paper-plane::after {
            content: '';
            position: absolute;
            background: white;
            border-radius: 3px;
            box-shadow:
                    inset 0 0 15px rgba(0, 0, 0, 0.1),
                    0 4px 12px rgba(0, 0, 0, 0.15);
        }

        .paper-plane::before {
            width: 120px;
            height: 25px;
            top: 60px;
            left: 0;
            transform: rotate(-45deg);
            transform-origin: left center;
            background: linear-gradient(to right, #fff 0%, #f0f8ff 100%);
        }

        .paper-plane::after {
            width: 100px;
            height: 25px;
            top: 60px;
            left: 20px;
            transform: rotate(45deg);
            transform-origin: left center;
            background: linear-gradient(to right, #f0f8ff 0%, #fff 100%);
        }

        /* 飞机尾翼 */
        .plane-tail {
            position: absolute;
            width: 40px;
            height: 18px;
            background: white;
            top: 70px;
            left: -20px;
            transform: rotate(90deg);
            border-radius: 3px;
            box-shadow:
                    inset 0 0 8px rgba(0, 0, 0, 0.1),
                    0 2px 6px rgba(0, 0, 0, 0.15);
        }

        @keyframes planeFloat {
            0%, 100% {
                transform: translateY(0) rotate(0deg);
            }
            50% {
                transform: translateY(-15px) rotate(3deg);
            }
        }

        /* 跟随句子 - 位置上移，避免被按钮遮挡 */
        .following-sentence {
            position: absolute;
            top: calc(40% + 90px);
            left: 50%;
            transform: translateX(-50%);
            font-size: 2.4em;
            color: #1E3A5F;
            font-weight: 600;
            text-shadow:
                    2px 2px 4px rgba(0, 0, 0, 0.15),
                    0 0 15px rgba(255, 255, 255, 0.7);
            white-space: nowrap;
            animation: sentenceFloat 3s ease-in-out infinite;
            font-family: 'ZCOOL XiaoWei', serif;
            letter-spacing: 2px;
            background: rgba(255, 255, 255, 0.25);
            backdrop-filter: blur(5px);
            padding: 12px 30px;
            border-radius: 30px;
            border: 2px solid rgba(255, 255, 255, 0.4);
            box-shadow:
                    0 4px 15px rgba(0, 0, 0, 0.1),
                    inset 0 1px 1px rgba(255, 255, 255, 0.3);
        }

        @keyframes sentenceFloat {
            0%, 100% {
                opacity: 0.95;
                transform: translateX(-50%) translateY(0);
            }
            50% {
                opacity: 1;
                transform: translateX(-50%) translateY(-8px);
                text-shadow:
                        3px 3px 6px rgba(0, 0, 0, 0.2),
                        0 0 20px rgba(255, 255, 255, 0.9);
            }
        }

        /* 中心按钮容器 - 位置下移 */
        .center-button-container {
            position: absolute;
            top: 70%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 6;
        }

        /* 智慧选择按钮 - 简化版本，去掉所有光影效果 */
        .wisdom-button {
            background: linear-gradient(135deg,
            #2B6CB0 0%,
            #2C5282 50%,
            #2B6CB0 100%
            );
            color: white;
            border: none;
            padding: 28px 70px;
            font-size: 2.4em;
            font-family: 'ZCOOL QingKe HuangYou', sans-serif;
            font-weight: 400;
            border-radius: 60px;
            cursor: pointer;
            position: relative;
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            letter-spacing: 3px;
            text-shadow: 0 1px 3px rgba(0, 0, 0, 0.3);
            text-decoration: none;
            display: inline-block;
            animation: none;
        }

        .wisdom-button:hover {
            transform: scale(1.08);
            background: linear-gradient(135deg,
            #2C5282 0%,
            #1E3A5F 50%,
            #2C5282 100%
            );
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        }

        /* 点击时效果 - 颜色变深 */
        .wisdom-button:active {
            background: linear-gradient(135deg,
            #1E3A5F 0%,
            #0F172A 50%,
            #1E3A5F 100%
            );
            transform: scale(0.98);
            transition: all 0.1s ease;
        }

        .wisdom-button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg,
            transparent,
            rgba(255, 255, 255, 0.2),
            transparent
            );
            transition: left 0.6s ease;
        }

        .wisdom-button:hover::before {
            left: 100%;
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .corner-logo {
                top: 20px;
                left: 20px;
                padding: 12px 20px;
            }

            .logo-text {
                font-size: 2.5em;
            }

            .sub-logo {
                font-size: 1em;
            }

            .sun-glow {
                width: 80px;
                height: 80px;
                top: 5%;
                right: 5%;
            }

            .paper-plane {
                width: 100px;
                height: 100px;
            }

            .paper-plane::before {
                width: 100px;
                height: 20px;
                top: 50px;
            }

            .paper-plane::after {
                width: 80px;
                height: 20px;
                top: 50px;
                left: 20px;
            }

            .plane-tail {
                top: 60px;
                width: 35px;
                height: 15px;
            }

            .following-sentence {
                font-size: 1.8em;
                top: calc(40% + 70px);
                padding: 10px 25px;
            }

            .center-button-container {
                top: 72%;
            }

            .wisdom-button {
                padding: 22px 50px;
                font-size: 1.8em;
            }
        }

        @media (max-width: 480px) {
            .corner-logo {
                top: 15px;
                left: 15px;
                padding: 10px 15px;
            }

            .logo-text {
                font-size: 2em;
            }

            .sub-logo {
                font-size: 0.9em;
            }

            .sun-glow {
                width: 60px;
                height: 60px;
            }

            .paper-plane {
                width: 80px;
                height: 80px;
            }

            .paper-plane::before {
                width: 80px;
                height: 16px;
                top: 40px;
            }

            .paper-plane::after {
                width: 60px;
                height: 16px;
                top: 40px;
                left: 20px;
            }

            .plane-tail {
                top: 48px;
                width: 30px;
                height: 12px;
            }

            .following-sentence {
                font-size: 1.4em;
                top: calc(40% + 55px);
                padding: 8px 20px;
            }

            .center-button-container {
                top: 75%;
            }

            .wisdom-button {
                padding: 18px 35px;
                font-size: 1.4em;
            }
        }
    </style>
</head>
<body>
<!-- 蓝天白云背景 -->
<div class="sky-background">
    <div class="sun-glow"></div>
    <div class="cloud cloud-1"><div class="cloud-part"></div></div>
    <div class="cloud cloud-2"><div class="cloud-part"></div></div>
    <div class="cloud cloud-3"><div class="cloud-part"></div></div>
    <div class="cloud cloud-4"><div class="cloud-part"></div></div>
    <div class="cloud cloud-5"><div class="cloud-part"></div></div>
    <div class="cloud cloud-6"><div class="cloud-part"></div></div>
</div>

<!-- 左上角logo -->
<div class="corner-logo">
    <div class="logo-text">智选志愿</div>
    <div class="sub-logo">INTELLIGENT SELECTION</div>
</div>

<!-- 白色纸飞机 -->
<div class="paper-plane-container">
    <div class="paper-plane">
        <div class="plane-tail"></div>
    </div>
</div>

<!-- 跟随句子 -->
<div class="following-sentence">以青春之笔，绘就未来蓝图</div>

<!-- 中心按钮 -->
<div class="center-button-container">
    <a href="login.jsp" class="wisdom-button" id="mainPageLink">
        智慧选择
    </a>
</div>

<script>
    // 纸飞机鼠标跟随效果
    function initPlaneFollow() {
        const planeContainer = $('.paper-plane-container');

        $(document).mousemove(function(e) {
            const mouseX = e.pageX / $(window).width();
            const mouseY = e.pageY / $(window).height();

            // 计算跟随偏移
            const offsetX = (mouseX - 0.5) * 60;
            const offsetY = (mouseY - 0.4) * 50;

            planeContainer.css({
                'transform': `translate(calc(-50% + ${offsetX}px), calc(-50% + ${offsetY}px))`,
                'transition': 'transform 0.15s ease'
            });
        });

        $(document).mouseleave(function() {
            planeContainer.css({
                'transform': 'translate(-50%, -50%)',
                'transition': 'transform 0.3s ease'
            });
        });
    }

    // 简化的按钮点击效果
    function initButtonClick() {
        const button = $('.wisdom-button');

        button.click(function(e) {
            // 防止重复点击
            if ($(this).hasClass('clicking')) return;
            $(this).addClass('clicking');

            // 简单的点击反馈
            $(this).css({
                'transform': 'scale(0.95)',
                'opacity': '0.9',
                'transition': 'all 0.2s ease'
            });

            // 延迟跳转，让用户看到点击反馈
            setTimeout(() => {
                $(this).css({
                    'transform': 'scale(1)',
                    'opacity': '1',
                    'transition': 'all 0.2s ease'
                });

                $(this).removeClass('clicking');

                // 跳转到main.jsp
                window.location.href = 'main.jsp';
            }, 200);
        });
    }

    // 页面初始化
    $(document).ready(function() {
        initPlaneFollow();
        initButtonClick();
        // 不再创建额外的云朵

        // 页面加载动画
        $('.corner-logo').css({
            'opacity': '0',
            'transform': 'translateX(-40px) translateY(-20px)'
        });

        $('.paper-plane-container').css({
            'opacity': '0',
            'transform': 'translate(-50%, -50%) scale(0.7) rotate(-20deg)'
        });

        $('.following-sentence').css({
            'opacity': '0',
            'transform': 'translateX(-50%) translateY(30px)'
        });

        $('.center-button-container').css({
            'opacity': '0',
            'transform': 'translate(-50%, -50%) scale(0.7)'
        });

        $('.sun-glow').css({
            'opacity': '0',
            'transform': 'scale(0.5)'
        });

        setTimeout(() => {
            $('.corner-logo').css({
                'opacity': '1',
                'transform': 'translateX(0) translateY(0)',
                'transition': 'all 1s cubic-bezier(0.34, 1.56, 0.64, 1)'
            });
        }, 300);

        setTimeout(() => {
            $('.sun-glow').css({
                'opacity': '1',
                'transform': 'scale(1)',
                'transition': 'all 1.2s ease'
            });
        }, 500);

        setTimeout(() => {
            $('.paper-plane-container').css({
                'opacity': '1',
                'transform': 'translate(-50%, -50%) scale(1) rotate(0deg)',
                'transition': 'all 1s cubic-bezier(0.34, 1.56, 0.64, 1)'
            });
        }, 800);

        setTimeout(() => {
            $('.following-sentence').css({
                'opacity': '1',
                'transform': 'translateX(-50%) translateY(0)',
                'transition': 'all 1s ease'
            });
        }, 1100);

        setTimeout(() => {
            $('.center-button-container').css({
                'opacity': '1',
                'transform': 'translate(-50%, -50%) scale(1)',
                'transition': 'all 1s cubic-bezier(0.34, 1.56, 0.64, 1)'
            });
        }, 1400);
    });
</script>
</body>
</html>