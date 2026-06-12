package readly.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import readly.model.User;
import readly.util.DBConnection;

public class UserDAO {

    // LOGIN
    public User login(String email, String password) {

        User user = null;

        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                user = new User();

                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    // BUSCAR POR ID
    public User getById(int id) {

        User user = null;

        String sql = "SELECT * FROM users WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();

                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                
                System.out.println("USER FINAL: " + user);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }
}
