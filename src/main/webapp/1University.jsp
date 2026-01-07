<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
    <html>

    <head>
        <title>智选志愿 - 查大学</title>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link
            href="https://fonts.googleapis.com/css2?family=Ma+Shan+Zheng&family=ZCOOL+QingKe+HuangYou&family=ZCOOL+XiaoWei&display=swap"
            rel="stylesheet">
        <style>
            /* ========== 全局重置与背景 ========== */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'ZCOOL XiaoWei', 'Microsoft YaHei', sans-serif;
                background: linear-gradient(135deg, #87CEEB 0%, #B0E2FF 40%, #87CEEB 80%, #4682B4 100%);
                min-height: 100vh;
                position: relative;
                width: 100vw;
                overflow-x: hidden;
            }

            /* ========== 天空背景优化 ========== */
            .sky-background {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                z-index: 0;
                overflow: hidden;
            }

            /* 缩小太阳光晕 */
            .sun-glow {
                position: absolute;
                top: 4%;
                right: 4%;
                width: 80px;
                height: 80px;
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
                    transform: scale(1.08);
                    opacity: 1;
                }
            }

            /* 缩小云朵 */
            .cloud {
                position: absolute;
                background: rgba(255, 255, 255, 0.95);
                z-index: 1;
                filter: blur(1px);
            }

            .cloud-1 {
                width: 140px;
                height: 50px;
                top: 10%;
                left: 4%;
                border-radius: 50px;
                animation: cloudFloat1 20s ease-in-out infinite alternate;
            }

            .cloud-2 {
                width: 160px;
                height: 55px;
                top: 30%;
                right: 8%;
                border-radius: 55px;
                animation: cloudFloat2 25s ease-in-out infinite alternate;
                animation-delay: 5s;
            }

            .cloud-3 {
                width: 120px;
                height: 45px;
                top: 60%;
                left: 12%;
                border-radius: 45px;
                animation: cloudFloat3 18s ease-in-out infinite alternate;
                animation-delay: 10s;
            }

            /* ========== Logo区域优化 ========== */
            .corner-logo {
                position: fixed;
                top: 20px;
                left: 25px;
                z-index: 100;
                background: transparent;
                padding: 0;
                border: none;
                box-shadow: none;
            }

            .logo-text {
                font-family: 'Ma Shan Zheng', cursive;
                font-size: 1.8em;
                color: #1E3A5F;
                text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.15), 0 0 15px rgba(255, 255, 255, 0.8);
                letter-spacing: 1.5px;
            }

            .sub-logo {
                font-family: 'ZCOOL QingKe HuangYou', sans-serif;
                font-size: 0.8em;
                color: #2C5282;
                margin-top: 3px;
                letter-spacing: 1.5px;
                font-weight: 300;
                text-shadow: 1px 1px 4px rgba(255, 255, 255, 0.7);
            }

            /* ========== 主容器优化 ========== */
            .main-container {
                position: relative;
                z-index: 10;
                width: 94%;
                max-width: 1300px;
                margin: 70px auto 30px;
                padding: 25px;
                background: rgba(255, 255, 255, 0.94);
                backdrop-filter: blur(12px);
                border-radius: 18px;
                box-shadow: 0 12px 35px rgba(0, 0, 0, 0.1), 0 0 0 1px rgba(255, 255, 255, 0.5);
                min-height: calc(100vh - 140px);
            }

            /* ========== 页面标题优化 ========== */
            .page-header {
                text-align: center;
                margin-bottom: 30px;
                padding-bottom: 18px;
                border-bottom: 2px solid rgba(66, 153, 225, 0.2);
            }

            .page-title {
                font-family: 'ZCOOL QingKe HuangYou', sans-serif;
                font-size: 2.2em;
                color: #1E3A5F;
                margin-bottom: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 12px;
            }

            .page-title-icon {
                font-size: 1.1em;
                background: linear-gradient(135deg, #4299E1, #2B6CB0);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }

            .page-subtitle {
                font-family: 'ZCOOL XiaoWei', serif;
                font-size: 1.1em;
                color: #2C5282;
                opacity: 0.9;
            }

            /* ========== 搜索筛选区域优化 ========== */
            .search-filter-container {
                background: rgba(255, 255, 255, 0.96);
                border-radius: 14px;
                padding: 22px;
                margin-bottom: 25px;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.05), 0 0 0 1px rgba(66, 153, 225, 0.12);
            }

            .filter-row {
                display: flex;
                flex-wrap: wrap;
                gap: 18px;
                margin-bottom: 18px;
                align-items: flex-end;
            }

            .filter-group {
                flex: 1;
                min-width: 180px;
            }

            .filter-group label {
                display: block;
                font-family: 'ZCOOL XiaoWei', serif;
                color: #2C5282;
                margin-bottom: 8px;
                font-size: 1em;
                font-weight: 500;
            }

            .search-input {
                width: 100%;
                padding: 11px 18px;
                border: 2px solid #E2E8F0;
                border-radius: 10px;
                font-family: 'ZCOOL XiaoWei', serif;
                font-size: 0.95em;
                color: #2D3748;
                background: white;
                transition: all 0.3s ease;
            }

            .search-input:focus {
                outline: none;
                border-color: #4299E1;
                box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.1);
            }

            .checkbox-group {
                display: flex;
                gap: 16px;
                flex-wrap: wrap;
            }

            .checkbox-item {
                display: flex;
                align-items: center;
                gap: 7px;
                cursor: pointer;
            }

            .checkbox-item input[type="checkbox"] {
                width: 16px;
                height: 16px;
                cursor: pointer;
            }

            .checkbox-label {
                font-family: 'ZCOOL XiaoWei', serif;
                color: #2D3748;
                font-size: 0.95em;
                user-select: none;
            }

            .score-info {
                display: flex;
                align-items: center;
                gap: 10px;
                background: rgba(66, 153, 225, 0.1);
                padding: 14px;
                border-radius: 10px;
                margin-top: 18px;
                border-left: 4px solid #4299E1;
            }

            .score-info-icon {
                font-size: 1.3em;
                color: #2B6CB0;
            }

            .score-info-text {
                font-family: 'ZCOOL XiaoWei', serif;
                color: #2C5282;
                font-size: 0.95em;
            }

            .score-info-text strong {
                color: #1E3A5F;
                font-weight: 600;
            }

            .search-button {
                background: linear-gradient(135deg, #4299E1, #2B6CB0);
                color: white;
                border: none;
                padding: 12px 35px;
                border-radius: 10px;
                font-family: 'ZCOOL QingKe HuangYou', sans-serif;
                font-size: 1.1em;
                cursor: pointer;
                transition: all 0.3s ease;
                box-shadow: 0 4px 12px rgba(66, 153, 225, 0.3);
            }

            .search-button:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 18px rgba(66, 153, 225, 0.4);
            }

            /* ========== 大学列表区域优化 ========== */
            .university-list-container {
                background: white;
                border-radius: 14px;
                overflow: hidden;
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.06), 0 0 0 1px rgba(66, 153, 225, 0.1);
            }

            .list-header {
                display: grid;
                grid-template-columns: 2fr 1fr 0.8fr 0.8fr 0.8fr 0.8fr;
                background: linear-gradient(135deg, #4299E1, #2B6CB0);
                color: white;
                padding: 18px 20px;
                font-family: 'ZCOOL QingKe HuangYou', sans-serif;
                font-size: 1em;
                font-weight: 600;
                gap: 8px;
            }

            .list-header-item {
                padding: 0 8px;
                text-align: left;
            }

            .university-list {
                max-height: 520px;
                overflow-y: auto;
            }

            .university-item {
                display: grid;
                grid-template-columns: 2fr 1fr 0.8fr 0.8fr 0.8fr 0.8fr;
                padding: 22px 20px;
                border-bottom: 1px solid #E2E8F0;
                gap: 8px;
                align-items: center;
                transition: all 0.3s ease;
            }

            .university-item:hover {
                background: rgba(66, 153, 225, 0.04);
                transform: translateY(-1px);
            }

            .university-item:last-child {
                border-bottom: none;
            }

            .university-cell {
                padding: 0 8px;
            }

            /* 大学名称单元格 */
            .university-name-cell {
                text-align: left;
            }

            .university-name {
                font-family: 'ZCOOL QingKe HuangYou', sans-serif;
                font-size: 1.2em;
                color: #1E3A5F;
                font-weight: 600;
                margin-bottom: 6px;
                line-height: 1.3;
            }

            .university-info {
                display: flex;
                flex-wrap: wrap;
                gap: 12px;
                margin-bottom: 5px;
            }

            .university-location,
            .university-type {
                font-family: 'ZCOOL XiaoWei', serif;
                color: #718096;
                font-size: 0.9em;
                display: flex;
                align-items: center;
                gap: 4px;
            }

            /* 标签容器 */
            .university-tags {
                display: flex;
                flex-wrap: wrap;
                gap: 6px;
                margin-top: 5px;
            }

            .university-tag {
                font-family: 'ZCOOL XiaoWei', serif;
                font-size: 0.8em;
                padding: 3px 8px;
                border-radius: 10px;
                display: inline-block;
            }

            .tag-211 {
                background: rgba(245, 101, 101, 0.1);
                color: #C53030;
                border: 1px solid rgba(245, 101, 101, 0.2);
            }

            .tag-985 {
                background: rgba(237, 137, 54, 0.1);
                color: #9C4221;
                border: 1px solid rgba(237, 137, 54, 0.2);
            }

            .tag-double-first {
                background: rgba(56, 178, 172, 0.1);
                color: #234E52;
                border: 1px solid rgba(56, 178, 172, 0.2);
            }

            .tag-public {
                background: rgba(72, 187, 120, 0.1);
                color: #22543D;
                border: 1px solid rgba(72, 187, 120, 0.2);
            }

            /* 分数显示单元格 */
            .score-cell {
                text-align: center;
            }

            .score-container {
                display: flex;
                flex-direction: column;
                gap: 6px;
            }

            .score-item {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 5px;
            }

            .score-value {
                font-family: 'ZCOOL QingKe HuangYou', sans-serif;
                font-size: 1.2em;
                font-weight: 600;
                color: #1E3A5F;
            }

            .score-type {
                font-family: 'ZCOOL XiaoWei', serif;
                font-size: 0.85em;
                color: #718096;
            }

            .score-history {
                font-family: 'ZCOOL XiaoWei', serif;
                font-size: 0.8em;
                color: #4299E1;
                cursor: pointer;
                text-decoration: underline;
                transition: all 0.3s ease;
                display: inline-block;
                margin-top: 3px;
            }

            .score-history:hover {
                color: #2B6CB0;
            }

            /* 操作按钮单元格 */
            .actions-cell {
                text-align: center;
            }

            .university-actions {
                display: flex;
                flex-direction: column;
                gap: 8px;
                align-items: center;
            }

            .action-btn {
                background: rgba(66, 153, 225, 0.1);
                color: #2B6CB0;
                border: 1px solid rgba(66, 153, 225, 0.2);
                padding: 7px 12px;
                border-radius: 8px;
                font-family: 'ZCOOL XiaoWei', serif;
                font-size: 0.9em;
                cursor: pointer;
                transition: all 0.3s ease;
                width: 100%;
                max-width: 110px;
            }

            .action-btn:hover {
                background: rgba(66, 153, 225, 0.2);
                transform: translateY(-2px);
                box-shadow: 0 3px 8px rgba(66, 153, 225, 0.2);
            }

            .action-btn.compare {
                background: rgba(159, 122, 234, 0.1);
                color: #6B46C1;
                border: 1px solid rgba(159, 122, 234, 0.2);
            }

            .action-btn.compare:hover {
                background: rgba(159, 122, 234, 0.2);
            }

            /* ========== 比较面板优化 ========== */
            .compare-panel {
                position: fixed;
                bottom: 25px;
                right: 25px;
                z-index: 1000;
                background: white;
                border-radius: 14px;
                padding: 18px;
                box-shadow: 0 12px 35px rgba(0, 0, 0, 0.15), 0 0 0 1px rgba(66, 153, 225, 0.1);
                max-width: 320px;
                transform: translateY(100px);
                opacity: 0;
                transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
            }

            .compare-panel.show {
                transform: translateY(0);
                opacity: 1;
            }

            .compare-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 14px;
                padding-bottom: 10px;
                border-bottom: 2px solid #E2E8F0;
            }

            .compare-title {
                font-family: 'ZCOOL QingKe HuangYou', sans-serif;
                font-size: 1.2em;
                color: #1E3A5F;
            }

            .compare-count {
                font-family: 'ZCOOL QingKe HuangYou', sans-serif;
                background: #4299E1;
                color: white;
                padding: 3px 10px;
                border-radius: 20px;
                font-size: 0.85em;
            }

            .compare-items {
                max-height: 180px;
                overflow-y: auto;
                margin-bottom: 14px;
            }

            .compare-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 9px;
                border-radius: 8px;
                background: rgba(66, 153, 225, 0.05);
                margin-bottom: 7px;
                transition: all 0.3s ease;
            }

            .compare-item:hover {
                background: rgba(66, 153, 225, 0.08);
            }

            .compare-item-name {
                font-family: 'ZCOOL XiaoWei', serif;
                font-size: 0.95em;
                color: #2D3748;
                flex: 1;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }

            .remove-compare {
                background: none;
                border: none;
                color: #718096;
                cursor: pointer;
                font-size: 1.1em;
                padding: 2px 6px;
                border-radius: 50%;
                transition: all 0.3s ease;
            }

            .remove-compare:hover {
                background: rgba(245, 101, 101, 0.1);
                color: #C53030;
                transform: scale(1.1);
            }

            .compare-actions {
                display: flex;
                gap: 9px;
            }

            .compare-action-btn {
                flex: 1;
                padding: 9px;
                border: none;
                border-radius: 8px;
                font-family: 'ZCOOL XiaoWei', serif;
                font-size: 0.95em;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .btn-compare-now {
                background: linear-gradient(135deg, #4299E1, #2B6CB0);
                color: white;
            }

            .btn-clear-all {
                background: rgba(226, 232, 240, 0.8);
                color: #4A5568;
            }

            .btn-compare-now:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(66, 153, 225, 0.3);
            }

            .btn-clear-all:hover {
                background: rgba(203, 213, 224, 0.8);
            }

            /* ========== 返回按钮优化 ========== */
            .back-home {
                position: fixed;
                bottom: 25px;
                left: 25px;
                z-index: 100;
                background: rgba(43, 108, 176, 0.92);
                color: white;
                padding: 9px 22px;
                border-radius: 22px;
                font-family: 'ZCOOL QingKe HuangYou', sans-serif;
                font-size: 0.95em;
                text-decoration: none;
                border: 1px solid rgba(255, 255, 255, 0.5);
                box-shadow: 0 4px 15px rgba(43, 108, 176, 0.3), 0 0 12px rgba(43, 108, 176, 0.2);
                transition: all 0.3s ease;
                backdrop-filter: blur(5px);
                display: flex;
                align-items: center;
                gap: 7px;
            }

            .back-home:hover {
                background: rgba(30, 58, 95, 0.95);
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(43, 108, 176, 0.4), 0 0 15px rgba(43, 108, 176, 0.3);
            }

            /* ========== 滚动条美化 ========== */
            .university-list::-webkit-scrollbar,
            .compare-items::-webkit-scrollbar {
                width: 6px;
            }

            .university-list::-webkit-scrollbar-track,
            .compare-items::-webkit-scrollbar-track {
                background: rgba(226, 232, 240, 0.5);
                border-radius: 10px;
            }

            .university-list::-webkit-scrollbar-thumb,
            .compare-items::-webkit-scrollbar-thumb {
                background: rgba(66, 153, 225, 0.5);
                border-radius: 10px;
            }

            .university-list::-webkit-scrollbar-thumb:hover,
            .compare-items::-webkit-scrollbar-thumb:hover {
                background: rgba(66, 153, 225, 0.7);
            }

            /* ========== 响应式设计 ========== */
            @media (max-width: 1200px) {
                .main-container {
                    width: 96%;
                    padding: 22px;
                    margin: 65px auto 25px;
                }

                .list-header,
                .university-item {
                    grid-template-columns: 2fr 1fr 0.8fr 0.8fr 0.8fr;
                }

                .university-cell:nth-child(6) {
                    display: none;
                }

                .compare-panel {
                    max-width: 300px;
                    right: 20px;
                    bottom: 20px;
                }
            }

            @media (max-width: 992px) {
                .page-title {
                    font-size: 1.9em;
                }

                .filter-row {
                    flex-direction: column;
                }

                .filter-group {
                    min-width: 100%;
                }

                .list-header,
                .university-item {
                    grid-template-columns: 1.5fr 1fr 0.8fr 0.8fr;
                }

                .university-cell:nth-child(5) {
                    display: none;
                }

                .university-actions {
                    flex-direction: row;
                    justify-content: center;
                }

                .action-btn {
                    max-width: 95px;
                }
            }

            @media (max-width: 768px) {
                .main-container {
                    padding: 18px 15px;
                    margin: 60px auto 20px;
                }

                .page-title {
                    font-size: 1.6em;
                }

                .page-subtitle {
                    font-size: 1em;
                }

                .search-filter-container {
                    padding: 18px 15px;
                }

                .list-header,
                .university-item {
                    grid-template-columns: 1fr;
                    gap: 12px;
                }

                .list-header {
                    display: none;
                }

                .university-item {
                    border: 1px solid #E2E8F0;
                    border-radius: 10px;
                    margin-bottom: 12px;
                    padding: 18px;
                }

                .university-cell {
                    padding: 4px 0;
                }

                .university-name-cell {
                    border-bottom: 1px solid #E2E8F0;
                    padding-bottom: 12px;
                }

                .score-cell {
                    border-bottom: 1px solid #E2E8F0;
                    padding-bottom: 12px;
                }

                .university-cell:nth-child(3),
                .university-cell:nth-child(4) {
                    border-bottom: 1px solid #E2E8F0;
                    padding-bottom: 12px;
                }

                .university-cell::before {
                    content: attr(data-label);
                    font-family: 'ZCOOL QingKe HuangYou', sans-serif;
                    color: #2C5282;
                    font-size: 0.85em;
                    font-weight: 600;
                    display: block;
                    margin-bottom: 4px;
                }

                .university-actions {
                    flex-direction: column;
                }

                .action-btn {
                    max-width: 100%;
                }

                .corner-logo {
                    top: 15px;
                    left: 15px;
                }

                .logo-text {
                    font-size: 1.6em;
                }

                .back-home {
                    bottom: 15px;
                    left: 15px;
                    padding: 8px 18px;
                    font-size: 0.9em;
                }

                .compare-panel {
                    max-width: calc(100% - 30px);
                    right: 15px;
                    left: 15px;
                    bottom: 15px;
                }
            }

            @media (max-width: 480px) {
                .page-title {
                    font-size: 1.4em;
                    flex-direction: column;
                    gap: 8px;
                }

                .checkbox-group {
                    flex-direction: column;
                    gap: 8px;
                }

                .score-info {
                    flex-direction: column;
                    text-align: center;
                    gap: 8px;
                }

                .search-button {
                    width: 100%;
                    padding: 11px 20px;
                }

                .university-info {
                    flex-direction: column;
                    gap: 6px;
                }

                .university-tags {
                    justify-content: center;
                }

                .corner-logo {
                    left: 12px;
                    top: 12px;
                }

                .logo-text {
                    font-size: 1.4em;
                }

                .sub-logo {
                    font-size: 0.7em;
                }

                .sun-glow {
                    width: 60px;
                    height: 60px;
                    top: 3%;
                    right: 3%;
                }

                .cloud-1,
                .cloud-2,
                .cloud-3 {
                    display: none;
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
        </div>

        <!-- 左上角logo -->
        <div class="corner-logo">
            <div class="logo-text">智选志愿</div>
            <div class="sub-logo">INTELLIGENT SELECTION</div>
        </div>

        <!-- 主内容区域 -->
        <div class="main-container">
            <!-- 页面标题 -->
            <div class="page-header">
                <h1 class="page-title">
                    <span class="page-title-icon">🏫</span>
                    查大学
                </h1>
                <p class="page-subtitle">查找并比较全国高校信息，为您提供精准的院校选择参考</p>
            </div>

            <!-- 搜索筛选区域 -->
            <div class="search-filter-container">
                <div class="filter-row">
                    <div class="filter-group">
                        <label for="universitySearch">搜索大学的名称</label>
                        <input type="text" id="universitySearch" class="search-input" placeholder="请输入大学名称">
                    </div>

                    <div class="filter-group">
                        <label for="cityFilter">院校城市</label>
                        <select id="cityFilter" class="search-input">
                            <option value="">全部城市</option>
                            <option value="北京">北京</option>
                            <option value="上海">上海</option>
                            <option value="广州">广州</option>
                            <option value="深圳">深圳</option>
                            <option value="武汉">武汉</option>
                            <option value="成都">成都</option>
                            <option value="南京">南京</option>
                            <option value="西安">西安</option>
                        </select>
                    </div>

                    <div class="filter-group">
                        <label>院校类型</label>
                        <div class="checkbox-group">
                            <label class="checkbox-item">
                                <input type="checkbox" name="type" value="综合类" checked>
                                <span class="checkbox-label">综合类</span>
                            </label>
                            <label class="checkbox-item">
                                <input type="checkbox" name="type" value="理工类">
                                <span class="checkbox-label">理工类</span>
                            </label>
                            <label class="checkbox-item">
                                <input type="checkbox" name="type" value="师范类">
                                <span class="checkbox-label">师范类</span>
                            </label>
                            <label class="checkbox-item">
                                <input type="checkbox" name="type" value="医药类">
                                <span class="checkbox-label">医药类</span>
                            </label>
                        </div>
                    </div>

                    <button class="search-button" id="searchBtn">搜索</button>
                </div>

                <div class="filter-row">
                    <div class="filter-group">
                        <label>院校标签</label>
                        <div class="checkbox-group">
                            <label class="checkbox-item">
                                <input type="checkbox" name="tag" value="211">
                                <span class="checkbox-label">211工程</span>
                            </label>
                            <label class="checkbox-item">
                                <input type="checkbox" name="tag" value="985">
                                <span class="checkbox-label">985工程</span>
                            </label>
                            <label class="checkbox-item">
                                <input type="checkbox" name="tag" value="双一流">
                                <span class="checkbox-label">双一流</span>
                            </label>
                            <label class="checkbox-item">
                                <input type="checkbox" name="tag" value="公办">
                                <span class="checkbox-label">公办</span>
                            </label>
                        </div>
                    </div>
                </div>

                <!-- 成绩信息展示 -->
                <div class="score-info">
                    <div class="score-info-icon">📊</div>
                    <div class="score-info-text" id="scoreInfoText">
                        仅展示成绩附近的院校 &nbsp; &nbsp; <strong id="userScoreInfo">加载中...</strong>
                    </div>
                </div>
            </div>

            <!-- 大学列表区域 -->
            <div class="university-list-container">
                <!-- 表头 -->
                <div class="list-header">
                    <div class="list-header-item">院校名称</div>
                    <div class="list-header-item">2024年录取分</div>
                    <div class="list-header-item">院校类型</div>
                    <div class="list-header-item">院校标签</div>
                    <div class="list-header-item">院校城市</div>
                    <div class="list-header-item">操作</div>
                </div>

                <!-- 大学列表 -->
                <div class="university-list" id="universityList">
                    <!-- 华南农业大学 -->
                    <div class="university-item" data-id="1">
                        <div class="university-cell university-name-cell" data-label="院校名称">
                            <div class="university-name">华南农业大学</div>
                            <div class="university-info">
                                <span class="university-location">📍广州市</span>
                                <span class="university-type">🏛️公办</span>
                            </div>
                            <div class="university-tags">
                                <span class="university-tag tag-double-first">双一流</span>
                            </div>
                        </div>
                        <div class="university-cell score-cell" data-label="2024年录取分">
                            <div class="score-container">
                                <div class="score-item">
                                    <span class="score-type">物理：</span>
                                    <span class="score-value">560</span>
                                </div>
                                <div class="score-item">
                                    <span class="score-type">历史：</span>
                                    <span class="score-value">--</span>
                                </div>
                                <div class="score-history">查看历年分数</div>
                            </div>
                        </div>
                        <div class="university-cell" data-label="院校类型">
                            <div class="score-value">综合类</div>
                        </div>
                        <div class="university-cell" data-label="院校标签">
                            <div class="university-tags">
                                <span class="university-tag tag-double-first">双一流</span>
                                <span class="university-tag tag-public">公办</span>
                            </div>
                        </div>
                        <div class="university-cell" data-label="院校城市">
                            <div class="score-value">广州市</div>
                        </div>
                        <div class="university-cell actions-cell" data-label="操作">
                            <div class="university-actions">
                                <button class="action-btn" onclick="addToVolunteer(1)">加入志愿表</button>
                                <button class="action-btn compare" onclick="addToCompare(1)">加入对比</button>
                            </div>
                        </div>
                    </div>

                    <!-- 北方工业大学 -->
                    <div class="university-item" data-id="2">
                        <div class="university-cell university-name-cell" data-label="院校名称">
                            <div class="university-name">北方工业大学</div>
                            <div class="university-info">
                                <span class="university-location">📍北京市</span>
                                <span class="university-type">🏛️公办</span>
                            </div>
                            <div class="university-tags">
                                <span class="university-tag tag-211">211</span>
                            </div>
                        </div>
                        <div class="university-cell score-cell" data-label="2024年录取分">
                            <div class="score-container">
                                <div class="score-item">
                                    <span class="score-type">物理：</span>
                                    <span class="score-value">560</span>
                                </div>
                                <div class="score-item">
                                    <span class="score-type">历史：</span>
                                    <span class="score-value">553</span>
                                </div>
                                <div class="score-history">查看历年分数</div>
                            </div>
                        </div>
                        <div class="university-cell" data-label="院校类型">
                            <div class="score-value">理工类</div>
                        </div>
                        <div class="university-cell" data-label="院校标签">
                            <div class="university-tags">
                                <span class="university-tag tag-211">211</span>
                                <span class="university-tag tag-public">公办</span>
                            </div>
                        </div>
                        <div class="university-cell" data-label="院校城市">
                            <div class="score-value">北京市</div>
                        </div>
                        <div class="university-cell actions-cell" data-label="操作">
                            <div class="university-actions">
                                <button class="action-btn" onclick="addToVolunteer(2)">加入志愿表</button>
                                <button class="action-btn compare" onclick="addToCompare(2)">加入对比</button>
                            </div>
                        </div>
                    </div>

                    <!-- 西南大学 -->
                    <div class="university-item" data-id="3">
                        <div class="university-cell university-name-cell" data-label="院校名称">
                            <div class="university-name">西南大学</div>
                            <div class="university-info">
                                <span class="university-location">📍重庆市</span>
                                <span class="university-type">🏛️公办</span>
                            </div>
                            <div class="university-tags">
                                <span class="university-tag tag-211">211</span>
                                <span class="university-tag tag-double-first">双一流</span>
                            </div>
                        </div>
                        <div class="university-cell score-cell" data-label="2024年录取分">
                            <div class="score-container">
                                <div class="score-item">
                                    <span class="score-type">物理：</span>
                                    <span class="score-value">560</span>
                                </div>
                                <div class="score-item">
                                    <span class="score-type">历史：</span>
                                    <span class="score-value">594</span>
                                </div>
                                <div class="score-history">查看历年分数</div>
                            </div>
                        </div>
                        <div class="university-cell" data-label="院校类型">
                            <div class="score-value">综合类</div>
                        </div>
                        <div class="university-cell" data-label="院校标签">
                            <div class="university-tags">
                                <span class="university-tag tag-211">211</span>
                                <span class="university-tag tag-double-first">双一流</span>
                                <span class="university-tag tag-public">公办</span>
                            </div>
                        </div>
                        <div class="university-cell" data-label="院校城市">
                            <div class="score-value">重庆市</div>
                        </div>
                        <div class="university-cell actions-cell" data-label="操作">
                            <div class="university-actions">
                                <button class="action-btn" onclick="addToVolunteer(3)">加入志愿表</button>
                                <button class="action-btn compare" onclick="addToCompare(3)">加入对比</button>
                            </div>
                        </div>
                    </div>

                    <!-- 天津工业大学 -->
                    <div class="university-item" data-id="4">
                        <div class="university-cell university-name-cell" data-label="院校名称">
                            <div class="university-name">天津工业大学</div>
                            <div class="university-info">
                                <span class="university-location">📍天津市</span>
                                <span class="university-type">🏛️公办</span>
                            </div>
                            <div class="university-tags">
                                <span class="university-tag tag-double-first">双一流</span>
                            </div>
                        </div>
                        <div class="university-cell score-cell" data-label="2024年录取分">
                            <div class="score-container">
                                <div class="score-item">
                                    <span class="score-type">物理：</span>
                                    <span class="score-value">560</span>
                                </div>
                                <div class="score-item">
                                    <span class="score-type">历史：</span>
                                    <span class="score-value">560</span>
                                </div>
                                <div class="score-history">查看历年分数</div>
                            </div>
                        </div>
                        <div class="university-cell" data-label="院校类型">
                            <div class="score-value">综合类</div>
                        </div>
                        <div class="university-cell" data-label="院校标签">
                            <div class="university-tags">
                                <span class="university-tag tag-double-first">双一流</span>
                                <span class="university-tag tag-public">公办</span>
                            </div>
                        </div>
                        <div class="university-cell" data-label="院校城市">
                            <div class="score-value">天津市</div>
                        </div>
                        <div class="university-cell actions-cell" data-label="操作">
                            <div class="university-actions">
                                <button class="action-btn" onclick="addToVolunteer(4)">加入志愿表</button>
                                <button class="action-btn compare" onclick="addToCompare(4)">加入对比</button>
                            </div>
                        </div>
                    </div>

                    <!-- 汕头大学 -->
                    <div class="university-item" data-id="5">
                        <div class="university-cell university-name-cell" data-label="院校名称">
                            <div class="university-name">汕头大学</div>
                            <div class="university-info">
                                <span class="university-location">📍汕头市</span>
                                <span class="university-type">🏛️公办</span>
                            </div>
                            <div class="university-tags">
                                <span class="university-tag tag-211">211</span>
                            </div>
                        </div>
                        <div class="university-cell score-cell" data-label="2024年录取分">
                            <div class="score-container">
                                <div class="score-item">
                                    <span class="score-type">物理：</span>
                                    <span class="score-value">559</span>
                                </div>
                                <div class="score-item">
                                    <span class="score-type">历史：</span>
                                    <span class="score-value">564</span>
                                </div>
                                <div class="score-history">查看历年分数</div>
                            </div>
                        </div>
                        <div class="university-cell" data-label="院校类型">
                            <div class="score-value">综合类</div>
                        </div>
                        <div class="university-cell" data-label="院校标签">
                            <div class="university-tags">
                                <span class="university-tag tag-211">211</span>
                                <span class="university-tag tag-public">公办</span>
                            </div>
                        </div>
                        <div class="university-cell" data-label="院校城市">
                            <div class="score-value">汕头市</div>
                        </div>
                        <div class="university-cell actions-cell" data-label="操作">
                            <div class="university-actions">
                                <button class="action-btn" onclick="addToVolunteer(5)">加入志愿表</button>
                                <button class="action-btn compare" onclick="addToCompare(5)">加入对比</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 比较面板 -->
        <div class="compare-panel" id="comparePanel">
            <div class="compare-header">
                <div class="compare-title">对比列表</div>
                <div class="compare-count" id="compareCount">0</div>
            </div>
            <div class="compare-items" id="compareItems">
                <!-- 对比项目会动态添加到这里 -->
                <div class="no-data" style="text-align: center; color: #718096; padding: 10px;">暂无对比院校</div>
            </div>
            <div class="compare-actions">
                <button class="compare-action-btn btn-compare-now" id="compareNowBtn" disabled>开始对比</button>
                <button class="compare-action-btn btn-clear-all" id="clearCompareBtn">清空列表</button>
            </div>
        </div>

        <!-- 返回首页按钮 -->
        <a href="main.jsp" class="back-home">← 返回主页</a>

        <script>
            // 页面加载动画
            $(document).ready(function () {
                // 加载用户信息
                loadUserInfo();

                // 加载大学列表
                loadUniversities();

                // 初始化状态设置
                $('.corner-logo').css({
                    'opacity': '0',
                    'transform': 'translateX(-20px) translateY(-10px)'
                });

                $('.main-container').css({
                    'opacity': '0',
                    'transform': 'translateY(30px)'
                });

                $('.back-home').css({
                    'opacity': '0',
                    'transform': 'translateX(-10px)'
                });

                // 逐步显示动画
                setTimeout(() => {
                    $('.corner-logo').css({
                        'opacity': '1',
                        'transform': 'translateX(0) translateY(0)',
                        'transition': 'all 0.6s cubic-bezier(0.34, 1.56, 0.64, 1)'
                    });
                }, 200);

                setTimeout(() => {
                    $('.main-container').css({
                        'opacity': '1',
                        'transform': 'translateY(0)',
                        'transition': 'all 0.6s cubic-bezier(0.34, 1.56, 0.64, 1)'
                    });
                }, 400);

                setTimeout(() => {
                    $('.back-home').css({
                        'opacity': '1',
                        'transform': 'translateX(0)',
                        'transition': 'all 0.4s ease'
                    });
                }, 600);

                // 初始化比较列表
                let compareList = [];
                let userInfo = null;

                // 加载用户信息
                function loadUserInfo() {
                    $.ajax({
                        url: '/api/user/info',
                        type: 'GET',
                        dataType: 'json',
                        success: function (data) {
                            if (data.success && data.score) {
                                userInfo = data;
                                const province = data.province || '未设置';
                                const subject = data.subject || '未设置';
                                const score = data.score;
                                $('#userScoreInfo').text(province + '·' + subject + '·' + score + '分');
                            } else {
                                $('#userScoreInfo').html('<a href="/main.jsp" style="color:#2B6CB0;">请先输入成绩</a>');
                            }
                        },
                        error: function () {
                            $('#userScoreInfo').html('<a href="/main.jsp" style="color:#2B6CB0;">请先输入成绩</a>');
                        }
                    });
                }

                // 加载大学列表
                function loadUniversities(params) {
                    params = params || {};
                    let url = '/api/universities?limit=50';
                    if (params.keyword) url += '&keyword=' + encodeURIComponent(params.keyword);
                    if (params.province) url += '&province=' + encodeURIComponent(params.province);
                    if (params.is985) url += '&is985=1';
                    if (params.is211) url += '&is211=1';

                    $.ajax({
                        url: url,
                        type: 'GET',
                        dataType: 'json',
                        success: function (data) {
                            if (data.success) {
                                renderUniversities(data.data);
                            }
                        },
                        error: function () {
                            console.error('Failed to load universities');
                        }
                    });
                }

                // 渲染大学列表
                function renderUniversities(universities) {
                    const $list = $('#universityList');
                    $list.empty();

                    if (!universities || universities.length === 0) {
                        $list.html('<div style="text-align:center;padding:40px;color:#666;">暂无匹配的院校</div>');
                        return;
                    }

                    universities.forEach(function (uni) {
                        const tags = [];
                        if (uni.is985) tags.push('<span class="university-tag tag-985">985</span>');
                        if (uni.is211) tags.push('<span class="university-tag tag-211">211</span>');
                        if (uni.isDoubleFirst) tags.push('<span class="university-tag tag-double-first">双一流</span>');

                        const html = '<div class="university-item" data-id="' + uni.id + '">' +
                            '<div class="university-cell university-name-cell" data-label="院校名称">' +
                            '<div class="university-name">' + uni.name + '</div>' +
                            '<div class="university-info">' +
                            '<span class="university-location">📍' + (uni.city || uni.province) + '</span>' +
                            '<span class="university-type">🏛️' + (uni.type || '综合') + '</span>' +
                            '</div>' +
                            '<div class="university-tags">' + tags.join('') + '</div>' +
                            '</div>' +
                            '<div class="university-cell score-cell" data-label="2024年录取分">' +
                            '<div class="score-container">' +
                            '<div class="score-item">' +
                            '<span class="score-type">最低分：</span>' +
                            '<span class="score-value">' + (uni.minScore2024 || '--') + '</span>' +
                            '</div>' +
                            '<div class="score-item">' +
                            '<span class="score-type">最低位次：</span>' +
                            '<span class="score-value">' + (uni.minRank2024 || '--') + '</span>' +
                            '</div>' +
                            '</div>' +
                            '<button class="score-history">查看历年</button>' +
                            '</div>' +
                            '<div class="university-cell" data-label="院校类型">' +
                            '<div class="type-badge type-science">' + (uni.type || '综合类') + '</div>' +
                            '</div>' +
                            '<div class="university-cell" data-label="院校标签">' +
                            '<div class="tag-list">' + tags.join('') + '</div>' +
                            '</div>' +
                            '<div class="university-cell" data-label="院校城市">' +
                            '<div class="city-badge">📍' + (uni.city || uni.province) + '</div>' +
                            '</div>' +
                            '<div class="university-cell university-actions" data-label="操作">' +
                            '<button class="action-btn btn-compare" data-id="' + uni.id + '" data-name="' + uni.name + '">加入对比</button>' +
                            '<button class="action-btn btn-volunteer" onclick="addToVolunteer(' + uni.id + ')">加入志愿表</button>' +
                            '</div>' +
                            '</div>';

                        $list.append(html);
                    });
                }

                // 搜索功能
                $('#searchBtn').click(function () {
                    performSearch();
                });

                // 回车键搜索
                $('#universitySearch').keypress(function (e) {
                    if (e.which === 13) {
                        performSearch();
                    }
                });

                // 搜索功能实现 - 调用API
                function performSearch() {
                    const searchTerm = $('#universitySearch').val();
                    const selectedTags = $('input[name="tag"]:checked').map(function () {
                        return $(this).val();
                    }).get();

                    const params = {
                        keyword: searchTerm,
                        is985: selectedTags.includes('985'),
                        is211: selectedTags.includes('211')
                    };

                    loadUniversities(params);
                }

                // 查看历年分数
                $('.score-history').click(function () {
                    const universityName = $(this).closest('.university-item').find('.university-name').text();
                    alert('查看 ' + universityName + ' 的历年录取分数数据\n（实际应用中这里会跳转到详细页面）');
                });

                // 添加对比功能
                window.addToCompare = function (universityId) {
                    const $item = $(`.university-item[data-id="${universityId}"]`);
                    const name = $item.find('.university-name').text();

                    // 检查是否已经在对比列表中
                    if (compareList.some(item => item.id === universityId)) {
                        alert('该院校已在对比列表中！');
                        return;
                    }

                    // 限制最多选择5所院校
                    if (compareList.length >= 5) {
                        alert('最多只能选择5所院校进行对比！');
                        return;
                    }

                    // 添加到对比列表
                    compareList.push({
                        id: universityId,
                        name: name
                    });

                    // 更新对比面板
                    updateComparePanel();

                    // 显示提示
                    showNotification('已添加 ' + name + ' 到对比列表');
                };

                // 更新对比面板
                function updateComparePanel() {
                    const $panel = $('#comparePanel');
                    const $items = $('#compareItems');
                    const $count = $('#compareCount');
                    const $compareBtn = $('#compareNowBtn');

                    // 更新计数
                    $count.text(compareList.length);

                    // 清空并重新生成列表
                    $items.empty();

                    if (compareList.length === 0) {
                        $items.append('<div class="no-data" style="text-align: center; color: #718096; padding: 10px;">暂无对比院校</div>');
                        $compareBtn.prop('disabled', true);
                    } else {
                        compareList.forEach(item => {
                            const $item = $(`
                        <div class="compare-item" data-id="${item.id}">
                            <span class="compare-item-name">${item.name}</span>
                            <button class="remove-compare" data-id="${item.id}">×</button>
                        </div>
                    `);
                            $items.append($item);
                        });
                        $compareBtn.prop('disabled', false);
                    }

                    // 显示对比面板
                    $panel.addClass('show');
                }

                // 从对比列表中移除
                $(document).on('click', '.remove-compare', function () {
                    const id = parseInt($(this).data('id'));
                    compareList = compareList.filter(item => item.id !== id);
                    updateComparePanel();
                });

                // 清空对比列表
                $('#clearCompareBtn').click(function () {
                    if (compareList.length > 0) {
                        if (confirm('确定要清空对比列表吗？')) {
                            compareList = [];
                            updateComparePanel();
                            showNotification('已清空对比列表');
                        }
                    }
                });

                // 开始对比
                $('#compareNowBtn').click(function () {
                    if (compareList.length < 2) {
                        alert('请至少选择2个院校进行对比！');
                        return;
                    }

                    alert('开始对比 ' + compareList.length + ' 所院校\n（实际应用中这里会跳转到对比页面，对比院校ID：' + compareList.map(item => item.id).join(',') + '）');
                });

                // 加入志愿表
                window.addToVolunteer = function (universityId) {
                    const $item = $(`.university-item[data-id="${universityId}"]`);
                    const name = $item.find('.university-name').text();
                    showNotification('已添加 ' + name + ' 到志愿表');
                    // 这里可以添加实际的AJAX请求到后端
                };

                // 显示通知
                function showNotification(message) {
                    // 创建通知元素
                    const $notification = $(`
                <div class="notification" style="
                    position: fixed;
                    top: 25px;
                    right: 25px;
                    background: linear-gradient(135deg, #4299E1, #2B6CB0);
                    color: white;
                    padding: 12px 20px;
                    border-radius: 10px;
                    font-family: 'ZCOOL XiaoWei', serif;
                    font-size: 0.95em;
                    box-shadow: 0 4px 15px rgba(66, 153, 225, 0.3);
                    z-index: 10000;
                    transform: translateX(100px);
                    opacity: 0;
                    transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
                ">
                    ${message}
                </div>
            `);

                    // 添加到页面
                    $('body').append($notification);

                    // 显示动画
                    setTimeout(() => {
                        $notification.css({
                            'transform': 'translateX(0)',
                            'opacity': '1'
                        });
                    }, 10);

                    // 2秒后移除
                    setTimeout(() => {
                        $notification.css({
                            'transform': 'translateX(100px)',
                            'opacity': '0'
                        });
                        setTimeout(() => {
                            $notification.remove();
                        }, 400);
                    }, 1800);
                }
            });
        </script>
    </body>

    </html>