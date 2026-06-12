<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
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
<title>Home</title>

<style>
body {
    font-family: Arial;
    margin: 0;
    background: #faf7f2;
}

.container {
    padding: 30px;
}

.columns {
    display: flex;
    gap: 30px;
    align-items: flex-start;
}

.column {
    flex: 1;
}

.card {
    background: white;
    padding: 15px;
    border-radius: 12px;
    margin-bottom: 15px;
    box-shadow: 0 3px 8px rgba(0,0,0,0.05);
}

.title {
    font-weight: bold;
    margin-bottom: 5px;
}

.book-link {
    text-decoration: none;
    color: inherit;
}

.book-link:hover .title {
    color: #8b5cf6;
}

button {
    padding: 6px 10px;
    border: none;
    border-radius: 6px;
    background: #8b5cf6;
    color: white;
    cursor: pointer;
}

button:hover {
    background: #7c3aed;
}

/* NAVBAR */
.navbar {
    display: flex;
    justify-content: center;
    gap: 50px;
    padding: 18px;
    background: linear-gradient(90deg, #fbc2eb, #a6c1ee);
}

.navbar a {
    text-decoration: none;
    font-weight: bold;
    color: #333;
}

/* AÑADIR LIBRO */
.add-book-card {
    padding: 15px;
}

.add-form {
    display: flex;
    align-items: center;
    gap: 10px;
    flex-wrap: nowrap; 
}

.add-form input,
.add-form select {
    flex: 1;
    padding: 10px;
    border-radius: 8px;
    border: 1px solid #ddd;
    min-width: 0; 
}

.add-btn {
    width: 42px;
    height: 42px;
    border-radius: 50%;
    border: none;
    background: #8b5cf6;
    color: white;
    font-size: 22px;
    font-weight: bold;
    cursor: pointer;

    display: flex;
    align-items: center;
    justify-content: center;
}

.add-btn:hover {
    background: #7c3aed;
}

/* BOTONES "VER MÁS" */
.btn-more {
    display: inline-block;
    margin-top: 12px;
    padding: 8px 14px;
    border-radius: 999px;
    background: linear-gradient(90deg, #8b5cf6, #a6c1ee);
    color: white;
    text-decoration: none;
    font-size: 14px;
    font-weight: 600;
    transition: 0.2s ease;
    box-shadow: 0 3px 10px rgba(0,0,0,0.08);
}

.btn-more:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0,0,0,0.12);
}

/* BOTÓN TERMINAR*/
.btn-finish {
    padding: 8px 14px;
    border-radius: 999px;
    border: none;
    background: linear-gradient(90deg, #34d399, #22c55e);
    color: white;
    font-weight: 600;
    font-size: 13px;
    cursor: pointer;
    margin-top: 10px;
    transition: 0.2s ease;
    box-shadow: 0 3px 10px rgba(0,0,0,0.08);
}

.btn-finish:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0,0,0,0.12);
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

/* LOGOUT */
.logout-footer {
    display: flex;
    justify-content: flex-end;
    padding: 20px 30px;
}

.logout-link {
    text-decoration: none;
    font-weight: bold;
    color: #e11d48;
    font-size: 14px;
    transition: 0.2s ease;
}

.logout-link:hover {
    transform: translateY(-2px);
}
</style>

</head>
<body>

<div class="navbar">
    <a href="home.jsp">🏠 Home</a>
    <a href="library.jsp">📚 Librería</a>
    <a href="reviews.jsp">📝 Reseñas</a>
</div>

<div class="container">

<h1>Bienvenid@, <%= user.getUsername() %> 👋</h1>

<div class="columns">

<!-- LEYENDO -->
<div class="column">
<h2>📖 Leyendo</h2>

<%
for (UserBook b : books) {
    if ("reading".equals(b.getStatus())) {
%>

<div class="card">

	<div class="cover-container">
    <img src="<%= (b.getCoverUrl() != null && !b.getCoverUrl().isEmpty())
        ? b.getCoverUrl()
        : "https://covers.openlibrary.org/b/title/" + (b.getTitle() + " " + b.getAuthor()).replace(" ", "+") + "-M.jpg" %>"
     onerror="this.src='https://via.placeholder.com/150x220?text=Sin+portada';">
</div>
         
    <div class="title">
    <a class="book-link" href="bookDetails.jsp?id=<%= b.getId() %>">
        <%= b.getTitle() %>
    </a>
</div>

    <small><%= b.getAuthor() %></small>

    <form action="finishBook" method="post">
        <input type="hidden" name="id" value="<%= b.getId() %>">
        <button type="submit" class="btn-finish">🏁 Terminar</button>
    </form>

</div>

<%
    }
}
%>

</div>

<!-- PENDIENTES -->
<div class="column">
<h2>📚 Pendientes</h2>

<%
int countPending = 0;

for (UserBook b : books) {
    if ("pending".equals(b.getStatus()) && countPending < 2) {
        countPending++;
%>

<div class="card">

	<div class="cover-container">
    <img src="<%= (b.getCoverUrl() != null && !b.getCoverUrl().isEmpty())
        ? b.getCoverUrl()
        : "https://covers.openlibrary.org/b/title/" + (b.getTitle() + " " + b.getAuthor()).replace(" ", "+") + "-M.jpg" %>"
     onerror="this.src='https://via.placeholder.com/150x220?text=Sin+portada';">
</div>

    <div class="title">
    <a class="book-link" href="bookDetails.jsp?id=<%= b.getId() %>">
        <%= b.getTitle() %>
    </a>
</div>

    <small><%= b.getAuthor() %></small>

</div>

<%
    }
}
%>

<a href="library.jsp" class="btn-more">Ver más</a>

</div>

<!-- LEÍDOS -->
<div class="column">
<h2>✅ Leídos</h2>

<%
int countFinished = 0;

for (UserBook b : books) {
    if ("finished".equals(b.getStatus()) && countFinished < 2) {
        countFinished++;
%>

<div class="card">

	<div class="cover-container">
    <img src="<%= (b.getCoverUrl() != null && !b.getCoverUrl().isEmpty())
        ? b.getCoverUrl()
        : "https://covers.openlibrary.org/b/title/" + (b.getTitle() + " " + b.getAuthor()).replace(" ", "+") + "-M.jpg" %>"
     onerror="this.src='https://via.placeholder.com/150x220?text=Sin+portada';">
</div>

   <div class="title">
    <a class="book-link" href="bookDetails.jsp?id=<%= b.getId() %>">
        <%= b.getTitle() %>
    </a>
</div>

    <small><%= b.getAuthor() %></small>

    <p>⭐ <%= b.getRating() %> / 5</p>

</div>

<%
    }
}
%>

<a href="reviews.jsp" class="btn-more">Ver más</a>

</div>

</div>

<!-- AÑADIR LIBRO -->
<h2>➕ Añadir libro</h2>

<div class="card add-book-card">

<form action="addBook" method="post" class="add-form">

    <input type="text" name="title" placeholder="Título" required>

    <input type="text" name="author" placeholder="Autor" required>

    <input type="number" name="pages" placeholder="Páginas" required>
    
    <input type="text" name="coverUrl" placeholder="URL de la portada">

    <select name="status" required>
        <option value="" disabled selected>Estado</option>
        <option value="pending">Pendiente</option>
        <option value="reading">Leyendo</option>
        <option value="finished">Leído</option>
    </select>

    <button type="submit" class="add-btn">＋</button>

</form>

</div>

</div>

<div class="logout-footer">
    <a href="<%= request.getContextPath() %>/LogoutServlet" class="logout-link"> 🚪 Cerrar sesión </a>
</div>

</body>
</html>