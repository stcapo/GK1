-- 高考志愿智能填报推荐系统数据库初始化脚本
-- 字符集设置
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- 创建数据库（如果不存在）
CREATE DATABASE IF NOT EXISTS gaokao_system 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE gaokao_system;

-- 用户表
CREATE TABLE IF NOT EXISTS user (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    real_name VARCHAR(50),
    phone VARCHAR(20),
    email VARCHAR(100),
    id_card VARCHAR(20),
    gender VARCHAR(10),
    birthday DATE,
    address VARCHAR(200),
    score INT DEFAULT 0,  -- 用户高考分数
    province VARCHAR(50), -- 用户所在省份
    ranking INT DEFAULT 0, -- 用户位次
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 大学表
CREATE TABLE IF NOT EXISTS universities (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    province VARCHAR(50) NOT NULL,  -- 省份
    city VARCHAR(50),               -- 城市
    type VARCHAR(50),               -- 类型：985/211/双一流/普通本科
    is_985 TINYINT DEFAULT 0,
    is_211 TINYINT DEFAULT 0,
    is_double_first TINYINT DEFAULT 0,  -- 双一流
    tags VARCHAR(200),              -- 其他标签
    INDEX idx_province (province),
    INDEX idx_name (name)
);

-- 专业表
CREATE TABLE IF NOT EXISTS majors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50),           -- 专业大类：工学/理学/医学等
    INDEX idx_name (name),
    INDEX idx_category (category)
);

-- 录取数据表（核心数据）
CREATE TABLE IF NOT EXISTS admission_data (
    id INT PRIMARY KEY AUTO_INCREMENT,
    university_id INT NOT NULL,
    major_id INT,
    year INT NOT NULL,              -- 录取年份
    batch VARCHAR(50),              -- 批次：本科一批/本科二批/专科
    min_score INT,                  -- 最低分
    max_score INT,                  -- 最高分
    avg_score INT,                  -- 平均分
    min_rank INT,                   -- 最低位次
    enrollment_count INT,           -- 招生人数
    source_province VARCHAR(50),    -- 数据来源省份（上海/重庆）
    FOREIGN KEY (university_id) REFERENCES universities(id),
    FOREIGN KEY (major_id) REFERENCES majors(id),
    INDEX idx_university (university_id),
    INDEX idx_year (year),
    INDEX idx_score (min_score)
);

-- 一分一段表
CREATE TABLE IF NOT EXISTS score_rank (
    id INT PRIMARY KEY AUTO_INCREMENT,
    year INT NOT NULL,
    score INT NOT NULL,
    rank_position INT NOT NULL,     -- 该分数对应的位次
    cumulative_count INT,           -- 累计人数
    province VARCHAR(50) NOT NULL,  -- 省份
    subject_type VARCHAR(20),       -- 文理科/选考科目组合
    INDEX idx_score_year (year, score),
    INDEX idx_province (province)
);

-- 用户志愿单表
CREATE TABLE IF NOT EXISTS user_wishlist (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    university_id INT NOT NULL,
    major_id INT,
    priority INT DEFAULT 0,         -- 排序优先级，数字越小越靠前
    admission_probability DECIMAL(5,2), -- 录取概率
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (university_id) REFERENCES universities(id),
    FOREIGN KEY (major_id) REFERENCES majors(id),
    UNIQUE KEY uk_user_univ_major (user_id, university_id, major_id)
);

-- 插入测试数据：一些示例大学
INSERT INTO universities (name, province, city, type, is_985, is_211, is_double_first) VALUES
('上海交通大学', '上海', '上海', '985', 1, 1, 1),
('复旦大学', '上海', '上海', '985', 1, 1, 1),
('同济大学', '上海', '上海', '985', 1, 1, 1),
('华东师范大学', '上海', '上海', '985', 1, 1, 1),
('上海财经大学', '上海', '上海', '211', 0, 1, 1),
('上海大学', '上海', '上海', '211', 0, 1, 1),
('华东理工大学', '上海', '上海', '211', 0, 1, 1),
('东华大学', '上海', '上海', '211', 0, 1, 0),
('上海外国语大学', '上海', '上海', '211', 0, 1, 1),
('重庆大学', '重庆', '重庆', '985', 1, 1, 1),
('西南大学', '重庆', '重庆', '211', 0, 1, 1),
('西南政法大学', '重庆', '重庆', '普通本科', 0, 0, 0),
('重庆医科大学', '重庆', '重庆', '普通本科', 0, 0, 0),
('重庆邮电大学', '重庆', '重庆', '普通本科', 0, 0, 0),
('四川外国语大学', '重庆', '重庆', '普通本科', 0, 0, 0);

-- 插入测试数据：一些示例专业
INSERT INTO majors (name, category) VALUES
('计算机科学与技术', '工学'),
('软件工程', '工学'),
('人工智能', '工学'),
('数据科学与大数据技术', '工学'),
('电子信息工程', '工学'),
('通信工程', '工学'),
('临床医学', '医学'),
('口腔医学', '医学'),
('金融学', '经济学'),
('会计学', '管理学'),
('工商管理', '管理学'),
('法学', '法学'),
('汉语言文学', '文学'),
('英语', '文学'),
('新闻学', '文学'),
('机械工程', '工学'),
('土木工程', '工学'),
('建筑学', '工学'),
('电气工程及其自动化', '工学'),
('自动化', '工学');

-- 插入测试录取数据（2024年上海数据示例）
INSERT INTO admission_data (university_id, major_id, year, batch, min_score, avg_score, min_rank, enrollment_count, source_province) VALUES
(1, 1, 2024, '本科普通批', 580, 595, 1200, 50, '上海'),
(1, 2, 2024, '本科普通批', 575, 590, 1500, 40, '上海'),
(1, 3, 2024, '本科普通批', 582, 598, 1100, 30, '上海'),
(2, 1, 2024, '本科普通批', 578, 592, 1300, 45, '上海'),
(2, 9, 2024, '本科普通批', 570, 585, 1800, 35, '上海'),
(3, 16, 2024, '本科普通批', 565, 578, 2200, 60, '上海'),
(3, 17, 2024, '本科普通批', 560, 575, 2500, 55, '上海'),
(4, 13, 2024, '本科普通批', 555, 568, 2800, 40, '上海'),
(5, 9, 2024, '本科普通批', 550, 565, 3200, 70, '上海'),
(5, 10, 2024, '本科普通批', 548, 562, 3400, 65, '上海'),
(10, 1, 2024, '本科普通批', 545, 560, 3800, 80, '重庆'),
(10, 16, 2024, '本科普通批', 540, 555, 4200, 75, '重庆'),
(11, 12, 2024, '本科普通批', 530, 545, 5000, 60, '重庆'),
(11, 13, 2024, '本科普通批', 525, 540, 5500, 50, '重庆');

-- 插入测试一分一段数据（2024年上海示例）
INSERT INTO score_rank (year, score, rank_position, cumulative_count, province, subject_type) VALUES
(2024, 600, 500, 500, '上海', '综合'),
(2024, 595, 700, 700, '上海', '综合'),
(2024, 590, 950, 950, '上海', '综合'),
(2024, 585, 1200, 1200, '上海', '综合'),
(2024, 580, 1500, 1500, '上海', '综合'),
(2024, 575, 1850, 1850, '上海', '综合'),
(2024, 570, 2200, 2200, '上海', '综合'),
(2024, 565, 2600, 2600, '上海', '综合'),
(2024, 560, 3000, 3000, '上海', '综合'),
(2024, 555, 3450, 3450, '上海', '综合'),
(2024, 550, 3900, 3900, '上海', '综合'),
(2024, 545, 4400, 4400, '上海', '综合'),
(2024, 540, 4950, 4950, '上海', '综合'),
(2024, 535, 5500, 5500, '上海', '综合'),
(2024, 530, 6100, 6100, '上海', '综合'),
(2024, 525, 6750, 6750, '上海', '综合'),
(2024, 520, 7400, 7400, '上海', '综合');

-- 创建默认测试用户
INSERT INTO user (username, password, real_name, score, province, ranking) VALUES
('test', '123456', '测试用户', 560, '上海', 3000);

SELECT 'Database initialization completed successfully!' AS status;
