<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
  <html>

  <head>
    <title>智选志愿-同分去向</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link
      href="https://fonts.googleapis.com/css2?family=Ma+Shan+Zheng&family=ZCOOL+QingKe+HuangYou&family=ZCOOL+XiaoWei&display=swap"
      rel="stylesheet">
    <style>
      /* ========= 完全复用主页蓝天白云背景 ========= */
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

      /* ========= 同分去向主面板 ========= */
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

      /* 当前条件条 */
      .condition-bar {
        display: flex;
        align-items: center;
        gap: 15px;
        background: rgba(255, 255, 255, 0.9);
        backdrop-filter: blur(10px);
        padding: 15px 25px;
        border-radius: 30px;
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1), 0 0 0 1px rgba(255, 255, 255, 0.6);
        font-family: 'ZCOOL XiaoWei', serif;
        color: #2C5282;
      }

      .condition-bar .label {
        font-size: 1.1em;
      }

      .score-tabs {
        display: flex;
        gap: 10px;
      }

      .score-tab {
        background: rgba(255, 255, 255, 0.8);
        border: 1px solid rgba(255, 255, 255, 0.6);
        color: #2C5282;
        padding: 6px 16px;
        border-radius: 20px;
        cursor: pointer;
        transition: all 0.3s ease;
      }

      .score-tab.active {
        background: #2B6CB0;
        color: white;
      }

      /* 三栏榜单 */
      .rank-boards {
        display: flex;
        gap: 25px;
        flex: 1;
      }

      .rank-board {
        flex: 1;
        background: rgba(255, 255, 255, 0.85);
        backdrop-filter: blur(10px);
        border-radius: 20px;
        padding: 20px;
        display: flex;
        flex-direction: column;
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1), 0 0 0 1px rgba(255, 255, 255, 0.6);
      }

      .rank-board h3 {
        margin-bottom: 15px;
        font-family: 'ZCOOL QingKe HuangYou', sans-serif;
        font-size: 1.4em;
        color: #1E3A5F;
      }

      .rank-list {
        list-style: none;
        padding: 0;
        margin: 0;
        flex: 1;
        overflow-y: auto;
      }

      .rank-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 8px 0;
        border-bottom: 1px solid rgba(0, 0, 0, 0.05);
      }

      .rank-item:last-child {
        border-bottom: none;
      }

      .rank-name {
        font-family: 'ZCOOL XiaoWei', serif;
        font-size: 1em;
        color: #2C5282;
      }

      .rank-percent {
        font-size: 0.95em;
        color: #4A5568;
      }

      .expand-btn {
        align-self: flex-start;
        background: transparent;
        border: none;
        color: #2B6CB0;
        cursor: pointer;
        font-size: 0.9em;
        margin-top: 8px;
      }

      /* 响应式 */
      @media(max-width:992px) {
        .rank-boards {
          flex-direction: column;
        }
      }

      @media(max-width:576px) {
        .main-panel {
          margin-top: 80px;
        }

        .condition-bar {
          flex-direction: column;
          align-items: flex-start;
        }

        .score-tabs {
          flex-wrap: wrap;
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

    <!-- ======== 同分去向主面板 ======== -->
    <div class="main-panel">
      <!-- 当前条件条 -->
      <div class="condition-bar">
        <span class="label">湖南 · 物理/生物/地理 · 580 分</span>
        <div class="score-tabs">
          <span class="score-tab" data-score="575-579">575-579分</span>
          <span class="score-tab active" data-score="580-584">580-584分</span>
          <span class="score-tab" data-score="585-589">585-589分</span>
        </div>
      </div>

      <!-- 三栏榜单 -->
      <div class="rank-boards">
        <!-- 去向高校 TOP -->
        <div class="rank-board">
          <h3>去向人数最多的高校</h3>
          <ul class="rank-list" id="schoolList">
            <li class="rank-item">
              <span class="rank-name">长沙理工大学</span>
              <span class="rank-percent">25.4%</span>
            </li>
            <li class="rank-item">
              <span class="rank-name">湘潭大学</span>
              <span class="rank-percent">16.6%</span>
            </li>
            <li class="rank-item">
              <span class="rank-name">湖南师范大学</span>
              <span class="rank-percent">13.6%</span>
            </li>
          </ul>
          <button class="expand-btn" id="expandSchool">展开全部高校</button>
        </div>

        <!-- 去向专业 TOP -->
        <div class="rank-board">
          <h3>去向人数最多的专业</h3>
          <ul class="rank-list" id="majorList">
            <li class="rank-item">
              <span class="rank-name">电子信息类</span>
              <span class="rank-percent">9.9%</span>
            </li>
            <li class="rank-item">
              <span class="rank-name">自动化</span>
              <span class="rank-percent">7.3%</span>
            </li>
            <li class="rank-item">
              <span class="rank-name">机械设计制造及其自动化</span>
              <span class="rank-percent">6.8%</span>
            </li>
          </ul>
          <button class="expand-btn" id="expandMajor">展开全部专业</button>
        </div>

        <!-- 去向地区 TOP -->
        <div class="rank-board">
          <h3>去向人数最多的地区</h3>
          <ul class="rank-list" id="areaList">
            <li class="rank-item">
              <span class="rank-name">湖南</span>
              <span class="rank-percent">56.3%</span>
            </li>
            <li class="rank-item">
              <span class="rank-name">江苏</span>
              <span class="rank-percent">5.8%</span>
            </li>
            <li class="rank-item">
              <span class="rank-name">浙江</span>
              <span class="rank-percent">3.9%</span>
            </li>
          </ul>
          <button class="expand-btn" id="expandArea">展开全部地区</button>
        </div>
      </div>
    </div>

    <script>
      /* ======== API集成 ======== */
      $(document).ready(function () {
        // 加载用户信息并获取数据
        loadUserInfoAndData();

        // 分数段切换
        $('.score-tab').on('click', function () {
          $('.score-tab').removeClass('active');
          $(this).addClass('active');
          const score = $(this).data('score');
          // 解析分数范围
          const parts = score.split('-');
          if (parts.length === 2) {
            const minScore = parseInt(parts[0]);
            loadSameScoreData(minScore);
          }
        });

        // 展开全部
        $('#expandSchool, #expandMajor, #expandArea').on('click', function () {
          alert('更多数据需要完善后端接口');
        });

        function loadUserInfoAndData() {
          $.ajax({
            url: '/api/user/info',
            type: 'GET',
            dataType: 'json',
            success: function (data) {
              if (data.success && data.score) {
                const province = data.province || '上海';
                const subject = data.subject || '综合';
                const score = data.score;

                // 更新条件栏
                $('.condition-bar .label').text(province + ' · ' + subject + ' · ' + score + ' 分');

                // 更新分数段标签
                updateScoreTabs(score);

                // 加载数据
                loadSameScoreData(score);
              } else {
                $('.condition-bar .label').html('请先<a href="/main.jsp" style="color:#2B6CB0;">输入成绩</a>');
              }
            },
            error: function () {
              console.error('Failed to load user info');
            }
          });
        }

        function updateScoreTabs(score) {
          const $tabs = $('.score-tabs');
          $tabs.empty();

          for (let i = -10; i <= 10; i += 5) {
            const minS = score + i;
            const maxS = minS + 4;
            const isActive = (i === 0) ? 'active' : '';
            $tabs.append('<span class="score-tab ' + isActive + '" data-score="' + minS + '-' + maxS + '">' + minS + '-' + maxS + '分</span>');
          }

          // 重新绑定事件
          $('.score-tab').on('click', function () {
            $('.score-tab').removeClass('active');
            $(this).addClass('active');
            const score = $(this).data('score');
            const parts = score.split('-');
            if (parts.length === 2) {
              loadSameScoreData(parseInt(parts[0]));
            }
          });
        }

        function loadSameScoreData(score) {
          $.ajax({
            url: '/api/samescore?score=' + score + '&year=2024',
            type: 'GET',
            dataType: 'json',
            success: function (data) {
              if (data.success) {
                renderSameScoreData(data);
              }
            },
            error: function () {
              console.error('Failed to load same score data');
            }
          });
        }

        function renderSameScoreData(data) {
          // 统计高校 - 按大学名分组
          const schoolCounts = {};
          const majorCounts = {};
          const areaCounts = {};

          (data.destinations || []).forEach(function (d) {
            // 高校统计
            const uniName = d.universityName;
            if (!schoolCounts[uniName]) schoolCounts[uniName] = 0;
            schoolCounts[uniName]++;

            // 专业统计
            if (d.majorName) {
              if (!majorCounts[d.majorName]) majorCounts[d.majorName] = 0;
              majorCounts[d.majorName]++;
            }

            // 地区统计
            const area = d.province;
            if (!areaCounts[area]) areaCounts[area] = 0;
            areaCounts[area]++;
          });

          // 渲染高校列表
          const $schoolList = $('#schoolList');
          $schoolList.empty();
          const total = data.destinations ? data.destinations.length : 1;

          Object.keys(schoolCounts)
            .sort((a, b) => schoolCounts[b] - schoolCounts[a])
            .slice(0, 5)
            .forEach(function (name) {
              const percent = ((schoolCounts[name] / total) * 100).toFixed(1);
              $schoolList.append('<li class="rank-item"><span class="rank-name">' + name + '</span><span class="rank-percent">' + percent + '%</span></li>');
            });

          // 渲染专业列表
          const $majorList = $('#majorList');
          $majorList.empty();

          Object.keys(majorCounts)
            .sort((a, b) => majorCounts[b] - majorCounts[a])
            .slice(0, 5)
            .forEach(function (name) {
              const percent = ((majorCounts[name] / total) * 100).toFixed(1);
              $majorList.append('<li class="rank-item"><span class="rank-name">' + name + '</span><span class="rank-percent">' + percent + '%</span></li>');
            });

          // 渲染地区列表
          const $areaList = $('#areaList');
          $areaList.empty();

          Object.keys(areaCounts)
            .sort((a, b) => areaCounts[b] - areaCounts[a])
            .slice(0, 5)
            .forEach(function (name) {
              const percent = ((areaCounts[name] / total) * 100).toFixed(1);
              $areaList.append('<li class="rank-item"><span class="rank-name">' + name + '</span><span class="rank-percent">' + percent + '%</span></li>');
            });

          if (data.count === 0) {
            $schoolList.html('<li class="rank-item"><span class="rank-name">暂无数据</span></li>');
            $majorList.html('<li class="rank-item"><span class="rank-name">暂无数据</span></li>');
            $areaList.html('<li class="rank-item"><span class="rank-name">暂无数据</span></li>');
          }
        }
      });
    </script>
  </body>

  </html>