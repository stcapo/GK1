package com.example.DAO;


import com.example.entity.User;
import java.sql.*;
import java.time.LocalDate;
import com.example.util.DBUtil;

public class UserDao {

    // 根据用户名获取用户
    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM user WHERE username = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setRealName(rs.getString("real_name"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
                user.setIdCard(rs.getString("id_card"));
                user.setGender(rs.getString("gender"));
                user.setBirthday(rs.getDate("birthday") != null ?
                        rs.getDate("birthday").toLocalDate() : null);
                user.setAddress(rs.getString("address"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 根据ID获取用户
    public User getUserById(int userId) {
        String sql = "SELECT * FROM user WHERE user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setRealName(rs.getString("real_name"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
                user.setIdCard(rs.getString("id_card"));
                user.setGender(rs.getString("gender"));
                user.setBirthday(rs.getDate("birthday") != null ?
                        rs.getDate("birthday").toLocalDate() : null);
                user.setAddress(rs.getString("address"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 更新用户信息
    public boolean updateUser(User user) {
        String sql = "UPDATE user SET real_name=?, phone=?, email=?, id_card=?, " +
                "gender=?, birthday=?, address=? WHERE user_id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, user.getRealName());
            pstmt.setString(2, user.getPhone());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getIdCard());
            pstmt.setString(5, user.getGender());
            pstmt.setDate(6, user.getBirthday() != null ?
                    Date.valueOf(user.getBirthday()) : null);
            pstmt.setString(7, user.getAddress());
            pstmt.setInt(8, user.getUserId());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 修改密码
    public boolean changePassword(int userId, String oldPassword, String newPassword) {
        // 先验证旧密码
        String checkSql = "SELECT password FROM user WHERE user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            checkStmt.setInt(1, userId);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next() && rs.getString("password").equals(oldPassword)) {
                // 旧密码正确，更新密码
                String updateSql = "UPDATE user SET password=? WHERE user_id=?";
                try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                    updateStmt.setString(1, newPassword);
                    updateStmt.setInt(2, userId);
                    return updateStmt.executeUpdate() > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}