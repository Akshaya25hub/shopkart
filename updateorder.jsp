<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.sql.*"%>

<%
String admin=(String)session.getAttribute("admin");

if(admin==null)
{
    response.sendRedirect("adminlogin.jsp");
    return;
}

String order_id=request.getParameter("order_id");

if(order_id==null)
{
    out.println("Order not found");
    return;
}

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/shopkart",
"root",
"ShopKart@1234");

String status="";

PreparedStatement ps=con.prepareStatement(
"SELECT status FROM orders WHERE order_id=?");

ps.setInt(1,Integer.parseInt(order_id));

ResultSet rs=ps.executeQuery();

if(rs.next())
{
    status=rs.getString("status");
}
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Update Order Status</title>

<style>

body{
font-family:Arial;
background:#f2f2f2;
}

.container{
width:400px;
margin:60px auto;
background:white;
padding:30px;
border-radius:10px;
box-shadow:0 0 10px gray;
}

h2{
text-align:center;
color:#1565C0;
}

select,button{
width:100%;
padding:12px;
margin-top:15px;
font-size:16px;
}

button{
background:#1565C0;
color:white;
border:none;
border-radius:5px;
cursor:pointer;
}

</style>

</head>

<body>

<div class="container">

<h2>Update Order Status</h2>

<form method="post">

<input type="hidden" name="order_id" value="<%=order_id%>">

<label>Order Status</label>

<select name="status">

<option <% if(status.equals("Placed")){ %>selected<% } %>>
Placed
</option>

<option <% if(status.equals("Shipped")){ %>selected<% } %>>
Shipped
</option>

<option <% if(status.equals("Delivered")){ %>selected<% } %>>
Delivered
</option>

</select>

<button type="submit">

Update Status

</button>

</form>

<%

if(request.getMethod().equalsIgnoreCase("POST"))
{

String newStatus=request.getParameter("status");

PreparedStatement ps2=con.prepareStatement(
"UPDATE orders SET status=? WHERE order_id=?");

ps2.setString(1,newStatus);

ps2.setInt(2,Integer.parseInt(order_id));

ps2.executeUpdate();

response.sendRedirect("manageorders.jsp");

}

con.close();

%>

</div>

</body>

</html>