<%@ page import="java.sql.*" %>

<%
String username=(String)session.getAttribute("username");

if(username==null)
{
    response.sendRedirect("login.jsp");
    return;
}

String message="";

try
{
    Class.forName("com.mysql.cj.jdbc.Driver");

    Connection con=DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/shopkart",
    "root",
    "ShopKart@1234");

    if(request.getMethod().equalsIgnoreCase("POST"))
    {
        String name=request.getParameter("name");
        String phone=request.getParameter("phone");
        String address=request.getParameter("address");

        PreparedStatement ps=con.prepareStatement(
        "UPDATE customers SET name=?, phone=?, address=? WHERE email=?");

        ps.setString(1,name);
        ps.setString(2,phone);
        ps.setString(3,address);
        ps.setString(4,(String)session.getAttribute("email"));

        int i=ps.executeUpdate();

        if(i>0)
        {
            session.setAttribute("username",name);
            message="Profile Updated Successfully!";
        }
    }

    PreparedStatement ps=con.prepareStatement(
    "SELECT * FROM customers WHERE name=?");

    ps.setString(1,username);

    ResultSet rs=ps.executeQuery();

    if(rs.next())
    {
%>

<!DOCTYPE html>
<html>
<head>

<title>Update Profile</title>

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
}

input,textarea{
width:100%;
padding:10px;
margin:10px 0;
}

button{
width:100%;
padding:12px;
background:#1565C0;
color:white;
border:none;
font-size:18px;
}

.msg{
color:green;
text-align:center;
font-weight:bold;
}

a{
text-decoration:none;
background:#1565C0;
color:white;
padding:10px 20px;
margin:5px;
display:inline-block;
}

</style>

</head>

<body>

<div class="container">

<h2>Update Profile</h2>

<div class="msg"><%=message%></div>

<form method="post">

Name

<input type="text" name="name"
value="<%=rs.getString("name")%>">

Email

<input type="email"
value="<%=rs.getString("email")%>"
readonly>

Phone

<input type="text" name="phone"
value="<%=rs.getString("phone")%>">

Address

<textarea name="address"><%=rs.getString("address")%></textarea>

<button type="submit">

Update Profile

</button>

</form>

<br>

<center>

<a href="profile.jsp">My Profile</a>

<a href="home.jsp">Home</a>

</center>

</div>

</body>

</html>

<%
    }

    con.close();
}
catch(Exception e)
{
    out.println(e);
}
%>