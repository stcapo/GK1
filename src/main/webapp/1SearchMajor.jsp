<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
    <html>

    <head>
        <title>智选志愿-查专业</title>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link
            href="https://fonts.googleapis.com/css2?family=Ma+Shan+Zheng&family=ZCOOL+QingKe+HuangYou&family=ZCOOL+XiaoWei&display=swap"
            rel="stylesheet">
        <style>
            /* ========= 完全复用主页的蓝天白云背景 ========= */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'ZCOOL XiaoWei', 'Microsoft YaHei', sans-serif;
                background: linear-gradient(to bottom, #87CEEB 0%, #B0E2FF 40%, #87CEEB 80%, #4682B4 100%);
                min-height: 100vh;
                overflow: hidden;
                position: relative;
                width: 100vw;
                height: 100vh;
            }

            .sky-background {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                z-index: 0;
                overflow: hidden;
            }

            .sun-glow {
                position: absolute;
                top: 8%;
                right: 8%;
                width: 120px;
                height: 120px;
                background: radial-gradient(circle, rgba(255, 255, 180, 0.9) 0%, rgba(255, 255, 140, 0.7) 30%, rgba(255, 255, 100, 0.4) 60%, transparent 80%);
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

            /* 云朵样式直接拷贝主页，省略重复代码，保持动画一致 */
            .cloud {
                position: absolute;
                background: rgba(255, 255, 255, 0.95);
                z-index: 1;
                filter: blur(1px);
            }

            .cloud-1 {
                width: 180px;
                height: 60px;
                top: 20%;
                left: 10%;
                border-radius: 60px;
                animation: cloudFloat1 20s ease-in-out infinite alternate;
            }

            .cloud-2 {
                width: 220px;
                height: 70px;
                top: 40%;
                right: 15%;
                border-radius: 70px;
                animation: cloudFloat2 25s ease-in-out infinite alternate;
                animation-delay: 5s;
            }

            .cloud-3 {
                width: 160px;
                height: 55px;
                top: 70%;
                left: 20%;
                border-radius: 55px;
                animation: cloudFloat3 18s ease-in-out infinite alternate;
                animation-delay: 10s;
            }

            .cloud-4 {
                width: 200px;
                height: 65px;
                top: 30%;
                right: 5%;
                border-radius: 65px;
                animation: cloudFloat4 22s ease-in-out infinite alternate;
                animation-delay: 15s;
            }

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

            /* ========= 顶部通用导航栏 ========= */
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
                text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.15), 0 0 15px rgba(255, 255, 255, 0.8);
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
                box-shadow: 0 5px 20px rgba(43, 108, 176, 0.3), 0 0 15px rgba(43, 108, 176, 0.2);
                transition: all 0.3s ease;
                backdrop-filter: blur(5px);
            }

            .back-home:hover {
                background: rgba(30, 58, 95, 0.9);
                transform: translateY(-3px);
                box-shadow: 0 8px 25px rgba(43, 108, 176, 0.4), 0 0 20px rgba(43, 108, 176, 0.3);
            }

            /* ========= 查专业主面板 ========= */
            .main-panel {
                position: relative;
                z-index: 2;
                width: 90%;
                max-width: 1200px;
                height: calc(100vh - 120px);
                margin: 100px auto 0;
                display: flex;
                flex-direction: column;
                gap: 25px;
            }

            /* 搜索条 */
            .search-bar {
                display: flex;
                gap: 15px;
                align-items: center;
                background: rgba(255, 255, 255, 0.9);
                backdrop-filter: blur(10px);
                padding: 15px 25px;
                border-radius: 30px;
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1), 0 0 0 1px rgba(255, 255, 255, 0.6);
            }

            .search-input {
                flex: 1;
                border: none;
                outline: none;
                font-family: 'ZCOOL XiaoWei', serif;
                font-size: 1.1em;
                color: #2C5282;
                background: transparent;
            }

            .search-btn {
                background: linear-gradient(135deg, #2B6CB0, #2C5282);
                color: white;
                border: none;
                padding: 10px 30px;
                border-radius: 25px;
                font-family: 'ZCOOL QingKe HuangYou', sans-serif;
                font-size: 1em;
                cursor: pointer;
                box-shadow: 0 5px 15px rgba(43, 108, 176, 0.3);
                transition: all 0.3s ease;
            }

            .search-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(43, 108, 176, 0.4);
            }

            /* 快速分类 */
            .quick-tags {
                display: flex;
                gap: 12px;
                flex-wrap: wrap;
            }

            .tag {
                background: rgba(255, 255, 255, 0.8);
                border: 1px solid rgba(255, 255, 255, 0.6);
                color: #2C5282;
                padding: 6px 18px;
                border-radius: 20px;
                font-size: 0.95em;
                cursor: pointer;
                transition: all 0.3s ease;
                backdrop-filter: blur(5px);
            }

            .tag:hover {
                background: white;
                color: #1E3A5F;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            }

            /* 结果区域 */
            .result-area {
                flex: 1;
                display: flex;
                gap: 25px;
            }

            /* 左侧学科树 */
            .subject-tree {
                width: 220px;
                background: rgba(255, 255, 255, 0.85);
                backdrop-filter: blur(10px);
                border-radius: 20px;
                padding: 20px;
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1), 0 0 0 1px rgba(255, 255, 255, 0.6);
                font-family: 'ZCOOL XiaoWei', serif;
                color: #2C5282;
            }

            .subject-tree h3 {
                margin-bottom: 15px;
                font-size: 1.3em;
            }

            .subject-tree ul {
                list-style: none;
                padding-left: 10px;
                line-height: 1.8;
            }

            .subject-tree li {
                cursor: pointer;
                transition: color 0.2s;
            }

            .subject-tree li:hover {
                color: #1E3A5F;
                font-weight: bold;
            }

            /* 右侧专业卡片列表 */
            .major-list {
                flex: 1;
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
                gap: 20px;
                overflow-y: auto;
                padding-right: 8px;
            }

            .major-card {
                background: rgba(255, 255, 255, 0.9);
                backdrop-filter: blur(10px);
                border-radius: 20px;
                padding: 20px;
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1), 0 0 0 1px rgba(255, 255, 255, 0.6);
                display: flex;
                flex-direction: column;
                gap: 10px;
                transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
            }

            .major-card:hover {
                transform: translateY(-5px) scale(1.02);
                box-shadow: 0 12px 35px rgba(0, 0, 0, 0.15);
            }

            .major-title {
                font-family: 'ZCOOL QingKe HuangYou', sans-serif;
                font-size: 1.4em;
                color: #1E3A5F;
            }

            .major-desc {
                font-size: 0.95em;
                color: #4A5568;
                line-height: 1.4;
            }

            .major-tag {
                align-self: flex-start;
                background: #2B6CB0;
                color: white;
                font-size: 0.8em;
                padding: 4px 10px;
                border-radius: 12px;
            }

            /* 响应式 */
            @media(max-width:992px) {
                .result-area {
                    flex-direction: column;
                }

                .subject-tree {
                    width: 100%;
                    display: flex;
                    gap: 12px;
                    overflow-x: auto;
                    padding: 12px;
                }

                .subject-tree ul {
                    display: flex;
                    gap: 12px;
                }
            }

            @media(max-width:576px) {
                .main-panel {
                    margin-top: 80px;
                }

                .search-bar {
                    flex-direction: column;
                }

                .major-list {
                    grid-template-columns: 1fr;
                }
            }
        </style>
    </head>

    <body>
        <!-- ======== 蓝天白云背景（与主页完全一致） ======== -->
        <div class="sky-background">
            <div class="sun-glow"></div>
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

        <!-- 左上角 Logo -->
        <div class="corner-logo">
            <div class="logo-text">智选志愿</div>
            <div class="sub-logo">INTELLIGENT SELECTION</div>
        </div>

        <!-- 返回首页 -->
        <a href="/main.jsp" class="back-home">返回首页</a>

        <!-- ======== 查专业主面板 ======== -->
        <div class="main-panel">
            <!-- 搜索条 -->
            <div class="search-bar">
                <input class="search-input" id="keyword" type="text" placeholder="搜索专业名称、代码、关键词...">
                <button class="search-btn" id="searchBtn">搜索</button>
            </div>

            <!-- 快速分类 -->
            <div class="quick-tags">
                <span class="tag" data-cate="工学">工学</span>
                <span class="tag" data-cate="医学">医学</span>
                <span class="tag" data-cate="文学">文学</span>
                <span class="tag" data-cate="管理学">管理学</span>
                <span class="tag" data-cate="理学">理学</span>
                <span class="tag" data-cate="经济学">经济学</span>
                <span class="tag" data-cate="艺术学">艺术学</span>
            </div>

            <!-- 结果区域 -->
            <div class="result-area">
                <!-- 左侧学科树 -->
                <aside class="subject-tree">
                    <h3>学科门类</h3>
                    <ul>
                        <li data-code="08">工学</li>
                        <li data-code="10">医学</li>
                        <li data-code="05">文学</li>
                        <li data-code="12">管理学</li>
                        <li data-code="07">理学</li>
                        <li data-code="02">经济学</li>
                        <li data-code="13">艺术学</li>
                    </ul>
                </aside>

                <!-- 右侧专业卡片列表 -->
                <div class="major-list" id="majorList">
                    <!-- 静态占位卡片（后期删） -->
                    <div class="major-card">
                        <div class="major-title">计算机科学与技术</div>
                        <div class="major-desc">培养具备计算机软硬件、算法、网络等综合能力的高级工程技术人才。</div>
                        <span class="major-tag">工学</span>
                    </div>
                    <div class="major-card">
                        <div class="major-title">临床医学</div>
                        <div class="major-desc">系统掌握基础医学、临床医学的基本理论与临床技能。</div>
                        <span class="major-tag">医学</span>
                    </div>
                    <div class="major-card">
                        <div class="major-title">汉语言文学</div>
                        <div class="major-desc">培养具有扎实汉语功底与文学修养的文化传播人才。</div>
                        <span class="major-tag">文学</span>
                    </div>
                </div>
            </div>
        </div>

        <script>
            /* ======== API集成 ======== */
            $(document).ready(function () {
                // 初始加载
                loadMajors();

                // 搜索按钮
                $('#searchBtn').on('click', function () {
                    const kw = $('#keyword').val().trim();
                    loadMajors({ keyword: kw });
                });

                // 快速分类
                $('.tag').on('click', function () {
                    const cate = $(this).data('cate');
                    $('.tag').css('background', 'rgba(255,255,255,0.8)');
                    $(this).css('background', '#2B6CB0').css('color', 'white');
                    loadMajors({ category: cate });
                });

                // 学科树
                $('.subject-tree li').on('click', function () {
                    const cate = $(this).text();
                    loadMajors({ category: cate });
                });

                // 加载专业列表
                function loadMajors(params) {
                    params = params || {};
                    let url = '/api/majors?limit=50';
                    if (params.keyword) url += '&keyword=' + encodeURIComponent(params.keyword);
                    if (params.category) url += '&category=' + encodeURIComponent(params.category);

                    $.ajax({
                        url: url,
                        type: 'GET',
                        dataType: 'json',
                        success: function (data) {
                            if (data.success) {
                                renderMajors(data.data);
                            }
                        },
                        error: function () {
                            console.error('Failed to load majors');
                        }
                    });
                }

                // 渲染专业列表
                function renderMajors(majors) {
                    const $list = $('#majorList');
                    $list.empty();

                    if (!majors || majors.length === 0) {
                        $list.html('<div style="text-align:center;padding:40px;color:#666;">暂无匹配的专业</div>');
                        return;
                    }

                    majors.forEach(function (major) {
                        const html = '<div class="major-card">' +
                            '<div class="major-title">' + major.name + '</div>' +
                            '<div class="major-desc">共有 ' + (major.admissionCount || 0) + ' 条录取数据</div>' +
                            '<span class="major-tag">' + (major.category || '其他') + '</span>' +
                            '</div>';
                        $list.append(html);
                    });
                }
            });
        </script>
    </body>

    </html>