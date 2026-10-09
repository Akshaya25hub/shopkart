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
    String subcategoryId=request.getParameter("subcategory_id");
    String productName=request.getParameter("product_name");
    String description=request.getParameter("description");
    String price=request.getParameter("price");
    String stock=request.getParameter("stock");
    String image=request.getParameter("image");

    try
    {
        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection con=DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/shopkart",
        "root",
        "ShopKart@1234");

        PreparedStatement ps=con.prepareStatement(
        "INSERT INTO products(category_id,subcategory_id,product_name,description,price,stock,image) VALUES(?,?,?,?,?,?,?)");

        ps.setInt(1,Integer.parseInt(categoryId));
        ps.setInt(2,Integer.parseInt(subcategoryId));
        ps.setString(3,productName);
        ps.setString(4,description);
        ps.setDouble(5,Double.parseDouble(price));
        ps.setInt(6,Integer.parseInt(stock));
        ps.setString(7,image);

        int i=ps.executeUpdate();

        if(i>0)
        {
            message="Product Added Successfully!";
        }
        else
        {
            message="Failed to Add Product!";
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

<title>Add Product</title>

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

input,select,textarea{
width:100%;
padding:12px;
margin:10px 0;
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
font-weight:bold;
color:green;
margin:10px;
}

</style>

</head>

<body>

<div class="container">

<h2>Add Product</h2>

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

<select name="subcategory_id" required>

<option value="">Select Subcategory</option>

<%
try
{
    Class.forName("com.mysql.cj.jdbc.Driver");

    Connection con=DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/shopkart",
    "root",
    "");

    Statement st=con.createStatement();

    ResultSet rs=st.executeQuery("SELECT * FROM subcategories");

    while(rs.next())
    {
%>

<option value="<%=rs.getInt("subcategory_id")%>">
<%=rs.getString("subcategory_name")%>
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
name="product_name"
placeholder="Enter Product Name"
required>

<textarea
name="description"
placeholder="Enter Product Description"
required></textarea>

<input
type="number"
step="0.01"
name="price"
placeholder="Enter Price"
required>

<input
type="number"
name="stock"
placeholder="Enter Stock Quantity"
required>

<input
type="text"
name="image"
placeholder="Enter Image Name (Example: shirt.jpg)"
required>

<button type="submit">

Add Product

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