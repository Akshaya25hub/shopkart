<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>

<%
String username=(String)session.getAttribute("username");

if(username==null)
{
    response.sendRedirect("login.jsp");
    return;
}

String search=request.getParameter("search");
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>ShopKart Products</title>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:Arial,sans-serif;
}

body{
background:#f1f3f6;
}

header{
background:#2874F0;
padding:15px 40px;
display:flex;
justify-content:space-between;
align-items:center;
color:white;
}

header h2{
font-size:26px;
}

header a{
color:white;
text-decoration:none;
font-weight:bold;
margin-left:20px;
}

.search-box{
width:90%;
margin:20px auto;
text-align:center;
}

.search-box input{
width:350px;
padding:12px;
font-size:16px;
border:1px solid #ccc;
border-radius:5px;
}

.search-box button{
padding:12px 20px;
background:#2874F0;
color:white;
border:none;
border-radius:5px;
cursor:pointer;
}

.container{
width:95%;
margin:30px auto;
display:flex;
flex-wrap:wrap;
justify-content:center;
gap:20px;
}

.card{
width:280px;
background:white;
border-radius:10px;
box-shadow:0 0 10px rgba(0,0,0,0.2);
padding:15px;
text-align:center;
}

.card img{
width:180px;
height:180px;
object-fit:contain;
margin-bottom:15px;
}

.card h3{
color:#1565C0;
margin-bottom:10px;
}

.description{
height:60px;
font-size:14px;
color:#555;
overflow:hidden;
}

.price{
color:green;
font-size:22px;
font-weight:bold;
margin:10px 0;
}

.stock{
color:#444;
margin-bottom:15px;
}

.btn{
width:100%;
padding:10px;
margin-top:8px;
border:none;
border-radius:5px;
cursor:pointer;
font-size:16px;
}

.cart{
background:#ff9800;
color:white;
}

.buy{
background:#28a745;
color:white;
}

.btn:hover{
opacity:0.9;
}

</style>

</head>

<body>

<header>

<h2>🛒 ShopKart</h2>

<div>

Welcome <%=username%>

&nbsp;&nbsp;&nbsp;

<a href="home.jsp">Home</a>

<a href="orders.jsp">Orders</a>

<a href="logout.jsp">Logout</a>

</div>

</header>

<div class="search-box">

<form action="products.jsp" method="get">

<input
type="text"
name="search"
placeholder="Search products..."
value="<%=search==null ? "" : search%>">

<button type="submit">🔍 Search</button>

</form>

</div>
s
<div class="container">

<%

try
{

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/shopkart",
"root",
"ShopKart@1234");

PreparedStatement ps;

if(search!=null && !search.trim().equals(""))
{
ps=con.prepareStatement(
"SELECT p.*, c.category_name, s.subcategory_name FROM products p LEFT JOIN categories c ON p.category_id=c.category_id LEFT JOIN subcategories s ON p.subcategory_id=s.subcategory_id WHERE p.product_name LIKE ?"
);

ps.setString(1,"%"+search+"%");

}
else
{
ps=con.prepareStatement(
"SELECT p.*, c.category_name, s.subcategory_name FROM products p LEFT JOIN categories c ON p.category_id=c.category_id LEFT JOIN subcategories s ON p.subcategory_id=s.subcategory_id");

}

ResultSet rs=ps.executeQuery();

boolean found = false;
while(rs.next())
{
    found = true;

%>

<div class="card">

<img src="images/<%=rs.getString("image")%>">

<h3><%=rs.getString("product_name")%></h3>
<p>
<b>Category:</b>
<%=rs.getString("category_name")%>
</p>

<p>
<b>Subcategory:</b>
<%=rs.getString("subcategory_name")%>
</p>

<p class="description">
<%=rs.getString("description")%>
</p>

<p class="price">
&#8377; <%=rs.getDouble("price")%>
</p>

<p class="stock">
Stock :
<%=rs.getInt("stock")%>
</p>
<form action="cart.jsp" method="get">

    <input
        type="hidden"
        name="product_id"
        value="<%=rs.getInt("product_id")%>">

    <button type="submit" class="btn cart">
        🛒 Add to Cart
    </button>

</form>

<form action="checkout.jsp" method="get">

    <input
        type="hidden"
        name="product_id"
        value="<%=rs.getInt("product_id")%>">

    <button type="submit" class="btn buy">
        ⚡ Buy Now
    </button>

</form>

</div>

<%

}



if(!found)
{
%>

<div style="width:100%;text-align:center;margin-top:50px;">

<h2 style="color:red;">
Product Not Available!
</h2>

<p>
The product you searched for is not available.
</p>

</div>

<%
}


con.close();

}
catch(Exception e)
{

out.println("<h2 style='color:red;text-align:center;'>"+e+"</h2>");

}

%>

</div>

</body>
</html>