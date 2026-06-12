<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>

<style>
body {
    margin: 0;
    font-family: Arial;
    background: linear-gradient(135deg, #fbc2eb, #a6c1ee);
    height: 100vh;

    display: flex;
    align-items: center;
    justify-content: center;
}

/* CARD LOGIN */
.login-card {
    background: white;
    padding: 40px;
    border-radius: 16px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.1);
    width: 320px;
    text-align: center;
}

/* TITULO */
.login-card h2 {
    margin-bottom: 25px;
    color: #333;
}

/* INPUTS */
.login-card input {
    width: 100%;
    padding: 10px;
    margin-bottom: 15px;
    border-radius: 8px;
    border: 1px solid #ddd;
    outline: none;

    box-sizing: border-box;
}

.login-card input:focus {
    border-color: #8b5cf6;
}

/* BOTÓN */
.login-card button {
    padding: 10px 25px;
    border: none;
    border-radius: 999px;
    background: #8b5cf6;
    color: white;
    font-weight: bold;
    cursor: pointer;
    transition: 0.2s;

    display: block;
    margin: 0 auto;
    width: fit-content;
}

.login-card button:hover {
    background: #7c3aed;
}

/* MINI TEXTO */
.login-card small {
    display: block;
    margin-top: 15px;
    color: #777;
}
</style>

</head>
<body>

<div class="login-card">

    <h2>📚 Readly</h2>

    <form action="<%= request.getContextPath() %>/LoginServlet" method="post">

        <input type="text" name="email" placeholder="Email" required>

        <input type="password" name="password" placeholder="Contraseña" required>

        <button type="submit">Entrar</button>

    </form>


</div>

</body>
</html>
