package com.example.DAO;

import com.example.entity.University;
import com.example.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * 大学数据访问对象
 */
public class UniversityDao {

    /**
     * 按名称搜索大学
     */
    public List<University> searchByName(String keyword) {
        List<University> list = new ArrayList<>();
        String sql = "SELECT * FROM universities WHERE name LIKE ? LIMIT 50";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, "%" + keyword + "%");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * 按省份筛选大学
     */
    public List<University> getByProvince(String province) {
        List<University> list = new ArrayList<>();
        String sql = "SELECT * FROM universities WHERE province = ? LIMIT 100";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, province);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * 获取所有省份列表
     */
    public List<String> getAllProvinces() {
        List<String> list = new ArrayList<>();
        String sql = "SELECT DISTINCT province FROM universities WHERE province IS NOT NULL ORDER BY province";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                list.add(rs.getString("province"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * 根据ID获取大学
     */
    public University getById(int id) {
        String sql = "SELECT * FROM universities WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 获取大学录取数据（带概率计算）
     */
    public List<Object[]> getUniversityWithProbability(int userRank) {
        List<Object[]> list = new ArrayList<>();
        String sql = "SELECT u.id, u.name, u.province, u.type, " +
            "MIN(ad.min_score) as min_score, MIN(ad.min_rank) as min_rank, " +
            "CASE " +
            "  WHEN ? < MIN(ad.min_rank) * 0.9 THEN '冲' " +
            "  WHEN ? BETWEEN MIN(ad.min_rank) * 0.9 AND MIN(ad.min_rank) * 1.2 THEN '稳' " +
            "  ELSE '保' " +
            "END as level " +
            "FROM universities u " +
            "LEFT JOIN admission_data ad ON u.id = ad.university_id " +
            "GROUP BY u.id, u.name, u.province, u.type " +
            "HAVING min_rank IS NOT NULL " +
            "ORDER BY min_score DESC LIMIT 100";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userRank);
            pstmt.setInt(2, userRank);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(new Object[] {
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("province"),
                    rs.getString("type"),
                    rs.getInt("min_score"),
                    rs.getInt("min_rank"),
                    rs.getString("level")
                });
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private University mapRow(ResultSet rs) throws SQLException {
        University u = new University();
        u.setId(rs.getInt("id"));
        u.setName(rs.getString("name"));
        u.setProvince(rs.getString("province"));
        u.setCity(rs.getString("city"));
        u.setType(rs.getString("type"));
        u.setIs985(rs.getBoolean("is_985"));
        u.setIs211(rs.getBoolean("is_211"));
        u.setDoubleFirst(rs.getBoolean("is_double_first"));
        u.setTags(rs.getString("tags"));
        return u;
    }
}
