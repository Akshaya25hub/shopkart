<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%
String admin=(String)session.getAttribute("admin");

if(admin==null)
{
    response.sendRedirect("adminlogin.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ShopKart Admin Dashboard</title>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:Arial;
}

body{
background:#f2f2f2;
}

.header{
background:#1565C0;
color:white;
padding:20px;
text-align:center;
font-size:28px;
font-weight:bold;
}

.container{
width:80%;
margin:40px auto;
text-align:center;
}

.card{
display:inline-block;
width:220px;
padding:20px;
margin:15px;
background:white;
border-radius:10px;
box-shadow:0px 0px 10px gray;
}

.card a{
text-decoration:none;
font-size:20px;
color:#1565C0;
font-weight:bold;
}

.logout{
margin-top:40px;
}

.logout a{
background:red;
color:white;
padding:12px 25px;
text-decoration:none;
border-radius:5px;
}

</style>

</head>

<body>

<div class="header">
ShopKart Admin Dashboard
</div>

<div class="container">

<h2>Welcome Admin : <%=admin %></h2>

<div class="card">
<a href="addcategory.jsp">Add Category</a>
</div>

<div class="card">
<a href="addsubcategory.jsp">Add Subcategory</a>
</div>

<div class="card">
<a href="addproduct.jsp">Add Product</a>
</div>

<div class="card">
<a href="manageproducts.jsp">Manage Products</a>
</div>

<div class="card">
<a href="manageorders.jsp">Manage Orders</a>
</div>

<div class="logout">
<a href="logout.jsp">Logout</a>
</div>

</div>

</body>
</html>