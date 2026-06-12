package readly.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import readly.model.UserBook;
import readly.util.DBConnection;

public class UserBookDAO {

    // Añadir libro a usuario
    public boolean addUserBook(int userId, int bookId, String status) {

        String sql = "INSERT INTO user_books (user_id, book_id, status) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, bookId);
            ps.setString(3, status);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
    
    
   // Añadir libro
    public boolean addBook(String title, String author, int pages, String status, String coverUrl) {

        String sql = "INSERT INTO books (title, author, pages, status, cover_url) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, title);
            ps.setString(2, author);
            ps.setInt(3, pages);
            ps.setString(4, status);

            ps.setString(5, coverUrl);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // Actualizar lectura completa
    public boolean updateUserBook(int id, int rating, String review,
                                  Date startDate, Date finishDate, String status) {

        String sql = """
            UPDATE user_books 
            SET rating=?, review=?, start_date=?, finish_date=?, status=? 
            WHERE id=?
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, rating);
            ps.setString(2, review);
            ps.setDate(3, startDate);
            ps.setDate(4, finishDate);
            ps.setString(5, status);
            ps.setInt(6, id);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
    
    // Cambiar SOLO el estado
    public boolean updateStatus(int id, String status) {

        String sql = "UPDATE user_books SET status=? WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, id);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // Obtener libros del usuario (CON datos completos)
    public List<UserBook> getBooksByUser(int userId) {

        List<UserBook> list = new ArrayList<>();

        String sql = """
            SELECT 
                ub.id AS userBookId,
                ub.user_id,
                ub.book_id,
                ub.status,
                ub.rating,
                ub.review,
                ub.start_date,
                ub.finish_date,
                b.title,
                b.author,
                b.isbn,
                b.cover_url
            FROM user_books ub
            JOIN books b ON ub.book_id = b.id
            WHERE ub.user_id = ?
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                UserBook ub = new UserBook();

                ub.setId(rs.getInt("userBookId"));

                ub.setUserId(rs.getInt("user_id"));
                ub.setBookId(rs.getInt("book_id"));
                ub.setStatus(rs.getString("status"));

                ub.setTitle(rs.getString("title"));
                ub.setAuthor(rs.getString("author"));

                ub.setRating(rs.getInt("rating"));
                ub.setReview(rs.getString("review"));

                ub.setStartDate(rs.getDate("start_date"));
                ub.setFinishDate(rs.getDate("finish_date"));
                
                ub.setIsbn(rs.getString("isbn"));
                ub.setCoverUrl(rs.getString("cover_url"));

                list.add(ub);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // Añadir reseña
    public boolean updateReview(int id, int rating, String review) {

        String sql = "UPDATE user_books SET rating=?, review=? WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, rating);
            ps.setString(2, review);
            ps.setInt(3, id);

            int rows = ps.executeUpdate();
            System.out.println("Filas afectadas: " + rows);

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // Libro por id
    public UserBook getBookById(int id) {

        String sql = """
            SELECT 
                ub.id AS userBookId,
                ub.user_id,
                ub.book_id,
                ub.status,
                ub.rating,
                ub.review,
                ub.start_date,
                ub.finish_date,
                b.title,
                b.author,
                b.isbn,
                b.cover_url
            FROM user_books ub
            JOIN books b ON ub.book_id = b.id
            WHERE ub.id = ?
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                UserBook ub = new UserBook();

                ub.setId(rs.getInt("userBookId"));
                ub.setUserId(rs.getInt("user_id"));
                ub.setBookId(rs.getInt("book_id"));
                ub.setStatus(rs.getString("status"));

                ub.setTitle(rs.getString("title"));
                ub.setAuthor(rs.getString("author"));

                ub.setRating(rs.getInt("rating"));
                ub.setReview(rs.getString("review"));

                ub.setStartDate(rs.getDate("start_date"));
                ub.setFinishDate(rs.getDate("finish_date"));
                
                ub.setIsbn(rs.getString("isbn"));
                ub.setCoverUrl(rs.getString("cover_url"));

                return ub;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
    
    // Borrar relación
    public boolean delete(int id) {

        String sql = "DELETE FROM user_books WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}