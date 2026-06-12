<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="readly.dao.UserBookDAO" %>
<%@ page import="readly.model.UserBook" %>

<%
int id = Integer.parseInt(request.getParameter("id"));

UserBookDAO dao = new UserBookDAO();
UserBook b = dao.getBookById(id);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reseña</title>

<style>
body {
    font-family: Arial;
    background: #faf7f2;
    margin: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

/* CARD */
.card {
    background: white;
    padding: 25px;
    border-radius: 16px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.08);
    width: 380px;
}

/* TITULO LIBRO */
.title {
    font-size: 20px;
    font-weight: bold;
    margin-bottom: 5px;
}

/* AUTOR */
.author {
    color: #777;
    margin-bottom: 15px;
}

/* SELECT ESTRELLAS */
select, textarea {
    width: 100%;
    padding: 10px;
    border-radius: 10px;
    border: 1px solid #ddd;
    margin-bottom: 15px;
    font-family: Arial;
}

/* TEXTAREA */
textarea {
    height: 120px;
    resize: none;
}

/* BOTÓN */
button {
    width: 100%;
    padding: 10px;
    border: none;
    border-radius: 10px;
    background: #8b5cf6;
    color: white;
    font-weight: bold;
    cursor: pointer;
}

button:hover {
    background: #7c3aed;
}

input, textarea, select {
    box-sizing: border-box;
}

textarea {
    width: 100%;
    min-height: 120px;
    resize: none;
}
</style>

</head>

<body>

<div class="card">

    <div class="title"><%= b.getTitle() %></div>
    <div class="author"><%= b.getAuthor() %></div>

    <form action="updateReview" method="post">

        <input type="hidden" name="id" value="<%= id %>">

        <select name="rating" required>
            <option value="" disabled selected>Puntuación</option>
            <option value="1">⭐</option>
            <option value="2">⭐⭐</option>
            <option value="3">⭐⭐⭐</option>
            <option value="4">⭐⭐⭐⭐</option>
            <option value="5">⭐⭐⭐⭐⭐</option>
        </select>

        <textarea name="review" placeholder="Escribe tu reseña..." required></textarea>

        <button type="submit">Guardar reseña</button>

    </form>

</div>

</body>
</html>