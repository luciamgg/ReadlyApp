package readly.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import readly.model.Book;
import readly.util.DBConnection;

public class BookDAO {

	// Añadir libros
	public int addBook(String title, String author, int pages) {

        String sql = "INSERT INTO books (title, author, pages) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, title);
            ps.setString(2, author);
            ps.setInt(3, pages);

            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();

            if (rs.next()) {
                return rs.getInt(1); // devuelve ID del libro creado
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1;
    }
	
	// Mostrar todos los libros
    public List<Book> getAllBooks() {

        List<Book> list = new ArrayList<>();

        String sql = "SELECT * FROM books";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Book b = new Book();
                b.setId(rs.getInt("id"));
                b.setTitle(rs.getString("title"));
                b.setAuthor(rs.getString("author"));
                b.setPages(rs.getInt("pages"));

                list.add(b);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    // Mostrar libros por ID
    public Book getById(int id) {

        Book b = null;

        String sql = "SELECT * FROM books WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                b = new Book();
                b.setId(rs.getInt("id"));
                b.setTitle(rs.getString("title"));
                b.setAuthor(rs.getString("author"));
                b.setPages(rs.getInt("pages"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return b;
    }
}
