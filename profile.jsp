<%@ page import="java.sql.*" %>

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
<title>My Profile</title>

<style>

body{
font-family:Arial;
background:#f2f2f2;
}

.container{
width:500px;
margin:40px auto;
background:white;
padding:30px;
border-radius:10px;
box-shadow:0px 0px 10px gray;
}

h2{
text-align:center;
color:#1565C0;
margin-bottom:20px;
}

table{
width:100%;
}

td{
padding:10px;
font-size:18px;
}

th{
text-align:left;
color:#1565C0;
}

a{
display:inline-block;
margin-top:20px;
text-decoration:none;
background:#1565C0;
color:white;
padding:10px 20px;
border-radius:5px;
}

</style>

</head>

<body>

<div class="container">

<h2>My Profile</h2>

<%

try
{

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/shopkart",
"root",
"ShopKart@1234");

PreparedStatement ps=con.prepareStatement(
"SELECT * FROM customers WHERE name=?");

ps.setString(1,username);

ResultSet rs=ps.executeQuery();

if(rs.next())
{

%>

<table>

<tr>
<th>Name</th>
<td><%=rs.getString("name")%></td>
</tr>

<tr>
<th>Email</th>
<td><%=rs.getString("email")%></td>
</tr>

<tr>
<th>Phone</th>
<td><%=rs.getString("phone")%></td>
</tr>

<tr>
<th>Address</th>
<td><%=rs.getString("address")%></td>
</tr>

</table>

<%

}

con.close();

}

catch(Exception e)
{
out.println(e);
}

%>

<center>

<a href="home.jsp">Back Home</a>

</center>

</div>

</body>
</html>