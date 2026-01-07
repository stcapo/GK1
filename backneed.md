# Backend Requirements Specification

## Overview

This document outlines all APIs and MySQL table structures required to fully implement the Gaokao Intelligent Recommendation System frontend features.

---

## MySQL Database Schema

### 1. User Management

```sql
-- Users table
CREATE TABLE `user` (
    `user_id` INT AUTO_INCREMENT PRIMARY KEY,
    `username` VARCHAR(50) NOT NULL UNIQUE,
    `password` VARCHAR(255) NOT NULL,
    `email` VARCHAR(100),
    `phone` VARCHAR(20),
    `score` INT,
    `province` VARCHAR(20),
    `subject` VARCHAR(50),
    `preference` VARCHAR(50),
    `rank` INT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

### 2. University Data

```sql
-- Universities table
CREATE TABLE `universities` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL,
    `code` VARCHAR(20),
    `province` VARCHAR(20) NOT NULL,
    `city` VARCHAR(50),
    `type` VARCHAR(50),                    -- 综合类, 理工类, 师范类, 医药类, etc.
    `level` VARCHAR(20),                   -- 本科, 专科
    `is_985` TINYINT(1) DEFAULT 0,
    `is_211` TINYINT(1) DEFAULT 0,
    `is_double_first` TINYINT(1) DEFAULT 0,
    `is_public` TINYINT(1) DEFAULT 1,
    `website` VARCHAR(200),
    `description` TEXT,
    `logo_url` VARCHAR(200),
    `min_score_2024` INT,
    `min_rank_2024` INT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX `idx_province` (`province`),
    INDEX `idx_score` (`min_score_2024`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

### 3. Major Data

```sql
-- Majors table
CREATE TABLE `majors` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL,
    `code` VARCHAR(20),
    `category` VARCHAR(50),                -- 工学, 理学, 医学, 文学, etc.
    `subcategory` VARCHAR(50),
    `degree_type` VARCHAR(20),             -- 学士, 硕士
    `duration` INT DEFAULT 4,              -- 学制年限
    `description` TEXT,
    `employment_rate` DECIMAL(5,2),
    `avg_salary` INT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX `idx_category` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- University-Major relationship
CREATE TABLE `university_majors` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `university_id` INT NOT NULL,
    `major_id` INT NOT NULL,
    `enrollment_count` INT,                -- Annual enrollment
    `tuition` INT,
    FOREIGN KEY (`university_id`) REFERENCES `universities`(`id`),
    FOREIGN KEY (`major_id`) REFERENCES `majors`(`id`),
    UNIQUE KEY `uk_uni_major` (`university_id`, `major_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

### 4. Admission Data

```sql
-- Historical admission data
CREATE TABLE `admission_data` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `university_id` INT NOT NULL,
    `major_id` INT,
    `year` INT NOT NULL,
    `province` VARCHAR(20) NOT NULL,       -- Source province of students
    `subject_type` VARCHAR(20),            -- 物理类, 历史类, 综合
    `batch` VARCHAR(30),                   -- 本科批, 本科一批, etc.
    `min_score` INT,
    `max_score` INT,
    `avg_score` INT,
    `min_rank` INT,
    `enrollment_count` INT,
    `plan_count` INT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`university_id`) REFERENCES `universities`(`id`),
    FOREIGN KEY (`major_id`) REFERENCES `majors`(`id`),
    INDEX `idx_year_province` (`year`, `province`),
    INDEX `idx_score` (`min_score`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

### 5. Score Rank Data (一分一段表)

```sql
-- Score rank table
CREATE TABLE `score_rank` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `year` INT NOT NULL,
    `province` VARCHAR(20) NOT NULL,
    `subject_type` VARCHAR(20) NOT NULL,   -- 物理, 历史, 综合
    `score` INT NOT NULL,
    `same_score_count` INT,                -- Number of students with exact same score
    `cumulative_count` INT,                -- Total students at or above this score
    `rank` INT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY `uk_score` (`year`, `province`, `subject_type`, `score`),
    INDEX `idx_lookup` (`year`, `province`, `subject_type`, `score`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

### 6. Wishlist (志愿表)

```sql
-- User wishlist
CREATE TABLE `wishlist` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT NOT NULL,
    `name` VARCHAR(100) DEFAULT '我的志愿表',
    `year` INT,
    `status` VARCHAR(20) DEFAULT 'draft',  -- draft, submitted
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`) ON DELETE CASCADE,
    INDEX `idx_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Wishlist items
CREATE TABLE `wishlist_items` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `wishlist_id` INT NOT NULL,
    `university_id` INT NOT NULL,
    `major_id` INT,
    `order_num` INT NOT NULL,              -- 志愿顺序
    `strategy` VARCHAR(20),                -- impact(冲), safe(稳), backup(保)
    `notes` TEXT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`wishlist_id`) REFERENCES `wishlist`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`university_id`) REFERENCES `universities`(`id`),
    INDEX `idx_wishlist` (`wishlist_id`),
    UNIQUE KEY `uk_wishlist_order` (`wishlist_id`, `order_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

### 7. Reference Data

```sql
-- Provinces
CREATE TABLE `provinces` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(20) NOT NULL UNIQUE,
    `code` VARCHAR(10),
    `region` VARCHAR(20)                   -- 华东, 华北, 华南, etc.
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Subject combinations
CREATE TABLE `subject_combinations` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `province` VARCHAR(20) NOT NULL,
    `name` VARCHAR(50) NOT NULL,           -- 物化生, 物化地, etc.
    `subjects` VARCHAR(100)                -- 物理,化学,生物
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Batch lines (批次线)
CREATE TABLE `batch_lines` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `year` INT NOT NULL,
    `province` VARCHAR(20) NOT NULL,
    `subject_type` VARCHAR(20),
    `batch` VARCHAR(30) NOT NULL,
    `score` INT NOT NULL,
    UNIQUE KEY `uk_batch` (`year`, `province`, `subject_type`, `batch`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

---

## API Specifications

### 1. Authentication APIs

#### POST `/login`
User login.
```json
// Request
{ "username": "test", "password": "123456" }

// Response
{ 
    "success": true, 
    "userId": 1, 
    "username": "test",
    "score": 560,
    "province": "上海",
    "subject": "物化生"
}
```

#### POST `/register`
User registration.
```json
// Request
{ "username": "newuser", "password": "123456", "email": "a@b.com" }

// Response
{ "success": true, "message": "注册成功" }
```

#### GET `/api/user/info`
Get current user info from session.
```json
// Response
{
    "success": true,
    "userId": 1,
    "username": "test",
    "score": 560,
    "province": "上海",
    "subject": "物化生",
    "preference": "工科"
}
```

#### POST `/api/user/score`
Save user score info.
```json
// Request
{ "score": 560, "province": "上海", "subject": "物化生", "preference": "工科" }

// Response
{ "success": true, "message": "保存成功" }
```

---

### 2. University APIs

#### GET `/api/universities`
Search universities.
| Param | Type | Description |
|-------|------|-------------|
| keyword | string | Search keyword |
| province | string | Filter by province |
| type | string | University type |
| is985 | int | 1=only 985 |
| is211 | int | 1=only 211 |
| limit | int | Max results (default 50) |

```json
// Response
{
    "success": true,
    "count": 50,
    "data": [{
        "id": 1,
        "name": "上海交通大学",
        "province": "上海",
        "city": "上海",
        "type": "综合类",
        "is985": true,
        "is211": true,
        "isDoubleFirst": true,
        "minScore2024": 575,
        "minRank2024": 1100
    }]
}
```

#### GET `/api/universities/{id}`
Get university details.
```json
// Response
{
    "success": true,
    "data": {
        "id": 1,
        "name": "上海交通大学",
        "province": "上海",
        "city": "上海",
        "type": "综合类",
        "description": "...",
        "website": "https://www.sjtu.edu.cn",
        "is985": true,
        "is211": true,
        "isDoubleFirst": true,
        "majors": [...],
        "admissionHistory": [
            { "year": 2024, "minScore": 575, "minRank": 1100 },
            { "year": 2023, "minScore": 570, "minRank": 1200 }
        ]
    }
}
```

#### GET `/api/universities/provinces`
Get all provinces.
```json
// Response
{ "success": true, "data": ["上海", "北京", "江苏", ...] }
```

#### GET `/api/universities/recommend`
Get recommendations by score.
| Param | Type | Description |
|-------|------|-------------|
| score | int | User score |
| province | string | User province |
| subject | string | User subject combination |

```json
// Response
{
    "success": true,
    "impact": [...],    // 冲 (score + 10~30)
    "safe": [...],      // 稳 (score - 5~+5)
    "backup": [...]     // 保 (score - 10~30)
}
```

---

### 3. Major APIs

#### GET `/api/majors`
Search majors.
| Param | Type | Description |
|-------|------|-------------|
| keyword | string | Search keyword |
| category | string | Major category |
| limit | int | Max results |

```json
// Response
{
    "success": true,
    "count": 20,
    "data": [{
        "id": 1,
        "name": "计算机科学与技术",
        "category": "工学",
        "admissionCount": 3
    }]
}
```

#### GET `/api/majors/{id}`
Get major details.
```json
// Response
{
    "success": true,
    "data": {
        "id": 1,
        "name": "计算机科学与技术",
        "category": "工学",
        "description": "...",
        "duration": 4,
        "employmentRate": 95.5,
        "avgSalary": 15000,
        "universities": [...]
    }
}
```

#### GET `/api/majors/categories`
Get all major categories.
```json
// Response
{ "success": true, "data": ["工学", "理学", "医学", "文学", ...] }
```

---

### 4. Same Score APIs

#### GET `/api/samescore`
Query same-score destinations.
| Param | Type | Description |
|-------|------|-------------|
| score | int | Score to query |
| year | int | Year (default current-1) |
| province | string | Province |

```json
// Response
{
    "success": true,
    "count": 50,
    "destinations": [{
        "universityName": "复旦大学",
        "majorName": "计算机科学与技术",
        "province": "上海",
        "minScore": 558,
        "maxScore": 562
    }]
}
```

---

### 5. Score Rank APIs

#### GET `/api/scorerank`
Query score rank (一分一段).
| Param | Type | Description |
|-------|------|-------------|
| score | int | Score to query |
| year | int | Year |
| province | string | Province |
| subject | string | Subject type |

```json
// Response
{
    "success": true,
    "found": true,
    "score": 560,
    "rank": 5000,
    "sameScoreCount": 85,
    "cumulativeCount": 5085
}
```

#### GET `/api/scorerank/range`
Query score range.
| Param | Type | Description |
|-------|------|-------------|
| minScore | int | Min score |
| maxScore | int | Max score |
| year | int | Year |
| province | string | Province |

```json
// Response
{
    "success": true,
    "data": [
        { "score": 560, "count": 85, "cumulativeCount": 5085, "rank": 5000 },
        { "score": 559, "count": 90, "cumulativeCount": 5175, "rank": 5085 }
    ]
}
```

---

### 6. Smart Recommendation APIs

#### POST `/api/recommend`
Get smart university recommendations.
```json
// Request
{
    "score": 560,
    "rank": 5000,
    "batch": "本科批",
    "subjects": ["物理", "化学", "生物"],
    "province": "上海",
    "type": "",
    "mode": "university"    // university or major
}

// Response
{
    "success": true,
    "impactCount": 35,
    "safeCount": 28,
    "backupCount": 150,
    "data": [{
        "id": 1,
        "name": "复旦大学",
        "code": "10246",
        "strategy": "impact",
        "region": "上海",
        "tags": [
            { "label": "985", "class": "double-first" },
            { "label": "211", "class": "project-211" }
        ],
        "minScore": 575,
        "plan": 80,
        "availableGroups": 5
    }]
}
```

#### GET `/api/analysis/strategy`
Get strategy counts (冲稳保统计).
| Param | Type | Description |
|-------|------|-------------|
| score | int | User score |
| rank | int | User rank |
| province | string | Province |

```json
// Response
{
    "success": true,
    "impactCount": 35,
    "safeCount": 28,
    "backupCount": 150
}
```

---

### 7. Wishlist APIs

#### GET `/api/wishlist`
Get user's wishlists.
```json
// Response
{
    "success": true,
    "data": [{
        "id": 1,
        "name": "2025志愿表",
        "year": 2025,
        "itemCount": 5,
        "createdAt": "2025-01-01 10:00:00",
        "updatedAt": "2025-01-02 15:30:00"
    }]
}
```

#### POST `/api/wishlist`
Create new wishlist.
```json
// Request
{ "name": "我的志愿表", "year": 2025 }

// Response
{ "success": true, "id": 1, "message": "创建成功" }
```

#### GET `/api/wishlist/{id}`
Get wishlist details with items.
```json
// Response
{
    "success": true,
    "data": {
        "id": 1,
        "name": "2025志愿表",
        "year": 2025,
        "items": [{
            "order": 1,
            "universityId": 1,
            "universityName": "复旦大学",
            "majorId": 1,
            "majorName": "计算机科学与技术",
            "strategy": "impact"
        }]
    }
}
```

#### PUT `/api/wishlist/{id}`
Update wishlist.
```json
// Request
{ "name": "新名称" }

// Response
{ "success": true, "message": "更新成功" }
```

#### DELETE `/api/wishlist/{id}`
Delete wishlist.
```json
// Response
{ "success": true, "message": "删除成功" }
```

#### POST `/api/wishlist/{id}/items`
Add item to wishlist.
```json
// Request
{ "universityId": 1, "majorId": 1, "order": 1, "strategy": "impact" }

// Response
{ "success": true, "itemId": 1, "message": "添加成功" }
```

#### DELETE `/api/wishlist/{id}/items/{itemId}`
Remove item from wishlist.
```json
// Response
{ "success": true, "message": "删除成功" }
```

#### PUT `/api/wishlist/{id}/items/reorder`
Reorder wishlist items.
```json
// Request
{ "items": [{ "id": 1, "order": 2 }, { "id": 2, "order": 1 }] }

// Response
{ "success": true, "message": "排序更新成功" }
```

#### GET `/api/wishlist/{id}/export`
Export wishlist as PDF/Excel.
| Param | Type | Description |
|-------|------|-------------|
| format | string | pdf or excel |

Returns: File download

---

### 8. Reference Data APIs

#### GET `/api/provinces`
Get all provinces.
```json
// Response
{
    "success": true,
    "data": [
        { "name": "上海", "code": "31", "region": "华东" },
        { "name": "北京", "code": "11", "region": "华北" }
    ]
}
```

#### GET `/api/subjects`
Get subject combinations by province.
| Param | Type | Description |
|-------|------|-------------|
| province | string | Province name |

```json
// Response
{
    "success": true,
    "data": ["物化生", "物化地", "物生地", "史政地", ...]
}
```

#### GET `/api/batches`
Get admission batches.
| Param | Type | Description |
|-------|------|-------------|
| province | string | Province |
| year | int | Year |

```json
// Response
{
    "success": true,
    "data": ["本科批", "本科一批", "本科二批", "专科批"]
}
```

#### GET `/api/university-types`
Get university types.
```json
// Response
{
    "success": true,
    "data": ["综合类", "理工类", "师范类", "医药类", "财经类", "政法类", "艺术类"]
}
```

---

## Implementation Priority

### Phase 1 (Core - ✅ Done)
- [x] User login/register
- [x] `/api/user/info`, `/api/user/score`
- [x] `/api/universities` (basic search)
- [x] `/api/majors` (basic search)
- [x] `/api/samescore`
- [x] `/api/scorerank`

### Phase 2 (Critical)
- [ ] `/api/recommend` - Smart recommendations
- [ ] `/api/analysis/strategy` - Strategy counts
- [ ] `/api/universities/{id}` - University details
- [ ] `/api/majors/{id}` - Major details

### Phase 3 (Important)
- [ ] `/api/wishlist/*` - Full wishlist CRUD
- [ ] `/api/universities/recommend`
- [ ] `/api/scorerank/range`

### Phase 4 (Enhancement)
- [ ] `/api/wishlist/{id}/export`
- [ ] Reference data APIs
- [ ] Historical trends analysis
