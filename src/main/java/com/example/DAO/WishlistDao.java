package com.example.DAO;

import com.example.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * 用户志愿单数据访问对象
 */
public class WishlistDao {

    /**
     * 添加到志愿单
     */
    public boolean addToWishlist(int userId, int universityId, Integer majorId) {
        String sql = "INSERT INTO user_wishlist (user_id, university_id, major_id, priority) " +
            "VALUES (?, ?, ?, (SELECT COALESCE(MAX(priority), 0) + 1 FROM user_wishlist w WHERE w.user_id = ?)) " +
            "ON DUPLICATE KEY UPDATE priority = priority";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            pstmt.setInt(2, universityId);
            if (majorId != null) {
                pstmt.setInt(3, majorId);
            } else {
                pstmt.setNull(3, Types.INTEGER);
            }
            pstmt.setInt(4, userId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * 从志愿单移除
     */
    public boolean removeFromWishlist(int userId, int wishlistId) {
        String sql = "DELETE FROM user_wishlist WHERE id = ? AND user_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, wishlistId);
            pstmt.setInt(2, userId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * 更新排序优先级
     */
    public boolean updatePriority(int userId, int wishlistId, int newPriority) {
        String sql = "UPDATE user_wishlist SET priority = ? WHERE id = ? AND user_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, newPriority);
            pstmt.setInt(2, wishlistId);
            pstmt.setInt(3, userId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * 获取用户志愿单
     */
    public List<Object[]> getUserWishlist(int userId) {
        List<Object[]> list = new ArrayList<>();
        String sql = "SELECT w.id, w.priority, u.name as univ_name, u.province, " +
            "m.name as major_name, w.admission_probability, w.created_at " +
            "FROM user_wishlist w " +
            "JOIN universities u ON w.university_id = u.id " +
            "LEFT JOIN majors m ON w.major_id = m.id " +
            "WHERE w.user_id = ? " +
            "ORDER BY w.priority";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(new Object[] {
                    rs.getInt("id"),
                    rs.getInt("priority"),
                    rs.getString("univ_name"),
                    rs.getString("province"),
                    rs.getString("major_name"),
                    rs.getDouble("admission_probability"),
                    rs.getTimestamp("created_at")
                });
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
