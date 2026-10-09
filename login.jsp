<%@ page import="java.sql.*" %>

<%
String message="";

if(request.getMethod().equalsIgnoreCase("POST"))
{
    String email=request.getParameter("email");
    String password=request.getParameter("password");

    try
    {
        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection con=DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/shopkart",
        "root",
        "ShopKart@1234");

        PreparedStatement ps=con.prepareStatement(
        "SELECT * FROM customers WHERE email=? AND password=?");

        ps.setString(1,email);
        ps.setString(2,password);

        ResultSet rs=ps.executeQuery();

        if(rs.next())
        {
            session.setAttribute("username",rs.getString("name"));
            session.setAttribute("customer_id", rs.getInt("id"));
            response.sendRedirect("home.jsp");
        }
        else
        {
            message="Invalid Email or Password!";
        }

        con.close();

    }
    catch(Exception e)
    {
        message=e.getMessage();
    }
}
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Customer Login</title>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:Arial;
}

body{
background:linear-gradient(to right,#1565C0,#42A5F5);
display:flex;
justify-content:center;
align-items:center;
height:100vh;
}

.container{

background:white;

width:380px;

padding:30px;

border-radius:12px;

box-shadow:0px 0px 15px gray;

}

.container h2{

text-align:center;

margin-bottom:20px;

color:#1565C0;

}

input{

width:100%;

padding:12px;

margin:12px 0;

border:1px solid #ccc;

border-radius:5px;

}

button{

width:100%;

padding:12px;

background:#1565C0;

color:white;

border:none;

border-radius:5px;

font-size:18px;

cursor:pointer;

}

button:hover{

background:#0D47A1;

}

.msg{

text-align:center;

color:red;

margin-bottom:15px;

font-weight:bold;

}

a{

text-decoration:none;

color:#1565C0;

}

</style>

</head>

<body>

<div class="container">

<h2>Customer Login</h2>

<div class="msg">

<%=message %>

</div>

<form method="post">

<input type="email"
name="email"
placeholder="Enter Email"
required>

<input type="password"
name="password"
placeholder="Enter Password"
required>

<button type="submit">

Login

</button>

</form>

<br>

<center>

Don't have an account?

<a href="register.jsp">

Register

</a>

</center>

</div>

</body>
</html>