<%-- Created by IntelliJ IDEA. User: 35389 Date: 2025/6/19 Time: 11:25 To change this template use File | Settings |
    File Templates. --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
        <html>

        <head>
            <title>智选志愿-我的志愿表</title>
            <%--引入jquery工具类--%>
                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                <link
                    href="https://fonts.googleapis.com/css2?family=Ma+Shan+Zheng&family=ZCOOL+QingKe+HuangYou&family=ZCOOL+XiaoWei&display=swap"
                    rel="stylesheet">
                <style>
                    /* 全局样式 - 与主页面一致的蓝天白云背景 */
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
                        overflow-y: auto;
                        position: relative;
                        width: 100vw;
                    }

                    /* 天空云朵背景层 */
                    .sky-background {
                        position: fixed;
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
                        top: 15%;
                        left: 5%;
                    }

                    .cloud-2 {
                        width: 180px;
                        height: 60px;
                        top: 30%;
                        right: 8%;
                        animation-delay: 5s;
                    }

                    .cloud-3 {
                        width: 130px;
                        height: 45px;
                        top: 60%;
                        left: 15%;
                        animation-delay: 10s;
                    }

                    .cloud-4 {
                        width: 160px;
                        height: 55px;
                        top: 20%;
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
                        position: fixed;
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
                        width: 90%;
                        max-width: 1200px;
                        margin: 100px auto 50px;
                        padding: 30px;
                        background: rgba(255, 255, 255, 0.95);
                        backdrop-filter: blur(10px);
                        border-radius: 20px;
                        box-shadow:
                            0 15px 35px rgba(0, 0, 0, 0.15),
                            0 0 0 1px rgba(255, 255, 255, 0.6);
                    }

                    /* 页面标题 */
                    .page-title {
                        font-family: 'Ma Shan Zheng', cursive;
                        font-size: 2.8em;
                        color: #1E3A5F;
                        text-align: center;
                        margin-bottom: 30px;
                        text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.1);
                        padding-bottom: 15px;
                        border-bottom: 2px solid rgba(43, 108, 176, 0.3);
                    }

                    /* 志愿表容器 */
                    .volunteer-container {
                        margin-bottom: 50px;
                    }

                    /* 志愿表卡片 */
                    .volunteer-card {
                        background: white;
                        border-radius: 15px;
                        padding: 25px;
                        margin-bottom: 25px;
                        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
                        border: 1px solid rgba(43, 108, 176, 0.1);
                        transition: all 0.3s ease;
                    }

                    .volunteer-card:hover {
                        transform: translateY(-5px);
                        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
                        border-color: rgba(43, 108, 176, 0.2);
                    }

                    /* 志愿表标题 */
                    .volunteer-title {
                        font-family: 'ZCOOL QingKe HuangYou', sans-serif;
                        font-size: 1.8em;
                        color: #2C5282;
                        margin-bottom: 15px;
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                    }

                    .volunteer-year {
                        background: linear-gradient(135deg, #2B6CB0, #2C5282);
                        color: white;
                        padding: 5px 15px;
                        border-radius: 20px;
                        font-size: 0.8em;
                    }

                    /* 志愿表信息 */
                    .volunteer-info {
                        background: rgba(43, 108, 176, 0.05);
                        border-radius: 10px;
                        padding: 15px;
                        margin-bottom: 20px;
                    }

                    .info-grid {
                        display: grid;
                        grid-template-columns: repeat(5, 1fr);
                        gap: 15px;
                    }

                    .info-item {
                        text-align: center;
                    }

                    .info-label {
                        font-family: 'ZCOOL XiaoWei', serif;
                        font-size: 0.9em;
                        color: #4A5568;
                        margin-bottom: 5px;
                    }

                    .info-value {
                        font-family: 'ZCOOL QingKe HuangYou', sans-serif;
                        font-size: 1.2em;
                        color: #2C5282;
                        font-weight: 600;
                    }

                    .placeholder-value {
                        font-family: 'ZCOOL QingKe HuangYou', sans-serif;
                        font-size: 1.2em;
                        color: #A0AEC0;
                        font-weight: 600;
                    }

                    /* 志愿列表 */
                    .volunteer-list {
                        margin: 20px 0;
                    }

                    .volunteer-list-title {
                        font-family: 'ZCOOL QingKe HuangYou', sans-serif;
                        font-size: 1.2em;
                        color: #2C5282;
                        margin-bottom: 10px;
                        display: flex;
                        align-items: center;
                    }

                    .volunteer-list-title::before {
                        content: "📝";
                        margin-right: 10px;
                    }

                    .volunteer-items {
                        display: flex;
                        flex-wrap: wrap;
                        gap: 15px;
                        margin-top: 15px;
                    }

                    .volunteer-item {
                        background: linear-gradient(135deg, rgba(66, 153, 225, 0.1), rgba(100, 179, 244, 0.05));
                        border: 1px solid rgba(66, 153, 225, 0.2);
                        border-radius: 10px;
                        padding: 12px 20px;
                        font-family: 'ZCOOL XiaoWei', serif;
                        color: #2C5282;
                        transition: all 0.3s ease;
                        min-width: 200px;
                    }

                    .placeholder-item {
                        background: linear-gradient(135deg, rgba(160, 174, 192, 0.1), rgba(203, 213, 224, 0.05));
                        border: 1px dashed rgba(160, 174, 192, 0.3);
                        color: #A0AEC0;
                    }

                    .volunteer-item:hover {
                        background: linear-gradient(135deg, rgba(66, 153, 225, 0.15), rgba(100, 179, 244, 0.1));
                        transform: translateY(-2px);
                    }

                    .item-rank {
                        background: #2B6CB0;
                        color: white;
                        width: 28px;
                        height: 28px;
                        border-radius: 50%;
                        display: inline-flex;
                        align-items: center;
                        justify-content: center;
                        margin-right: 8px;
                        font-size: 0.9em;
                    }

                    .placeholder-rank {
                        background: #CBD5E0;
                    }

                    /* 志愿表时间 */
                    .volunteer-time {
                        font-family: 'ZCOOL XiaoWei', serif;
                        color: #718096;
                        font-size: 0.9em;
                        text-align: right;
                        margin-top: 15px;
                        padding-top: 15px;
                        border-top: 1px solid rgba(0, 0, 0, 0.1);
                    }

                    /* 空状态提示 */
                    .empty-message {
                        text-align: center;
                        padding: 50px 20px;
                        color: #718096;
                        font-family: 'ZCOOL XiaoWei', serif;
                        font-size: 1.1em;
                    }

                    .empty-message .empty-icon {
                        font-size: 3em;
                        margin-bottom: 20px;
                        display: block;
                    }

                    /* 分割线 */
                    .divider {
                        height: 2px;
                        background: linear-gradient(90deg, transparent, rgba(43, 108, 176, 0.3), transparent);
                        margin: 40px 0;
                    }

                    /* 新建志愿表区域 */
                    .new-volunteer {
                        background: linear-gradient(135deg, rgba(72, 187, 120, 0.1), rgba(104, 211, 145, 0.05));
                        border: 2px dashed rgba(72, 187, 120, 0.3);
                        border-radius: 15px;
                        padding: 40px 30px;
                        text-align: center;
                        margin-top: 30px;
                        cursor: pointer;
                        transition: all 0.3s ease;
                    }

                    .new-volunteer:hover {
                        background: linear-gradient(135deg, rgba(72, 187, 120, 0.15), rgba(104, 211, 145, 0.1));
                        border-color: rgba(72, 187, 120, 0.5);
                        transform: translateY(-3px);
                    }

                    .new-icon {
                        font-size: 3em;
                        margin-bottom: 20px;
                        display: block;
                    }

                    .new-title {
                        font-family: 'ZCOOL QingKe HuangYou', sans-serif;
                        font-size: 2em;
                        color: #38A169;
                        margin-bottom: 15px;
                    }

                    .new-description {
                        font-family: 'ZCOOL XiaoWei', serif;
                        color: #4A5568;
                        font-size: 1.1em;
                        max-width: 600px;
                        margin: 0 auto;
                        line-height: 1.5;
                    }

                    /* 底部导航栏 */
                    .bottom-nav {
                        position: fixed;
                        bottom: 0;
                        left: 0;
                        width: 100%;
                        background: rgba(255, 255, 255, 0.98);
                        backdrop-filter: blur(10px);
                        border-top: 1px solid rgba(43, 108, 176, 0.2);
                        z-index: 1000;
                        padding: 15px 0;
                        box-shadow: 0 -5px 20px rgba(0, 0, 0, 0.1);
                    }

                    .nav-container {
                        display: flex;
                        justify-content: space-around;
                        align-items: center;
                        max-width: 600px;
                        margin: 0 auto;
                    }

                    .nav-item {
                        display: flex;
                        flex-direction: column;
                        align-items: center;
                        text-decoration: none;
                        color: #4A5568;
                        font-family: 'ZCOOL XiaoWei', serif;
                        font-size: 0.9em;
                        transition: all 0.3s ease;
                        padding: 8px 15px;
                        border-radius: 10px;
                    }

                    .nav-item:hover {
                        background: rgba(43, 108, 176, 0.05);
                        color: #2B6CB0;
                        transform: translateY(-2px);
                    }

                    .nav-item.active {
                        color: #2B6CB0;
                        background: rgba(43, 108, 176, 0.1);
                        font-weight: 600;
                    }

                    .nav-icon {
                        font-size: 1.8em;
                        margin-bottom: 5px;
                    }

                    /* 返回按钮 */
                    .back-button {
                        position: fixed;
                        top: 30px;
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

                    .back-button:hover {
                        background: rgba(30, 58, 95, 0.9);
                        transform: translateY(-3px);
                        box-shadow:
                            0 8px 25px rgba(43, 108, 176, 0.4),
                            0 0 20px rgba(43, 108, 176, 0.3);
                    }

                    /* 响应式设计 */
                    @media (max-width: 992px) {
                        .page-container {
                            width: 95%;
                            padding: 20px;
                            margin: 90px auto 120px;
                        }

                        .page-title {
                            font-size: 2.4em;
                        }

                        .info-grid {
                            grid-template-columns: repeat(3, 1fr);
                            gap: 10px;
                        }

                        .volunteer-items {
                            flex-direction: column;
                        }

                        .volunteer-item {
                            width: 100%;
                        }
                    }

                    @media (max-width: 768px) {
                        .page-container {
                            margin: 80px auto 120px;
                            padding: 15px;
                        }

                        .page-title {
                            font-size: 2em;
                        }

                        .volunteer-title {
                            flex-direction: column;
                            align-items: flex-start;
                            gap: 10px;
                        }

                        .volunteer-year {
                            align-self: flex-start;
                        }

                        .info-grid {
                            grid-template-columns: repeat(2, 1fr);
                        }

                        .back-button {
                            top: 20px;
                            left: 20px;
                            padding: 8px 20px;
                            font-size: 0.9em;
                        }
                    }

                    @media (max-width: 480px) {
                        .page-container {
                            margin: 70px auto 120px;
                        }

                        .page-title {
                            font-size: 1.8em;
                        }

                        .volunteer-card {
                            padding: 20px 15px;
                        }

                        .volunteer-title {
                            font-size: 1.5em;
                        }

                        .info-grid {
                            grid-template-columns: 1fr;
                        }

                        .nav-item {
                            padding: 5px 10px;
                            font-size: 0.8em;
                        }

                        .nav-icon {
                            font-size: 1.5em;
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

            <!-- 返回按钮 -->
            <a href="main.jsp" class="back-button">返回主页面</a>

            <!-- 主内容区域 -->
            <div class="page-container">
                <h1 class="page-title">我的志愿表</h1>

                <!-- 志愿表容器 -->
                <div class="volunteer-container" id="volunteerContainer">
                    <!-- 空状态提示 -->
                    <div class="empty-message" id="emptyMessage">
                        <span class="empty-icon">📋</span>
                        <p>您还没有创建任何志愿表</p>
                        <p>点击下方"新建志愿表"开始创建您的第一个志愿方案</p>
                    </div>

                    <!-- 志愿表卡片模板（隐藏，用于动态添加） -->
                    <div class="volunteer-card" id="volunteerTemplate" style="display: none;">
                        <div class="volunteer-title">
                            <span class="volunteer-name">志愿表名称</span>
                            <span class="volunteer-year">年份</span>
                        </div>

                        <div class="volunteer-info">
                            <div class="info-grid">
                                <div class="info-item">
                                    <div class="info-label">已填报</div>
                                    <div class="info-value">0/45</div>
                                </div>
                                <div class="info-item">
                                    <div class="info-label">省份</div>
                                    <div class="placeholder-value">未选择</div>
                                </div>
                                <div class="info-item">
                                    <div class="info-label">选科</div>
                                    <div class="placeholder-value">未选择</div>
                                </div>
                                <div class="info-item">
                                    <div class="info-label">高考分数</div>
                                    <div class="placeholder-value">0分</div>
                                </div>
                                <div class="info-item">
                                    <div class="info-label">全省排名</div>
                                    <div class="placeholder-value">0名</div>
                                </div>
                            </div>
                        </div>

                        <div class="volunteer-list">
                            <div class="volunteer-list-title">志愿列表</div>
                            <div class="volunteer-items">
                                <!-- 空志愿列表提示 -->
                                <div class="volunteer-item placeholder-item">
                                    <span class="item-rank placeholder-rank">1</span>
                                    <span>待添加院校</span>
                                </div>
                                <div class="volunteer-item placeholder-item">
                                    <span class="item-rank placeholder-rank">2</span>
                                    <span>待添加院校</span>
                                </div>
                                <div class="volunteer-item placeholder-item">
                                    <span class="item-rank placeholder-rank">3</span>
                                    <span>待添加院校</span>
                                </div>
                            </div>
                        </div>

                        <div class="volunteer-time">
                            创建时间：<span class="create-time">--</span>
                        </div>
                    </div>
                </div>

                <!-- 分割线 -->
                <div class="divider"></div>

                <!-- 新建志愿表 -->
                <div class="new-volunteer" id="newVolunteer">
                    <span class="new-icon">➕</span>
                    <h2 class="new-title">新建志愿表</h2>
                    <p class="new-description">点击这里创建新的志愿填报方案，系统将根据您的成绩和选科智能推荐合适的院校和专业</p>
                </div>
            </div>

            <!-- 底部导航栏 -->
            <div class="bottom-nav">
                <div class="nav-container">
                    <a href="main.jsp" class="nav-item">
                        <span class="nav-icon">🏠</span>
                        <span>首页</span>
                    </a>
                    <a href="/1SmartMajors.jsp" class="nav-item">
                        <span class="nav-icon">📋🏫</span>
                        <span>智慧选志愿</span>
                    </a>
                    <a href="/1University.jsp" class="nav-item active">
                        <span class="nav-icon">🏫</span>
                        <span>查大学</span>
                    </a>
                    <a href="/1SearchMajor.jsp" class="nav-item">
                        <span class="nav-icon">📊</span>
                        <span>查专业</span>
                    </a>
                </div>
            </div>

            <script>
                // 页面加载动画
                $(document).ready(function () {
                    // 初始状态设置
                    $('.page-container').css({
                        'opacity': '0',
                        'transform': 'translateY(30px)'
                    });

                    $('.empty-message').css({
                        'opacity': '0',
                        'transform': 'translateY(20px)'
                    });

                    $('.new-volunteer').css({
                        'opacity': '0',
                        'transform': 'translateY(20px)'
                    });

                    $('.bottom-nav').css({
                        'opacity': '0',
                        'transform': 'translateY(20px)'
                    });

                    // 逐步显示动画
                    setTimeout(() => {
                        $('.page-container').css({
                            'opacity': '1',
                            'transform': 'translateY(0)',
                            'transition': 'all 0.8s cubic-bezier(0.34, 1.56, 0.64, 1)'
                        });
                    }, 300);

                    setTimeout(() => {
                        $('.empty-message').css({
                            'opacity': '1',
                            'transform': 'translateY(0)',
                            'transition': 'all 0.6s ease 0.2s'
                        });
                    }, 500);

                    setTimeout(() => {
                        $('.new-volunteer').css({
                            'opacity': '1',
                            'transform': 'translateY(0)',
                            'transition': 'all 0.6s ease 0.4s'
                        });
                    }, 700);

                    setTimeout(() => {
                        $('.bottom-nav').css({
                            'opacity': '1',
                            'transform': 'translateY(0)',
                            'transition': 'all 0.6s ease 0.6s'
                        });
                    }, 900);

                    // 新建志愿表点击事件
                    $('#newVolunteer').click(function () {
                        // 点击反馈效果
                        $(this).css({
                            'transform': 'scale(0.98)',
                            'transition': 'all 0.1s ease'
                        });

                        setTimeout(() => {
                            $(this).css({
                                'transform': 'scale(1)',
                                'transition': 'all 0.3s ease'
                            });

                            // 创建新的志愿表卡片
                            createNewVolunteerCard();
                        }, 200);
                    });

                    // 创建新志愿表卡片的函数
                    function createNewVolunteerCard() {
                        // 隐藏空状态提示
                        $('#emptyMessage').fadeOut(300, function () {
                            // 复制模板
                            const template = $('#volunteerTemplate').clone();
                            template.removeAttr('id').removeAttr('style');

                            // 设置默认数据
                            const now = new Date();
                            const currentYear = now.getFullYear();
                            const formattedTime = `${currentYear}-${(now.getMonth() + 1).toString().padStart(2, '0')}-${now.getDate().toString().padStart(2, '0')} ${now.getHours().toString().padStart(2, '0')}:${now.getMinutes().toString().padStart(2, '0')}`;

                            template.find('.volunteer-name').text('新志愿表');
                            template.find('.volunteer-year').text(currentYear);
                            template.find('.create-time').text(formattedTime);

                            // 添加到容器顶部
                            $('#volunteerContainer').prepend(template);

                            // 显示动画
                            template.css({
                                'opacity': '0',
                                'transform': 'translateY(-20px)'
                            });

                            setTimeout(() => {
                                template.css({
                                    'opacity': '1',
                                    'transform': 'translateY(0)',
                                    'transition': 'all 0.6s ease'
                                });

                                // 为新建的卡片添加事件
                                bindVolunteerCardEvents(template);
                            }, 100);
                        });
                    }

                    // 绑定志愿表卡片事件
                    function bindVolunteerCardEvents(card) {
                        // 卡片标题点击可编辑
                        card.find('.volunteer-name').click(function () {
                            const currentText = $(this).text();
                            $(this).html(`<input type="text" value="${currentText}" class="edit-name-input">`);

                            const input = $(this).find('.edit-name-input');
                            input.focus();
                            input.select();

                            input.on('blur keypress', function (e) {
                                if (e.type === 'blur' || (e.type === 'keypress' && e.which === 13)) {
                                    const newName = input.val().trim() || '新志愿表';
                                    $(this).parent().text(newName);
                                }
                            });
                        });

                        // 志愿项点击事件
                        card.find('.volunteer-item').click(function (e) {
                            e.stopPropagation();
                            const rank = $(this).find('.item-rank').text();
                            const isPlaceholder = $(this).hasClass('placeholder-item');

                            if (isPlaceholder) {
                                // 如果是占位符项，提示添加院校
                                alert(`请为第${rank}志愿添加院校`);
                                // 这里可以打开院校选择器
                            } else {
                                console.log(`查看第${rank}志愿`);
                                // 这里可以查看院校详情
                            }
                        });
                    }

                    // 导航项点击事件
                    $('.nav-item').click(function (e) {
                        $('.nav-item').removeClass('active');
                        $(this).addClass('active');

                        const navText = $(this).find('span:last').text();
                        console.log(`导航到: ${navText}`);

                        // 这里可以添加实际的页面跳转逻辑
                        if (navText === '首页') {
                            window.location.href = 'main.jsp';
                        }
                    });
                });
            </script>
        </body>

        </html>