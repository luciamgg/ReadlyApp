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
<title>Librería</title>

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

/* FILTROS */
.filters {
    margin-bottom: 20px;
}

.filters button {
    margin-right: 10px;
    padding: 6px 12px;
    border-radius: 20px;
    border: none;
    background: #ddd;
    cursor: pointer;
}

.filters button:hover {
    background: #8b5cf6;
    color: white;
}

/* GRID */
.grid {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
}

/* CARD */
.card {
    width: 180px;
    background: white;
    padding: 12px;
    border-radius: 12px;
    box-shadow: 0 3px 8px rgba(0,0,0,0.05);
    transition: 0.2s ease;
}

/* HOVER */
.card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 18px rgba(0,0,0,0.12);
}

/* LINK */
.card-link {
    text-decoration: none;
    color: inherit;
    display: block;
}

/* TEXTO */
.title {
    font-weight: bold;
}

/* ESTADOS */
.status {
    margin-top: 8px;
    padding: 4px 10px;
    border-radius: 20px;
    display: inline-block;
    font-size: 12px;
    color: white;
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
.pending { background: #f59e0b; }
.reading { background: #3b82f6; }
.finished { background: #10b981; }
</style>

<script>
function filterBooks(status) {
    let cards = document.querySelectorAll(".card");

    cards.forEach(card => {
        if (status === "all" || card.dataset.status === status) {
            card.style.display = "block";
        } else {
            card.style.display = "none";
        }
    });
}
</script>

</head>

<body>

<jsp:include page="navbar.jsp" />

<div class="container">

<h1>📚 Tu librería</h1>

<!-- FILTROS -->
<div class="filters">
    <button onclick="filterBooks('all')">Todos</button>
    <button onclick="filterBooks('reading')">Leyendo</button>
    <button onclick="filterBooks('pending')">Pendientes</button>
    <button onclick="filterBooks('finished')">Leídos</button>
</div>

<!-- LIBROS -->
<div class="grid">

<%
for (UserBook b : books) {

    String estado = "";

    if ("reading".equals(b.getStatus())) {
        estado = "Leyendo";
    } else if ("pending".equals(b.getStatus())) {
        estado = "Pendiente";
    } else if ("finished".equals(b.getStatus())) {
        estado = "Leído";
    }
%>

<div class="card" data-status="<%= b.getStatus() %>">

    <a class="card-link" href="bookDetails.jsp?id=<%= b.getId() %>">
    
    	<div class="cover-container">
    <img src="<%= (b.getCoverUrl() != null && !b.getCoverUrl().isEmpty())
        ? b.getCoverUrl()
        : "https://covers.openlibrary.org/b/title/" + (b.getTitle() + " " + b.getAuthor()).replace(" ", "+") + "-M.jpg" %>"
     onerror="this.src='https://via.placeholder.com/150x220?text=Sin+portada';">
</div>
    

        <div class="title"><%= b.getTitle() %></div>

        <small><%= b.getAuthor() %></small>

        <div class="status <%= b.getStatus() %>">
            <%= estado %>
        </div>

        <% if ("finished".equals(b.getStatus())) { %>
            <p>⭐ <%= b.getRating() %> / 5</p>
        <% } %>

    </a>

</div>

<%
}
%>

</div>

</div>

</body>
</html>