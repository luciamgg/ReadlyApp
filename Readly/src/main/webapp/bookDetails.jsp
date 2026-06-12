<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="readly.dao.UserBookDAO" %>
<%@ page import="readly.model.UserBook" %>

<%
String param = request.getParameter("id");

if (param == null) {
    out.println("No se ha recibido ID");
    return;
}

int id = Integer.parseInt(param);

UserBookDAO dao = new UserBookDAO();
UserBook b = dao.getBookById(id);

if (b == null) {
    out.println("Libro no encontrado");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= b.getTitle() %></title>

<style>
body {
    font-family: Arial;
    background: #faf7f2;
    margin: 0;
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

/* LAYOUT */
.container {
    display: flex;
    gap: 40px;
    padding: 40px;
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

/* INFO */
.info {
    max-width: 500px;
}

.title {
    font-size: 28px;
    font-weight: bold;
}

.author {
    color: #666;
    margin-bottom: 10px;
}

.status {
    display: inline-block;
    padding: 6px 12px;
    border-radius: 20px;
    background: #8b5cf6;
    color: white;
    font-size: 14px;
    margin-top: 10px;
}

/* RESEÑA */
.review {
    margin-top: 20px;
    line-height: 1.5;
}

/* BOTONES */
.buttons {
    margin-top: 25px;
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
}

.btn {
    padding: 10px 12px;
    border: none;
    border-radius: 10px;
    cursor: pointer;
    font-weight: bold;
    text-decoration: none;
    display: inline-block;
}

.btn-primary {
    background: #8b5cf6;
    color: white;
}

.btn-secondary {
    background: #ddd;
    color: #333;
}
</style>

</head>
<body>

<!-- NAVBAR -->
<div class="navbar">
    <a href="home.jsp">🏠 Home</a>
    <a href="library.jsp">📚 Librería</a>
    <a href="reviews.jsp">📝 Reseñas</a>
</div>

<div class="container">

<div class="cover-container">
    <img src="<%= (b.getCoverUrl() != null && !b.getCoverUrl().isEmpty())
        ? b.getCoverUrl()
        : "https://covers.openlibrary.org/b/title/" + (b.getTitle() + " " + b.getAuthor()).replace(" ", "+") + "-M.jpg" %>"
     onerror="this.src='https://via.placeholder.com/150x220?text=Sin+portada';">
</div>

<div class="info">

<div class="title"><%= b.getTitle() %></div>
<div class="author"><%= b.getAuthor() %></div>

<%
String estado = "";

if ("pending".equals(b.getStatus())) {
    estado = "Pendiente";
} else if ("reading".equals(b.getStatus())) {
    estado = "Leyendo";
} else if ("finished".equals(b.getStatus())) {
    estado = "Leído";
}
%>

<p class="status"><%= estado %></p>

<p>⭐ <%= b.getRating() %> / 5</p>

<div class="review">
    <h3>📝 Reseña</h3>
    <p><%= b.getReview() != null ? b.getReview() : "Aún no hay reseña" %></p>
</div>

<!-- BOTONES -->
<div class="buttons">

    <!-- EDITAR RESEÑA -->
    <form action="reviewForm.jsp" method="get" style="margin:0;">
        <input type="hidden" name="id" value="<%= b.getId() %>">
        <button class="btn btn-primary" type="submit">
            ✏️ Editar reseña
        </button>
    </form>

    <!-- VOLVER -->
    <form action="home.jsp" method="get" style="margin:0;">
        <button class="btn btn-secondary" type="submit">
            ← Volver
        </button>
    </form>

</div>

</div>

</div>

</body>
</html>