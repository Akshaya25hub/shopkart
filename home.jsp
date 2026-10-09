<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%
String username=(String)session.getAttribute("username");

if(username==null)
{
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ShopKart - Home</title>

<style>

body{
    margin:0;
    font-family:Arial,sans-serif;
    background:#f1f3f6;
}

.header{
    background:#2874F0;
    color:white;
    padding:18px;
    text-align:center;
    font-size:28px;
    font-weight:bold;
}

.container{
    width:80%;
    margin:40px auto;
    background:white;
    padding:30px;
    border-radius:10px;
    box-shadow:0 0 10px lightgray;
    text-align:center;
}

h2{
    color:#1565C0;
}

.search{
    margin:30px;
}

.search input{
    width:300px;
    padding:10px;
    font-size:16px;
}

.search button{
    padding:10px 20px;
    background:#2874F0;
    color:white;
    border:none;
    cursor:pointer;
}

.menu{
    margin-top:40px;
}

.menu a{
    display:inline-block;
    margin:10px;
    padding:15px 25px;
    background:#2874F0;
    color:white;
    text-decoration:none;
    border-radius:6px;
    font-size:18px;
}

.menu a:hover{
    background:#1565C0;
}

</style>

</head>

<body>

<div class="header">
🛒 SHOPKART
</div>

<div class="container">

<h2>Welcome, <%=username %></h2>

<div class="search">
    <form action="products.jsp" method="get">
        <input type="text" name="search" placeholder="Search Products..." required>
        <button type="submit">Search</button>
    </form>
</div>

<div class="menu">
    <a href="products.jsp">🛍 Shop Now</a>
    <a href="profile.jsp">👤 My Profile</a>
    <a href="orders.jsp">📦 My Orders</a>
    <a href="logout.jsp">🚪 Logout</a>
</div>

</div>

</body>
</html>