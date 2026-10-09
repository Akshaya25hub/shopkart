<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>

<%
String username=(String)session.getAttribute("username");

Integer customer_id=(Integer)session.getAttribute("customer_id");

if(username==null || customer_id==null)
{
    response.sendRedirect("login.jsp");
    return;
}


Class.forName("com.mysql.cj.jdbc.Driver");

Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/shopkart",
"root",
"ShopKart@1234");


PreparedStatement ps=con.prepareStatement(
"SELECT * FROM orders WHERE customer_id=?");


ps.setInt(1,customer_id);


ResultSet rs=ps.executeQuery();

%>


<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>My Orders</title>


<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:Arial;
}


body{

background:#f1f3f6;

}


.header{

background:#1565C0;

color:white;

padding:18px;

text-align:center;

font-size:26px;

font-weight:bold;

}


.container{

width:90%;

margin:40px auto;

}


table{

width:100%;

border-collapse:collapse;

background:white;

box-shadow:0px 0px 10px lightgray;

}


th{

background:#1565C0;

color:white;

padding:15px;

border:1px solid #ddd;

}


td{

padding:15px;

text-align:center;

border:1px solid #ddd;

}


tr:hover{

background:#f5f5f5;

}


.status{

color:green;

font-weight:bold;

}


.btn{

display:inline-block;

margin-top:25px;

padding:12px 25px;

background:#1565C0;

color:white;

text-decoration:none;

border-radius:5px;

}


</style>


</head>


<body>


<div class="header">

🛒 SHOPKART - My Orders

</div>


<div class="container">

<h2 style="text-align:center;color:#1565C0;margin-bottom:20px;">
My Orders
</h2>


<table>

<tr>

<th>Order ID</th>

<th>Customer ID</th>

<th>Total Amount</th>

<th>Order Date</th>

<th>Status</th>
<th>Action</th>

</tr>
<%

while(rs.next())
{

%>

<tr>

<td>
<%=rs.getInt("order_id")%>
</td>


<td>
<%=rs.getInt("customer_id")%>
</td>


<td>
₹ <%=rs.getDouble("total_amount")%>
</td>


<td>
<%=rs.getTimestamp("order_date")%>
</td>


<td class="status">
<%=rs.getString("status")%>
</td>

<td>
<a href="cancelOrder.jsp?order_id=<%=rs.getInt("order_id")%>">
Cancel Order
</a>
</td>


</tr>


<%

}

con.close();

%>


</table>


<center>

<a href="products.jsp" class="btn">

Continue Shopping

</a>


</center>


</div>


</body>

</html>