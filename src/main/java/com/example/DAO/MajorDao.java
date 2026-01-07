package com.example.DAO;

import com.example.entity.Major;
import com.example.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * 专业数据访问对象
 */
public class MajorDao {

    /**
     * 按名称搜索专业
     */
    public List<Major> searchByName(String keyword) {
        List<Major> list = new ArrayList<>();
        String sql = "SELECT * FROM majors WHERE name LIKE ? LIMIT 50";
        
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
     * 按专业大类筛选
     */
    public List<Major> getByCategory(String category) {
        List<Major> list = new ArrayList<>();
        String sql = "SELECT * FROM majors WHERE category = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, category);
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
     * 获取所有专业大类
     */
    public List<String> getAllCategories() {
        List<String> list = new ArrayList<>();
        String sql = "SELECT DISTINCT category FROM majors WHERE category IS NOT NULL ORDER BY category";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                list.add(rs.getString("category"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * 根据ID获取专业
     */
    public Major getById(int id) {
        String sql = "SELECT * FROM majors WHERE id = ?";
        
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

    private Major mapRow(ResultSet rs) throws SQLException {
        Major m = new Major();
        m.setId(rs.getInt("id"));
        m.setName(rs.getString("name"));
        m.setCategory(rs.getString("category"));
        return m;
    }
}
