<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ShopKart - Home</title>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:Arial,sans-serif;
}

body{
background:#f5f5f5;
}

header{
background:#1565C0;
color:white;
padding:18px 40px;
display:flex;
justify-content:space-between;
align-items:center;
}

.logo{
font-size:30px;
font-weight:bold;
}

nav a{
color:white;
text-decoration:none;
margin-left:20px;
font-size:17px;
font-weight:bold;
}

.hero{
text-align:center;
padding:60px 20px;
background:white;
}

.hero h1{
font-size:42px;
color:#1565C0;
margin-bottom:15px;
}

.hero p{
font-size:18px;
color:#555;
margin-bottom:30px;
}

.hero a{
text-decoration:none;
padding:14px 28px;
margin:10px;
border-radius:6px;
background:#1565C0;
color:white;
font-size:18px;
display:inline-block;
}

.hero a:hover{
background:#0D47A1;
}

.section{
width:90%;
margin:40px auto;
}

.section h2{
text-align:center;
margin-bottom:30px;
color:#1565C0;
}

.categories{
display:flex;
justify-content:center;
gap:25px;
flex-wrap:wrap;
}

.card{
background:white;
width:180px;
padding:25px;
border-radius:10px;
box-shadow:0 0 10px #ccc;
text-align:center;
}

.card h3{
margin-top:15px;
color:#333;
}

footer{
margin-top:60px;
background:#1565C0;
color:white;
text-align:center;
padding:18px;
}

</style>

</head>

<body>

<header>

<div class="logo">
🛒 ShopKart
</div>

<nav>

<a href="index.jsp">Home</a>

<a href="login.jsp">Login</a>

<a href="register.jsp">Register</a>

<a href="adminlogin.jsp">Admin</a>

</nav>

</header>

<div class="hero">

<h1>Welcome to ShopKart</h1>


<a href="login.jsp">Customer Login</a>

<a href="register.jsp">Register</a>

</div>

<div class="section">

<h2>Product Categories</h2>

<div class="categories">

<div class="card">
📱
<h3>Mobiles</h3>
</div>

<div class="card">
💻
<h3>Laptops</h3>
</div>

<div class="card">
👕
<h3>Fashion</h3>
</div>

<div class="card">
📺
<h3>Electronics</h3>
</div>

<div class="card">
🏠
<h3>Home Appliances</h3>
</div>

</div>

</div>

<footer>

© 2026 ShopKart | E-Commerce Management System

</footer>

</body>
</html>