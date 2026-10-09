<%@ page import="java.sql.*" %>

<%
String message="";

if(request.getMethod().equalsIgnoreCase("POST"))
{
    String username=request.getParameter("username");
    String password=request.getParameter("password");

    try
    {
        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection con=DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/shopkart",
        "root",
        "ShopKart@1234");

        PreparedStatement ps=con.prepareStatement(
        "SELECT * FROM admin WHERE username=? AND password=?");

        ps.setString(1,username);
        ps.setString(2,password);

        ResultSet rs=ps.executeQuery();

        if(rs.next())
        {
            session.setAttribute("admin",username);
            response.sendRedirect("admindashboard.jsp");
        }
        else
        {
            message="Invalid Username or Password!";
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

<title>Admin Login</title>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:Arial;
}

body{
background:#1565C0;
display:flex;
justify-content:center;
align-items:center;
height:100vh;
}

.container{
width:400px;
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

input{
width:100%;
padding:12px;
margin:10px 0;
border:1px solid #ccc;
border-radius:5px;
}

button{
width:100%;
padding:12px;
background:#1565C0;
color:white;
border:none;
font-size:18px;
border-radius:5px;
cursor:pointer;
}

button:hover{
background:#0D47A1;
}

.msg{
text-align:center;
color:red;
font-weight:bold;
margin-bottom:10px;
}

</style>

</head>

<body>

<div class="container">

<h2>ShopKart Admin Login</h2>

<div class="msg">

<%=message%>

</div>

<form method="post">

<input
type="text"
name="username"
placeholder="Enter Username"
required>

<input
type="password"
name="password"
placeholder="Enter Password"
required>

<button type="submit">

Login

</button>

</form>

</div>

</body>
</html>