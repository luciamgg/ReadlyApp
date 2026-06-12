<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="readly.dao.UserBookDAO" %>
<%@ page import="readly.model.UserBook" %>
<%@ page import="readly.model.User" %>

<%
User user = (User) session.getAttribute("user");

if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}

UserBookDAO dao = new UserBookDAO();
List<UserBook> books = dao.getBooksByUser(user.getId());
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reseñas</title>

<style>
body {
    font-family: Arial;
    background: #faf7f2;
    margin: 0;
}

.container {
    padding: 30px;
}

/* NAVBAR */
.navbar {
    display: flex;
    justify-content: center;
    gap: 50px;
    padding: 18px;
    background: linear-gradient(90deg, #fbc2eb, #a6c1ee);
    border-radius: 0 0 20px 20px;
}

.navbar a {
    text-decoration: none;
    color: #333;
    font-weight: bold;
}

.navbar a:hover {
    color: white;
}

/* GRID REVIEWS */
.reviews {
    display: flex;
    flex-direction: column;
    gap: 15px;
}

/* CARD */
.review-card {
    background: white;
    padding: 18px;
    border-radius: 14px;
    box-shadow: 0 3px 10px rgba(0,0,0,0.05);
    transition: 0.2s;
}

.review-card:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 18px rgba(0,0,0,0.1);
}

/* TITULO */
.book-title {
    font-size: 18px;
    font-weight: bold;
    margin-bottom: 5px;
}

/* ESTRELLAS */
.rating {
    color: #f59e0b;
    font-size: 14px;
    margin-bottom: 10px;
}

/* TEXTO */
.review-text {
    line-height: 1.5;
    color: #333;
}

/* PORTADA */
.cover-container {
    width: 120px;
    height: 170px;
    border-radius: 10px;
    overflow: hidden;
    background: #eee;
    flex-shrink: 0;
}

.cover-container img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: block;
}
</style>

</head>

<body>

<jsp:include page="navbar.jsp" />

<div class="container">

<h2>📖 Mis reseñas</h2>

<div class="reviews">

<%
for (UserBook b : books) {

    if (b.getReview() != null && !b.getReview().isEmpty()) {
%>

<div class="review-card">

	<div class="cover-container">
    <img src="<%= (b.getCoverUrl() != null && !b.getCoverUrl().isEmpty())
        ? b.getCoverUrl()
        : "https://covers.openlibrary.org/b/title/" + (b.getTitle() + " " + b.getAuthor()).replace(" ", "+") + "-M.jpg" %>"
     onerror="this.src='https://via.placeholder.com/150x220?text=Sin+portada';">
</div>

    <div class="book-title"><%= b.getTitle() %></div>

    <% if (b.getRating() > 0) { %>
        <div class="rating">
            ⭐ <%= b.getRating() %> / 5
        </div>
    <% } %>

    <div class="review-text">
        <%= b.getReview() %>
    </div>

</div>

<%
    }
}
%>

</div>

</div>

</body>
</html>