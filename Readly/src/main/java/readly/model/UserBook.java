package readly.model;

import java.sql.Date;

public class UserBook {

    private int id;
    private int userId;
    private int bookId;
    private String title;
    private String author;
    private String status;
    private int rating;
    private String review;
    private Date startDate;
    private Date finishDate;
    private String isbn;
    private String coverUrl;

    public UserBook() {}
    
    // Getters y setters

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }
    
    public String getTitle() { return title; }

    public void setTitle(String title) { this.title = title; }

    public String getAuthor() { return author; }

    public void setAuthor(String author) { this.author = author; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }

    public String getReview() { return review; }
    public void setReview(String review) { this.review = review; }

    public Date getStartDate() { return startDate; }
    public void setStartDate(Date startDate) { this.startDate = startDate; }

    public Date getFinishDate() { return finishDate; }
    public void setFinishDate(Date finishDate) { this.finishDate = finishDate; }
    
    public String getIsbn() { return isbn; }
    public void setIsbn(String isbn) { this.isbn = isbn; }
    
    public String getCoverUrl() { return coverUrl; }
    public void setCoverUrl(String coverUrl) { this.coverUrl = coverUrl; }
}
