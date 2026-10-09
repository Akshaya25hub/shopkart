<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*" %>

<%
String username = (String) session.getAttribute("username");

if(username == null)
{
    response.sendRedirect("login.jsp");
    return;
}

/* Get product ID */
String pid = request.getParameter("pid");

double total = 0;
String errorMessage = "";

if(pid == null || pid.trim().equals(""))
{
    errorMessage = "No Product ID was received. Please select a product first.";
}
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Shopping Cart</title>

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

header{
    background:#1565C0;
    color:white;
    padding:15px;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

header a{
    color:white;
    text-decoration:none;
    font-weight:bold;
}

.container{
    width:90%;
    margin:30px auto;
}

table{
    width:100%;
    border-collapse:collapse;
    background:white;
    box-shadow:0px 0px 10px gray;
}

th{
    background:#1565C0;
    color:white;
    padding:12px;
}

td{
    padding:12px;
    text-align:center;
    border-bottom:1px solid #ddd;
}

img{
    width:80px;
    height:80px;
    object-fit:contain;
}

.btn{
    display:inline-block;
    padding:10px 20px;
    background:#1565C0;
    color:white;
    text-decoration:none;
    border-radius:5px;
    margin-top:20px;
}

.btn:hover{
    background:#0D47A1;
}

.error{
    background:#ffe0e0;
    color:red;
    padding:15px;
    margin-bottom:20px;
    text-align:center;
    font-weight:bold;
}

</style>

</head>

<body>

<header>

<h2>My Cart</h2>

<a href="products.jsp">Back to Products</a>

</header>


<div class="container">

<%
if(!errorMessage.equals(""))
{
%>

<div class="error">

<%=errorMessage%>

</div>

<%
}
else
{
%>

<table>

<tr>

<th>Image</th>

<th>Product</th>

<th>Price</th>

<th>Quantity</th>

<th>Total</th>

</tr>

<%

try
{

    Class.forName("com.mysql.cj.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/shopkart",
        "root",
        "ShopKart@1234"
    );

    PreparedStatement ps = con.prepareStatement(
        "SELECT * FROM products WHERE pid=?"
    );

    ps.setInt(1, Integer.parseInt(pid));

    ResultSet rs = ps.executeQuery();

    if(rs.next())
    {

        double price = rs.getDouble("price");

        int quantity = 1;

        total = price * quantity;

%>

<tr>

<td>

<img src="images/<%=rs.getString("image")%>">

</td>

<td>

<%=rs.getString("product_name")%>

</td>

<td>

&#8377; <%=price%>

</td>

<td>

<%=quantity%>

</td>

<td>

&#8377; <%=total%>

</td>

</tr>

<%

    }
    else
    {

%>

<tr>

<td colspan="5">

Product not found.

</td>

</tr>

<%

    }

    con.close();

}
catch(Exception e)
{

%>

<tr>

<td colspan="5">

<%=e.getMessage()%>

</td>

</tr>

<%

}

%>

</table>


<center>

<h2 style="margin-top:20px;">

Grand Total : &#8377; <%=total%>

</h2>

<br>

<a href="checkout.jsp?pid=<%=pid%>" class="btn">

Proceed To Checkout

</a>

</center>

<%
}
%>

</div>

</body>

</html>