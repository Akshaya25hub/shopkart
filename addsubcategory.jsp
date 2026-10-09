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
    String categoryId=request.getParameter("category_id");
    String subcategory=request.getParameter("subcategory");

    try
    {
        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection con=DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/shopkart",
        "root",
        "ShopKart@1234");

        PreparedStatement ps=con.prepareStatement(
        "INSERT INTO subcategories(category_id, subcategory_name) VALUES(?,?)");

        ps.setInt(1,Integer.parseInt(categoryId));
        ps.setString(2,subcategory);

        int i=ps.executeUpdate();

        if(i>0)
        {
            message="Subcategory Added Successfully!";
        }
        else
        {
            message="Failed to Add Subcategory!";
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
<title>Add Subcategory</title>

<style>

body{
font-family:Arial;
background:#f2f2f2;
}

.container{
width:450px;
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

select,input{
width:100%;
padding:12px;
margin:12px 0;
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

<h2>Add Subcategory</h2>

<div class="msg">
<%=message%>
</div>

<form method="post">

<select name="category_id" required>

<option value="">Select Category</option>

<%
try
{
    Class.forName("com.mysql.cj.jdbc.Driver");

    Connection con=DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/shopkart",
    "root",
    "");

    Statement st=con.createStatement();

    ResultSet rs=st.executeQuery("SELECT * FROM categories");

    while(rs.next())
    {
%>

<option value="<%=rs.getInt("category_id")%>">

<%=rs.getString("category_name")%>

</option>

<%
    }

    con.close();

}
catch(Exception e)
{
    out.println(e);
}
%>

</select>

<input
type="text"
name="subcategory"
placeholder="Enter Subcategory Name"
required>

<button type="submit">

Add Subcategory

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