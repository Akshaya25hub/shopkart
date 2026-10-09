<%@ page import="java.sql.*" %>

<%
String message="";

String admin=(String)session.getAttribute("admin");

if(admin==null)
{
    response.sendRedirect("adminlogin.jsp");
    return;
}

if(request.getMethod().equalsIgnoreCase("POST"))
{
    String category=request.getParameter("category");

    try
    {
        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection con=DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/shopkart",
        "root",
        "ShopKart@1234");

        PreparedStatement ps=con.prepareStatement(
        "INSERT INTO categories(category_name) VALUES(?)");

        ps.setString(1,category);

        int i=ps.executeUpdate();

        if(i>0)
        {
            message="Category Added Successfully!";
        }
        else
        {
            message="Failed to Add Category!";
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

<title>Add Category</title>

<style>

body{
font-family:Arial;
background:#f2f2f2;
}

.container{
width:400px;
margin:80px auto;
background:white;
padding:30px;
border-radius:10px;
box-shadow:0px 0px 10px gray;
}

h2{
text-align:center;
color:#1565C0;
}

input{
width:100%;
padding:12px;
margin:15px 0;
}

button{
width:100%;
padding:12px;
background:#1565C0;
color:white;
border:none;
font-size:18px;
cursor:pointer;
}

.msg{
text-align:center;
color:green;
font-weight:bold;
margin:10px;
}

a{
text-decoration:none;
}

</style>

</head>

<body>

<div class="container">

<h2>Add Category</h2>

<div class="msg">

<%=message%>

</div>

<form method="post">

<input
type="text"
name="category"
placeholder="Enter Category Name"
required>

<button type="submit">

Add Category

</button>

</form>

<br>

<center>

<a href="admindashboard.jsp">

Back to Dashboard

</a>

</center>

</div>

</body>

</html>