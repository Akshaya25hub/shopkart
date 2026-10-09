<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.sql.*"%>

<%
String admin=(String)session.getAttribute("admin");

if(admin==null)
{
    response.sendRedirect("adminlogin.jsp");
    return;
}

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/shopkart",
"root",
"ShopKart@1234");

PreparedStatement ps=con.prepareStatement(
"SELECT * FROM orders ORDER BY order_date DESC");

ResultSet rs=ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Manage Orders</title>

<style>

body{
font-family:Arial;
background:#f2f2f2;
}

h2{
text-align:center;
color:#1565C0;
margin-top:20px;
}

table{
width:95%;
margin:30px auto;
border-collapse:collapse;
background:white;
}

th{
background:#1565C0;
color:white;
padding:12px;
}

td{
padding:12px;
text-align:center;
border:1px solid #ddd;
}

a{
text-decoration:none;
color:blue;
font-weight:bold;
}

</style>

</head>

<body>

<h2>Manage Orders</h2>

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

<td><%=rs.getInt("order_id")%></td>

<td><%=rs.getInt("customer_id")%></td>

<td>₹ <%=rs.getDouble("total_amount")%></td>

<td><%=rs.getTimestamp("order_date")%></td>

<td><%=rs.getString("status")%></td>

<td>

<a href="updateorder.jsp?order_id=<%=rs.getInt("order_id")%>">

Update Status

</a>

</td>

</tr>

<%
}

con.close();
%>

</table>

<center>

<a href="admindashboard.jsp">

Back to Dashboard

</a>

</center>

</body>
</html>