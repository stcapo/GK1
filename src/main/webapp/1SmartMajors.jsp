<%-- Created by IntelliJ IDEA. User: 35389 Date: 2025/6/19 Time: 11:25 To change this template use File | Settings |
    File Templates. --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ page isELIgnored="true" %>
            <html>

            <head>
                <title>智能选志愿 - 高考志愿智能填报推荐系统</title>
                <%--引入jquery工具类--%>
                    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Ma+Shan+Zheng&family=ZCOOL+QingKe+HuangYou&family=ZCOOL+XiaoWei&display=swap"
                        rel="stylesheet">
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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

                        /* 简化云朵样式 */
                        .cloud {
                            position: absolute;
                            background: rgba(255, 255, 255, 0.95);
                            z-index: 1;
                            filter: blur(1px);
                            border-radius: 50px;
                            animation: cloudFloat 20s ease-in-out infinite alternate;
                        }

                        .cloud-1 {
                            width: 150px;
                            height: 50px;
                            top: 20%;
                            left: 5%;
                        }

                        .cloud-2 {
                            width: 180px;
                            height: 60px;
                            top: 40%;
                            right: 8%;
                            animation-delay: 5s;
                        }

                        .cloud-3 {
                            width: 130px;
                            height: 45px;
                            top: 70%;
                            left: 15%;
                            animation-delay: 10s;
                        }

                        .cloud-4 {
                            width: 160px;
                            height: 55px;
                            top: 25%;
                            right: 20%;
                            animation-delay: 15s;
                        }

                        @keyframes cloudFloat {
                            0% {
                                transform: translate(0, 0);
                            }

                            25% {
                                transform: translate(10px, -5px);
                            }

                            50% {
                                transform: translate(-5px, 3px);
                            }

                            75% {
                                transform: translate(8px, -3px);
                            }

                            100% {
                                transform: translate(-3px, 6px);
                            }
                        }

                        /* 阳光光晕 */
                        .sun-glow {
                            position: absolute;
                            top: 8%;
                            right: 8%;
                            width: 100px;
                            height: 100px;
                            background: radial-gradient(circle,
                                    rgba(255, 255, 180, 0.9) 0%,
                                    rgba(255, 255, 140, 0.7) 30%,
                                    rgba(255, 255, 100, 0.4) 60%,
                                    transparent 80%);
                            border-radius: 50%;
                            animation: sunPulse 8s ease-in-out infinite;
                            z-index: 1;
                            filter: blur(4px);
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

                        /* 页面容器 */
                        .page-container {
                            position: relative;
                            z-index: 2;
                            width: 100%;
                            height: 100%;
                            padding: 80px 20px 20px;
                            display: flex;
                            flex-direction: column;
                        }

                        /* 头部导航栏 */
                        .header-nav {
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            padding: 0 20px;
                            margin-bottom: 20px;
                        }

                        .nav-left {
                            display: flex;
                            align-items: center;
                            gap: 30px;
                        }

                        .nav-title {
                            font-family: 'Ma Shan Zheng', cursive;
                            font-size: 1.8em;
                            color: #1E3A5F;
                            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.15);
                        }

                        .nav-tabs {
                            display: flex;
                            gap: 10px;
                        }

                        .nav-tab {
                            padding: 8px 20px;
                            background: rgba(255, 255, 255, 0.9);
                            border-radius: 20px;
                            border: none;
                            font-family: 'ZCOOL XiaoWei', serif;
                            font-size: 1em;
                            color: #2C5282;
                            cursor: pointer;
                            transition: all 0.3s ease;
                            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                        }

                        .nav-tab.active {
                            background: linear-gradient(135deg, #4299E1, #2B6CB0);
                            color: white;
                            box-shadow: 0 6px 15px rgba(43, 108, 176, 0.3);
                        }

                        .nav-tab:hover {
                            transform: translateY(-2px);
                            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15);
                        }

                        .nav-right {
                            display: flex;
                            gap: 15px;
                        }

                        .nav-btn {
                            padding: 8px 20px;
                            background: rgba(255, 255, 255, 0.9);
                            border-radius: 20px;
                            border: none;
                            font-family: 'ZCOOL XiaoWei', serif;
                            font-size: 0.9em;
                            color: #1E3A5F;
                            cursor: pointer;
                            display: flex;
                            align-items: center;
                            gap: 8px;
                            transition: all 0.3s ease;
                            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                        }

                        .nav-btn:hover {
                            background: rgba(255, 255, 255, 1);
                            transform: translateY(-2px);
                            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15);
                        }

                        /* 主要内容区域 */
                        .main-content {
                            flex: 1;
                            display: flex;
                            gap: 20px;
                            padding: 0 20px;
                            height: calc(100% - 100px);
                        }

                        /* 左侧筛选面板 */
                        .filter-panel {
                            width: 280px;
                            background: rgba(255, 255, 255, 0.9);
                            border-radius: 15px;
                            padding: 20px;
                            backdrop-filter: blur(10px);
                            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
                            display: flex;
                            flex-direction: column;
                            gap: 20px;
                        }

                        .filter-section {
                            margin-bottom: 15px;
                        }

                        .section-title {
                            font-family: 'ZCOOL QingKe HuangYou', sans-serif;
                            font-size: 1.2em;
                            color: #2D3748;
                            margin-bottom: 12px;
                            padding-bottom: 8px;
                            border-bottom: 2px solid #E2E8F0;
                        }

                        .score-input-group {
                            display: flex;
                            gap: 10px;
                            margin-bottom: 15px;
                        }

                        .score-input {
                            flex: 1;
                            padding: 10px 15px;
                            border: 2px solid #CBD5E0;
                            border-radius: 10px;
                            font-size: 1em;
                            font-family: 'ZCOOL XiaoWei', serif;
                            background: white;
                            transition: all 0.3s ease;
                        }

                        .score-input:focus {
                            outline: none;
                            border-color: #4299E1;
                            box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.2);
                        }

                        .select-group {
                            width: 100%;
                        }

                        .custom-select {
                            width: 100%;
                            padding: 10px 15px;
                            border: 2px solid #CBD5E0;
                            border-radius: 10px;
                            font-size: 1em;
                            font-family: 'ZCOOL XiaoWei', serif;
                            background: white;
                            cursor: pointer;
                            transition: all 0.3s ease;
                            appearance: none;
                            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' fill='%234299E1' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
                            background-repeat: no-repeat;
                            background-position: right 15px center;
                            background-size: 12px;
                        }

                        .custom-select:focus {
                            outline: none;
                            border-color: #4299E1;
                            box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.2);
                        }

                        .checkbox-group {
                            display: flex;
                            flex-wrap: wrap;
                            gap: 10px;
                            margin-bottom: 15px;
                        }

                        .checkbox-label {
                            display: flex;
                            align-items: center;
                            gap: 6px;
                            cursor: pointer;
                            font-size: 0.9em;
                            color: #4A5568;
                        }

                        .checkbox-label input[type="checkbox"] {
                            width: 16px;
                            height: 16px;
                            border-radius: 4px;
                            border: 2px solid #CBD5E0;
                            cursor: pointer;
                        }

                        .filter-actions {
                            margin-top: auto;
                            display: flex;
                            gap: 10px;
                        }

                        .action-btn {
                            flex: 1;
                            padding: 12px;
                            border: none;
                            border-radius: 10px;
                            font-family: 'ZCOOL QingKe HuangYou', sans-serif;
                            font-size: 1em;
                            cursor: pointer;
                            transition: all 0.3s ease;
                        }

                        .primary-btn {
                            background: linear-gradient(135deg, #4299E1, #2B6CB0);
                            color: white;
                            box-shadow: 0 4px 15px rgba(66, 153, 225, 0.3);
                        }

                        .primary-btn:hover {
                            transform: translateY(-2px);
                            box-shadow: 0 6px 20px rgba(66, 153, 225, 0.4);
                        }

                        .secondary-btn {
                            background: #EDF2F7;
                            color: #4A5568;
                            border: 2px solid #CBD5E0;
                        }

                        .secondary-btn:hover {
                            background: #E2E8F0;
                            transform: translateY(-2px);
                        }

                        /* 右侧内容区域 */
                        .content-panel {
                            flex: 1;
                            background: rgba(255, 255, 255, 0.9);
                            border-radius: 15px;
                            backdrop-filter: blur(10px);
                            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
                            display: flex;
                            flex-direction: column;
                            overflow: hidden;
                        }

                        /* 策略标签栏 */
                        .strategy-tabs {
                            display: flex;
                            border-bottom: 2px solid #E2E8F0;
                            background: rgba(255, 255, 255, 0.95);
                        }

                        .strategy-tab {
                            flex: 1;
                            padding: 15px 20px;
                            text-align: center;
                            font-family: 'ZCOOL QingKe HuangYou', sans-serif;
                            font-size: 1.1em;
                            color: #718096;
                            cursor: pointer;
                            transition: all 0.3s ease;
                            border-bottom: 3px solid transparent;
                            position: relative;
                            display: flex;
                            flex-direction: column;
                            align-items: center;
                            gap: 5px;
                        }

                        .strategy-tab.active {
                            color: #1E3A5F;
                            border-bottom-color: #4299E1;
                        }

                        .strategy-count {
                            font-size: 1.3em;
                            font-weight: bold;
                        }

                        .impact .strategy-count {
                            color: #E53E3E;
                        }

                        .safe .strategy-count {
                            color: #2B6CB0;
                        }

                        .backup .strategy-count {
                            color: #38A169;
                        }

                        .strategy-label {
                            font-size: 0.9em;
                        }

                        /* 院校筛选栏 */
                        .university-filter {
                            padding: 15px 20px;
                            background: rgba(255, 255, 255, 0.95);
                            border-bottom: 1px solid #E2E8F0;
                            display: flex;
                            gap: 15px;
                            flex-wrap: wrap;
                        }

                        .filter-dropdown {
                            padding: 8px 15px;
                            border: 2px solid #CBD5E0;
                            border-radius: 8px;
                            background: white;
                            font-family: 'ZCOOL XiaoWei', serif;
                            font-size: 0.9em;
                            color: #4A5568;
                            cursor: pointer;
                            min-width: 120px;
                        }

                        .filter-dropdown:focus {
                            outline: none;
                            border-color: #4299E1;
                        }

                        /* 院校列表 */
                        .university-list {
                            flex: 1;
                            overflow-y: auto;
                            padding: 20px;
                        }

                        .loading-container {
                            text-align: center;
                            padding: 40px;
                            color: #718096;
                        }

                        .loading-container i {
                            font-size: 3em;
                            margin-bottom: 15px;
                            color: #4299E1;
                            animation: spin 1.5s linear infinite;
                        }

                        @keyframes spin {
                            0% {
                                transform: rotate(0deg);
                            }

                            100% {
                                transform: rotate(360deg);
                            }
                        }

                        .no-data {
                            text-align: center;
                            padding: 60px 20px;
                            color: #718096;
                            font-size: 1.1em;
                        }

                        .no-data i {
                            font-size: 4em;
                            margin-bottom: 20px;
                            color: #CBD5E0;
                        }

                        .university-item {
                            background: white;
                            border-radius: 10px;
                            padding: 20px;
                            margin-bottom: 15px;
                            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
                            border: 1px solid #E2E8F0;
                            transition: all 0.3s ease;
                            cursor: pointer;
                        }

                        .university-item:hover {
                            transform: translateY(-3px);
                            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
                            border-color: #4299E1;
                        }

                        .university-header {
                            display: flex;
                            justify-content: space-between;
                            align-items: flex-start;
                            margin-bottom: 15px;
                        }

                        .university-info h3 {
                            font-family: 'ZCOOL QingKe HuangYou', sans-serif;
                            font-size: 1.3em;
                            color: #1E3A5F;
                            margin-bottom: 5px;
                        }

                        .university-tags {
                            display: flex;
                            gap: 8px;
                            flex-wrap: wrap;
                        }

                        .tag {
                            padding: 4px 10px;
                            background: #EDF2F7;
                            border-radius: 12px;
                            font-size: 0.8em;
                            color: #4A5568;
                        }

                        .tag.double-first {
                            background: #FEEBC8;
                            color: #9C4221;
                        }

                        .tag.project-211 {
                            background: #C6F6D5;
                            color: #22543D;
                        }

                        .tag.public {
                            background: #BEE3F8;
                            color: #2C5282;
                        }

                        .low-score-tag {
                            display: inline-flex;
                            align-items: center;
                            gap: 4px;
                            padding: 4px 10px;
                            background: #FED7D7;
                            color: #9B2C2C;
                            border-radius: 12px;
                            font-size: 0.8em;
                            margin-left: 10px;
                        }

                        .add-button {
                            padding: 8px 20px;
                            background: #4299E1;
                            color: white;
                            border: none;
                            border-radius: 8px;
                            cursor: pointer;
                            font-family: 'ZCOOL XiaoWei', serif;
                            font-size: 0.9em;
                            transition: all 0.3s ease;
                            display: flex;
                            align-items: center;
                            gap: 5px;
                        }

                        .add-button:hover {
                            background: #2B6CB0;
                            transform: translateY(-2px);
                        }

                        .add-button.added {
                            background: #38A169;
                        }

                        .university-details {
                            display: grid;
                            grid-template-columns: repeat(3, 1fr);
                            gap: 15px;
                            margin-bottom: 15px;
                        }

                        .detail-item {
                            text-align: center;
                        }

                        .detail-label {
                            font-size: 0.9em;
                            color: #718096;
                            margin-bottom: 4px;
                        }

                        .detail-value {
                            font-family: 'ZCOOL QingKe HuangYou', sans-serif;
                            font-size: 1.1em;
                            color: #2D3748;
                            font-weight: bold;
                        }

                        .detail-value.highlight {
                            color: #E53E3E;
                        }

                        .university-footer {
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            padding-top: 15px;
                            border-top: 1px solid #E2E8F0;
                        }

                        .major-info {
                            font-size: 0.9em;
                            color: #4A5568;
                            display: flex;
                            align-items: center;
                            gap: 8px;
                        }

                        .batch-select {
                            padding: 6px 15px;
                            border: 2px solid #CBD5E0;
                            border-radius: 8px;
                            background: white;
                            font-family: 'ZCOOL XiaoWei', serif;
                            font-size: 0.9em;
                            color: #4A5568;
                            cursor: pointer;
                        }

                        /* 底部志愿表 */
                        .volunteer-table {
                            background: white;
                            border-radius: 10px;
                            padding: 15px;
                            margin-top: 20px;
                            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
                        }

                        .table-header {
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            margin-bottom: 15px;
                        }

                        .table-title {
                            font-family: 'ZCOOL QingKe HuangYou', sans-serif;
                            font-size: 1.2em;
                            color: #1E3A5F;
                            display: flex;
                            align-items: center;
                            gap: 10px;
                        }

                        .score-display {
                            padding: 5px 15px;
                            background: #4299E1;
                            color: white;
                            border-radius: 20px;
                            font-size: 0.9em;
                        }

                        .table-actions {
                            display: flex;
                            gap: 10px;
                        }

                        .table-actions button {
                            padding: 8px 20px;
                            border: none;
                            border-radius: 8px;
                            font-family: 'ZCOOL XiaoWei', serif;
                            font-size: 0.9em;
                            cursor: pointer;
                            transition: all 0.3s ease;
                        }

                        .clear-btn {
                            background: #FED7D7;
                            color: #9B2C2C;
                        }

                        .clear-btn:hover {
                            background: #FC8181;
                        }

                        .export-btn {
                            background: #C6F6D5;
                            color: #22543D;
                        }

                        .export-btn:hover {
                            background: #68D391;
                        }

                        /* 响应式设计 */
                        @media (max-width: 1200px) {
                            .main-content {
                                flex-direction: column;
                                height: auto;
                                overflow-y: auto;
                            }

                            .filter-panel {
                                width: 100%;
                                flex-direction: row;
                                flex-wrap: wrap;
                            }

                            .filter-section {
                                flex: 1;
                                min-width: 200px;
                            }

                            .filter-actions {
                                width: 100%;
                                margin-top: 10px;
                            }
                        }

                        @media (max-width: 768px) {
                            .header-nav {
                                flex-direction: column;
                                gap: 15px;
                                padding: 0 10px;
                            }

                            .nav-left {
                                flex-direction: column;
                                gap: 15px;
                                width: 100%;
                            }

                            .nav-tabs {
                                width: 100%;
                                justify-content: center;
                            }

                            .nav-right {
                                width: 100%;
                                justify-content: center;
                            }

                            .main-content {
                                padding: 0 10px;
                            }

                            .university-details {
                                grid-template-columns: 1fr;
                                gap: 10px;
                            }

                            .strategy-tab {
                                padding: 10px 5px;
                                font-size: 0.9em;
                            }
                        }
                    </style>
            </head>

            <body>
                <!-- 蓝天白云背景 -->
                <div class="sky-background">
                    <div class="sun-glow"></div>
                    <div class="cloud cloud-1"></div>
                    <div class="cloud cloud-2"></div>
                    <div class="cloud cloud-3"></div>
                    <div class="cloud cloud-4"></div>
                </div>

                <div class="page-container">
                    <!-- 头部导航 -->
                    <div class="header-nav">
                        <div class="nav-left">
                            <div class="nav-title">智能选志愿</div>
                            <div class="nav-tabs">
                                <button class="nav-tab active" onclick="switchMode('university')">院校优先</button>
                                <button class="nav-tab" onclick="switchMode('major')">专业优先</button>
                            </div>
                        </div>
                        <div class="nav-right">
                            <button class="nav-btn" onclick="goBack()">
                                <i class="fas fa-arrow-left"></i>
                                返回
                            </button>
                            <button class="nav-btn" onclick="goToMyVolunteer()">
                                <i class="fas fa-list-alt"></i>
                                我的志愿表
                            </button>
                        </div>
                    </div>

                    <!-- 主要内容区域 -->
                    <div class="main-content">
                        <!-- 左侧筛选面板 -->
                        <div class="filter-panel">
                            <div class="filter-section">
                                <div class="section-title">高考信息</div>
                                <div class="score-input-group">
                                    <input type="number" class="score-input" placeholder="分数" id="scoreInput">
                                    <input type="number" class="score-input" placeholder="位次" id="rankInput">
                                </div>
                                <div class="select-group">
                                    <select class="custom-select" id="batchSelect">
                                        <option value="">选择批次</option>
                                        <option value="本科批">本科批</option>
                                        <option value="本科一批">本科一批</option>
                                        <option value="本科二批">本科二批</option>
                                        <option value="专科批">专科批</option>
                                    </select>
                                </div>
                            </div>

                            <div class="filter-section">
                                <div class="section-title">选科组合</div>
                                <div class="checkbox-group" id="subjectGroup">
                                    <!-- 选科选项将通过JavaScript动态生成 -->
                                </div>
                            </div>

                            <div class="filter-section">
                                <div class="section-title">筛选条件</div>
                                <div class="select-group">
                                    <select class="custom-select" id="provinceSelect">
                                        <option value="">选择地区</option>
                                        <!-- 地区选项将通过JavaScript动态生成 -->
                                    </select>
                                </div>
                                <div class="select-group" style="margin-top: 10px;">
                                    <select class="custom-select" id="universityType">
                                        <option value="">选择院校类型</option>
                                        <!-- 院校类型选项将通过JavaScript动态生成 -->
                                    </select>
                                </div>
                            </div>

                            <div class="filter-actions">
                                <button class="action-btn secondary-btn" onclick="resetFilters()">重置</button>
                                <button class="action-btn primary-btn" onclick="recommendUniversities()">智能推荐</button>
                            </div>
                        </div>

                        <!-- 右侧内容区域 -->
                        <div class="content-panel">
                            <!-- 策略标签 -->
                            <div class="strategy-tabs">
                                <div class="strategy-tab impact active" onclick="selectStrategy('impact')">
                                    <span class="strategy-count" id="impactCount">0</span>
                                    <span class="strategy-label">冲</span>
                                </div>
                                <div class="strategy-tab safe" onclick="selectStrategy('safe')">
                                    <span class="strategy-count" id="safeCount">0</span>
                                    <span class="strategy-label">稳</span>
                                </div>
                                <div class="strategy-tab backup" onclick="selectStrategy('backup')">
                                    <span class="strategy-count" id="backupCount">0</span>
                                    <span class="strategy-label">保</span>
                                </div>
                                <div class="strategy-tab" onclick="selectStrategy('all')">
                                    <span class="strategy-count" id="allCount">0</span>
                                    <span class="strategy-label">全部</span>
                                </div>
                            </div>

                            <!-- 院校筛选栏 -->
                            <div class="university-filter">
                                <select class="filter-dropdown" id="regionFilter"
                                    onchange="filterUniversitiesByRegion(this.value)">
                                    <option value="">所在地区</option>
                                    <!-- 地区选项将通过JavaScript动态生成 -->
                                </select>
                                <select class="filter-dropdown" id="typeFilter"
                                    onchange="filterUniversitiesByType(this.value)">
                                    <option value="">院校类型</option>
                                    <!-- 院校类型选项将通过JavaScript动态生成 -->
                                </select>
                                <select class="filter-dropdown" id="planFilter"
                                    onchange="filterUniversitiesByPlan(this.value)">
                                    <option value="">招生计划</option>
                                    <option value="100以上">100人以上</option>
                                    <option value="50-100">50-100人</option>
                                    <option value="50以下">50人以下</option>
                                </select>
                            </div>

                            <!-- 院校列表 -->
                            <div class="university-list" id="universityList">
                                <div class="loading-container" id="loadingIndicator">
                                    <i class="fas fa-spinner fa-spin"></i>
                                    <p>正在加载院校数据...</p>
                                </div>
                                <div class="no-data" id="noDataIndicator" style="display: none;">
                                    <i class="fas fa-university"></i>
                                    <p>暂无院校数据，请先输入分数并点击"智能推荐"</p>
                                </div>
                                <!-- 院校列表将通过JavaScript动态生成 -->
                            </div>

                            <!-- 底部志愿表 -->
                            <div class="volunteer-table">
                                <div class="table-header">
                                    <div class="table-title">
                                        <i class="fas fa-file-alt"></i>
                                        我的志愿表 (<span id="volunteerCount">0</span>)
                                        <div class="score-display">
                                            分数：<span id="currentScore">--</span> | 位次：<span id="currentRank">--</span>
                                        </div>
                                    </div>
                                    <div class="table-actions">
                                        <button class="clear-btn" onclick="clearVolunteerTable()">
                                            <i class="fas fa-trash"></i>
                                            清空
                                        </button>
                                        <button class="export-btn" onclick="exportVolunteerTable()">
                                            <i class="fas fa-download"></i>
                                            导出
                                        </button>
                                    </div>
                                </div>
                                <!-- 已添加的院校列表 -->
                                <div id="volunteerList"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <script>
                    // 全局变量
                    let currentMode = 'university'; // 'university' 或 'major'
                    let currentStrategy = 'impact'; // 'impact', 'safe', 'backup', 'all'
                    let volunteerList = [];
                    let allUniversities = [];
                    let filteredUniversities = [];

                    // 页面初始化
                    $(document).ready(function () {
                        initPage();
                    });

                    // 初始化页面
                    function initPage() {
                        // 页面加载动画
                        $('.page-container').css({
                            'opacity': '0',
                            'transform': 'translateY(20px)'
                        });

                        setTimeout(() => {
                            $('.page-container').css({
                                'opacity': '1',
                                'transform': 'translateY(0)',
                                'transition': 'all 0.8s ease'
                            });
                        }, 300);

                        // 初始化下拉选项
                        initSelectOptions();

                        // 初始化志愿表
                        updateVolunteerTable();

                        // 隐藏加载指示器
                        setTimeout(() => {
                            $('#loadingIndicator').hide();
                            $('#noDataIndicator').show();
                        }, 1000);
                    }

                    // 初始化下拉选项
                    function initSelectOptions() {
                        // 初始化选科选项
                        const subjects = ['物理', '化学', '生物', '历史', '政治', '地理'];
                        const subjectGroup = $('#subjectGroup');
                        subjects.forEach(subject => {
                            subjectGroup.append(
                                '<label class="checkbox-label">' +
                                '<input type="checkbox" name="subject" value="' + subject + '"> ' + subject +
                                '</label>'
                            );
                        });

                        // 初始化地区选项
                        const provinces = ['北京', '上海', '天津', '重庆', '江苏', '浙江', '广东', '湖北', '湖南', '四川'];
                        const provinceSelect = $('#provinceSelect');
                        const regionFilter = $('#regionFilter');
                        provinces.forEach(province => {
                            provinceSelect.append('<option value="' + province + '">' + province + '</option>');
                            regionFilter.append('<option value="' + province + '">' + province + '</option>');
                        });

                        // 初始化院校类型选项
                        const universityTypes = [
                            { value: '985', label: '985工程' },
                            { value: '211', label: '211工程' },
                            { value: 'double_first', label: '双一流' },
                            { value: 'public', label: '公办' },
                            { value: 'private', label: '民办' }
                        ];
                        const universityTypeSelect = $('#universityType');
                        const typeFilter = $('#typeFilter');
                        universityTypes.forEach(type => {
                            universityTypeSelect.append('<option value="' + type.value + '">' + type.label + '</option>');
                            typeFilter.append('<option value="' + type.value + '">' + type.label + '</option>');
                        });
                    }

                    // 切换模式（院校优先/专业优先）
                    function switchMode(mode) {
                        currentMode = mode;

                        // 更新导航标签状态
                        $('.nav-tab').removeClass('active');
                        if (mode === 'university') {
                            $('.nav-tab').eq(0).addClass('active');
                        } else {
                            $('.nav-tab').eq(1).addClass('active');
                        }

                        // 这里可以根据模式重新获取数据
                        console.log('切换到' + (mode === 'university' ? '院校优先' : '专业优先') + '模式');

                        // 模拟重新加载数据
                        if (volunteerList.length > 0 || allUniversities.length > 0) {
                            recommendUniversities();
                        }
                    }

                    // 选择策略
                    function selectStrategy(strategy) {
                        $('.strategy-tab').removeClass('active');

                        // 找到对应的策略标签
                        $('.strategy-tab').each(function () {
                            if ($(this).attr('onclick') && $(this).attr('onclick').includes("'" + strategy + "'")) {
                                $(this).addClass('active');
                            }
                        });

                        currentStrategy = strategy;

                        // 过滤显示对应策略的院校
                        filterUniversitiesByStrategy(strategy);
                    }

                    // 根据策略过滤院校
                    function filterUniversitiesByStrategy(strategy) {
                        // 这里应该从后端获取数据
                        // 目前只是显示loading状态
                        showLoading();

                        // 模拟后端请求
                        setTimeout(() => {
                            if (strategy === 'all') {
                                displayUniversities(filteredUniversities);
                            } else {
                                const filtered = filteredUniversities.filter(university =>
                                    university.strategy === strategy
                                );
                                displayUniversities(filtered);
                            }
                            updateStrategyCounts();
                        }, 500);
                    }

                    // 根据地区过滤院校
                    function filterUniversitiesByRegion(region) {
                        if (!region) {
                            displayUniversities(filteredUniversities);
                            return;
                        }

                        const filtered = filteredUniversities.filter(university =>
                            university.region === region
                        );
                        displayUniversities(filtered);
                    }

                    // 根据类型过滤院校
                    function filterUniversitiesByType(type) {
                        if (!type) {
                            displayUniversities(filteredUniversities);
                            return;
                        }

                        const filtered = filteredUniversities.filter(university =>
                            university.type === type
                        );
                        displayUniversities(filtered);
                    }

                    // 根据招生计划过滤院校
                    function filterUniversitiesByPlan(plan) {
                        if (!plan) {
                            displayUniversities(filteredUniversities);
                            return;
                        }

                        const filtered = filteredUniversities.filter(university => {
                            if (plan === '100以上') return university.plan > 100;
                            if (plan === '50-100') return university.plan >= 50 && university.plan <= 100;
                            if (plan === '50以下') return university.plan < 50;
                            return true;
                        });
                        displayUniversities(filtered);
                    }

                    // 显示院校列表
                    function displayUniversities(universities) {
                        const universityListElement = $('#universityList');

                        if (universities.length === 0) {
                            universityListElement.html(
                                '<div class="no-data">' +
                                '<i class="fas fa-search"></i>' +
                                '<p>没有找到符合条件的院校</p>' +
                                '</div>'
                            );
                            return;
                        }

                        let html = '';
                        universities.forEach((university, index) => {
                            const isAdded = volunteerList.some(item => item.id === university.id);
                            const tagsHtml = university.tags.map(tag =>
                                '<span class="tag ' + tag.class + '">' + tag.label + '</span>'
                            ).join('');

                            // 修复关键错误：使用字符串拼接而不是嵌套模板字符串
                            const majorGroupsText = university.filledGroups ?
                                '可报考小组 ' + university.availableGroups + ' (已填专业组 ' + university.filledGroups + '个)' :
                                '可报考小组 ' + university.availableGroups;

                            html +=
                                '<div class="university-item" data-strategy="' + university.strategy + '">' +
                                '    <div class="university-header">' +
                                '        <div class="university-info">' +
                                '            <h3>' + university.name + '</h3>' +
                                '            <div class="university-tags">' +
                                '                ' + tagsHtml +
                                '                ' + (university.hasLowScore ? '<span class="low-score-tag"><i class="fas fa-exclamation-triangle"></i>有低分专业</span>' : '') +
                                '            </div>' +
                                '        </div>' +
                                '        <button class="add-button ' + (isAdded ? 'added' : '') + '" onclick="addToVolunteer(\'' + university.id + '\')">' +
                                '            <i class="fas fa-' + (isAdded ? 'check' : 'plus') + '"></i>' +
                                '            ' + (isAdded ? '已添加' : '添加') +
                                '        </button>' +
                                '    </div>' +
                                '    <div class="university-details">' +
                                '        <div class="detail-item">' +
                                '            <div class="detail-label">院校代码</div>' +
                                '            <div class="detail-value">' + university.code + '</div>' +
                                '        </div>' +
                                '        <div class="detail-item">' +
                                '            <div class="detail-label">' + university.lastYear + '年最低分</div>' +
                                '            <div class="detail-value ' + (university.isHighlight ? 'highlight' : '') + '">' + university.minScore + '</div>' +
                                '        </div>' +
                                '        <div class="detail-item">' +
                                '            <div class="detail-label">' + university.currentYear + '年计划</div>' +
                                '            <div class="detail-value">' + university.plan + '人</div>' +
                                '        </div>' +
                                '    </div>' +
                                '    <div class="university-footer">' +
                                '        <div class="major-info">' +
                                '            <i class="fas fa-graduation-cap"></i>' +
                                '            ' + majorGroupsText +
                                '        </div>' +
                                '        <select class="batch-select" onchange="selectBatch(this, \'' + university.id + '\')">' +
                                '            <option>本科批</option>' +
                                '            <option>本科一批</option>' +
                                '        </select>' +
                                '    </div>' +
                                '</div>';
                        });

                        universityListElement.html(html);
                    }

                    // 显示加载状态
                    function showLoading() {
                        $('#universityList').html(
                            '<div class="loading-container">' +
                            '<i class="fas fa-spinner fa-spin"></i>' +
                            '<p>正在加载数据...</p>' +
                            '</div>'
                        );
                    }

                    // 更新策略数量
                    function updateStrategyCounts() {
                        // 这里应该从后端获取真实数据
                        // 目前使用模拟数据
                        const impactCount = Math.floor(Math.random() * 50);
                        const safeCount = Math.floor(Math.random() * 30);
                        const backupCount = Math.floor(Math.random() * 200);

                        $('#impactCount').text(impactCount);
                        $('#safeCount').text(safeCount);
                        $('#backupCount').text(backupCount);
                        $('#allCount').text(impactCount + safeCount + backupCount);
                    }

                    // 添加院校到志愿表
                    function addToVolunteer(universityId) {
                        // 找到对应的院校信息
                        const university = allUniversities.find(u => u.id === universityId);
                        if (!university) {
                            alert('找不到院校信息！');
                            return;
                        }

                        // 检查是否已添加
                        if (volunteerList.some(item => item.id === universityId)) {
                            alert('该院校已在志愿表中！');
                            return;
                        }

                        // 添加到列表
                        volunteerList.push({
                            id: universityId,
                            name: university.name,
                            code: university.code,
                            time: new Date().toLocaleTimeString()
                        });

                        // 更新UI
                        updateVolunteerTable();

                        // 更新按钮状态
                        $('button[onclick*="' + universityId + '"]').html('<i class="fas fa-check"></i> 已添加');
                        $('button[onclick*="' + universityId + '"]').addClass('added');
                    }

                    // 更新志愿表
                    function updateVolunteerTable() {
                        const volunteerListElement = $('#volunteerList');
                        const volunteerCount = $('#volunteerCount');

                        volunteerListElement.empty();
                        volunteerCount.text(volunteerList.length);

                        // 更新当前分数和位次显示
                        const score = $('#scoreInput').val();
                        const rank = $('#rankInput').val();
                        $('#currentScore').text(score || '--');
                        $('#currentRank').text(rank || '--');

                        if (volunteerList.length === 0) {
                            volunteerListElement.html(
                                '<div class="no-data" style="padding: 20px;">' +
                                '<i class="fas fa-university"></i>' +
                                '<p>暂无志愿院校，请从上方列表中添加</p>' +
                                '</div>'
                            );
                            return;
                        }

                        // 显示已添加的院校
                        volunteerList.forEach((item, index) => {
                            volunteerListElement.append(
                                '<div class="university-item" style="margin-bottom: 10px; padding: 15px;">' +
                                '    <div style="display: flex; justify-content: space-between; align-items: center;">' +
                                '        <div>' +
                                '            <strong>' + (index + 1) + '. ' + item.name + '</strong>' +
                                '            <div style="font-size: 0.9em; color: #718096; margin-top: 5px;">' +
                                '                院校代码：' + item.code + ' | 添加时间：' + item.time +
                                '            </div>' +
                                '        </div>' +
                                '        <button onclick="removeFromVolunteer(' + index + ')" style="' +
                                '            padding: 5px 10px;' +
                                '            background: #FED7D7;' +
                                '            color: #9B2C2C;' +
                                '            border: none;' +
                                '            border-radius: 5px;' +
                                '            cursor: pointer;' +
                                '        ">' +
                                '            <i class="fas fa-times"></i>' +
                                '        </button>' +
                                '    </div>' +
                                '</div>'
                            );
                        });
                    }

                    // 从志愿表移除院校
                    function removeFromVolunteer(index) {
                        const removedUniversity = volunteerList[index];
                        volunteerList.splice(index, 1);
                        updateVolunteerTable();

                        // 更新对应按钮状态
                        $('button[onclick*="' + removedUniversity.id + '"]').html('<i class="fas fa-plus"></i> 添加');
                        $('button[onclick*="' + removedUniversity.id + '"]').removeClass('added');
                    }

                    // 清空志愿表
                    function clearVolunteerTable() {
                        if (volunteerList.length === 0) {
                            alert('志愿表已经是空的！');
                            return;
                        }

                        if (confirm('确定要清空志愿表吗？')) {
                            // 重置所有添加按钮
                            $('.add-button').html('<i class="fas fa-plus"></i> 添加');
                            $('.add-button').removeClass('added');

                            volunteerList = [];
                            updateVolunteerTable();
                        }
                    }

                    // 导出志愿表
                    function exportVolunteerTable() {
                        if (volunteerList.length === 0) {
                            alert('志愿表为空，无法导出！');
                            return;
                        }

                        // 这里应该调用后端导出接口
                        alert('志愿表导出功能需要后端支持');
                    }

                    // 智能推荐
                    function recommendUniversities() {
                        const score = $('#scoreInput').val();
                        const rank = $('#rankInput').val();
                        const batch = $('#batchSelect').val();

                        if (!score || !rank) {
                            alert('请输入分数和位次！');
                            return;
                        }

                        if (!batch) {
                            alert('请选择批次！');
                            return;
                        }

                        // 显示加载状态
                        showLoading();
                        const button = $('.primary-btn');
                        const originalText = button.text();
                        button.html('<i class="fas fa-spinner fa-spin"></i> 推荐中...');

                        // 收集筛选条件
                        const selectedSubjects = [];
                        $('input[name="subject"]:checked').each(function () {
                            selectedSubjects.push($(this).val());
                        });

                        const province = $('#provinceSelect').val();
                        const type = $('#universityType').val();

                        // 构造请求数据
                        const requestData = {
                            score: parseInt(score),
                            rank: parseInt(rank),
                            batch: batch,
                            subjects: selectedSubjects,
                            province: province,
                            type: type,
                            mode: currentMode
                        };

                        // 调用真实推荐API
                        $.ajax({
                            url: '/api/recommend',
                            type: 'GET',
                            data: requestData,
                            dataType: 'json',
                            success: function (response) {
                                if (response.success) {
                                    // 使用真实数据
                                    allUniversities = response.data || [];
                                    filteredUniversities = [...allUniversities];

                                    // 显示数据
                                    displayUniversities(filteredUniversities);

                                    // 更新策略计数
                                    $('.impact .strategy-count').text(response.impactCount || 0);
                                    $('.safe .strategy-count').text(response.safeCount || 0);
                                    $('.backup .strategy-count').text(response.backupCount || 0);

                                    // 隐藏无数据提示
                                    $('#noDataIndicator').hide();

                                    // 更新当前分数显示
                                    $('#currentScore').text(score);
                                    $('#currentRank').text(rank);
                                } else {
                                    alert(response.message || '获取推荐失败');
                                }

                                // 恢复按钮状态
                                button.text(originalText);
                            },
                            error: function () {
                                alert('网络错误，请重试');
                                button.text(originalText);
                            }
                        });
                    }

                    // 生成模拟院校数据
                    function generateMockUniversities(requestData) {
                        const universities = [];
                        const universityNames = [
                            '北京大学', '清华大学', '复旦大学', '上海交通大学', '浙江大学',
                            '南京大学', '中国科学技术大学', '武汉大学', '华中科技大学', '中山大学',
                            '西安交通大学', '哈尔滨工业大学', '北京航空航天大学', '同济大学', '南开大学'
                        ];

                        const strategies = ['impact', 'safe', 'backup'];
                        const regions = ['北京', '上海', '江苏', '浙江', '广东', '湖北', '陕西'];
                        const types = ['985', '211', 'double_first', 'public'];

                        // 根据分数生成不同策略的院校
                        const score = requestData.score;

                        for (let i = 0; i < 10; i++) {
                            const strategyIndex = i % 3;
                            const strategy = strategies[strategyIndex];

                            // 根据策略调整分数
                            let minScore;
                            if (strategy === 'impact') {
                                minScore = score + 10 + Math.floor(Math.random() * 20);
                            } else if (strategy === 'safe') {
                                minScore = score - 5 + Math.floor(Math.random() * 10);
                            } else {
                                minScore = score - 20 + Math.floor(Math.random() * 10);
                            }

                            // 创建标签数组
                            const tags = [];
                            if (i % 2 === 0) {
                                tags.push({ label: '双一流', class: 'double-first' });
                            } else {
                                tags.push({ label: '985', class: 'double-first' });
                            }
                            tags.push({ label: '211', class: 'project-211' });
                            tags.push({ label: '公办', class: 'public' });

                            universities.push({
                                id: 'univ_' + i,
                                name: universityNames[i % universityNames.length] + (i > universityNames.length ? ' (分校区)' : ''),
                                code: '100' + (i + 1).toString().padStart(2, '0'),
                                strategy: strategy,
                                region: regions[i % regions.length],
                                type: types[i % types.length],
                                tags: tags,
                                hasLowScore: i % 4 === 0,
                                lastYear: new Date().getFullYear() - 1,
                                currentYear: new Date().getFullYear(),
                                minScore: minScore,
                                isHighlight: i % 3 === 0,
                                plan: 50 + Math.floor(Math.random() * 150),
                                availableGroups: 3 + Math.floor(Math.random() * 5),
                                filledGroups: i % 2 === 0 ? 1 + Math.floor(Math.random() * 2) : null
                            });
                        }

                        return universities;
                    }

                    // 重置筛选条件
                    function resetFilters() {
                        // 重置输入框
                        $('#scoreInput').val('');
                        $('#rankInput').val('');
                        $('#batchSelect').val('');

                        // 重置选科
                        $('input[name="subject"]').prop('checked', false);

                        // 重置筛选条件
                        $('#provinceSelect').val('');
                        $('#universityType').val('');

                        // 重置筛选栏
                        $('#regionFilter').val('');
                        $('#typeFilter').val('');
                        $('#planFilter').val('');

                        // 清空院校列表
                        $('#universityList').html(
                            '<div class="no-data" id="noDataIndicator">' +
                            '<i class="fas fa-university"></i>' +
                            '<p>暂无院校数据，请先输入分数并点击"智能推荐"</p>' +
                            '</div>'
                        );

                        // 重置策略计数
                        updateStrategyCounts();

                        // 重置当前分数显示
                        $('#currentScore').text('--');
                        $('#currentRank').text('--');
                    }

                    // 选择批次
                    function selectBatch(select, universityId) {
                        console.log('为院校' + universityId + '选择批次：' + select.value);
                    }

                    // 导航功能
                    function goBack() {
                        // 返回上一页
                        window.history.back();
                    }

                    function goToMyVolunteer() {
                        // 这里可以跳转到我的志愿表页面
                        alert('我的志愿表功能需要后端支持');
                    }
                </script>
            </body>

            </html>