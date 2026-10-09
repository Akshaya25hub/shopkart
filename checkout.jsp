<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<%
String username = (String)session.getAttribute("username");
Integer customer_id = (Integer)session.getAttribute("customer_id");

if(username == null || customer_id == null)
{
    response.sendRedirect("login.jsp");
    return;
}

String product_id = request.getParameter("product_id");

if(product_id == null)
{
    out.println("Product not selected");
    return;
}
String productName = "";
double price = 0;

try
{
    Class.forName("com.mysql.cj.jdbc.Driver");

    Connection con = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/shopkart",
    "root",
    "ShopKart@1234");

    PreparedStatement ps = con.prepareStatement(
    "SELECT * FROM products WHERE product_id=?");

    ps.setInt(1,Integer.parseInt(product_id));

    ResultSet rs = ps.executeQuery();

    if(rs.next())
    {
        productName = rs.getString("product_name");
        price = rs.getDouble("price");
    }

    con.close();

}
catch(Exception e)
{
    out.println(e);
}
%>


<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Checkout</title>

<style>

body{
font-family:Arial;
background:#f2f2f2;
}

.container{
width:450px;
margin:50px auto;
background:white;
padding:30px;
border-radius:10px;
box-shadow:0 0 10px gray;
}

h2{
text-align:center;
color:#1565C0;
}

input,select,textarea{
width:100%;
padding:12px;
margin:10px 0;
border-radius:5px;
border:1px solid #ccc;
}

button{
width:100%;
padding:12px;
background:#1565C0;
color:white;
border:none;
border-radius:5px;
font-size:18px;
}

</style>

</head>

<body>

<div class="container">

<h2>Checkout</h2>

<form method="post">

<input type="text" value="<%=productName%>" readonly>

<input type="text" value="₹ <%=price%>" readonly>

<input type="hidden" name="product_id" value="<%=product_id%>">

<input type="text" name="address" placeholder="Delivery Address" required>

<input type="text" name="mobile" placeholder="Mobile Number" required>

<select name="payment" required>

<option>Select Payment Method</option>
<option>Cash on Delivery</option>
<option>UPI</option>
<option>Card</option>

</select>

<button type="submit">
Place Order
</button>

</form> 
<%

if(request.getMethod().equalsIgnoreCase("POST"))
{

String pid=request.getParameter("product_id");
String address=request.getParameter("address");
String mobile=request.getParameter("mobile");
String payment=request.getParameter("payment");


try
{

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/shopkart",
"root",
"ShopKart@1234");


PreparedStatement ps1=con.prepareStatement(
"SELECT price FROM products WHERE product_id=?");

ps1.setInt(1,Integer.parseInt(pid));

ResultSet rs1=ps1.executeQuery();

double amount=0;

if(rs1.next())
{
    amount=rs1.getDouble("price");
}


PreparedStatement ps=con.prepareStatement(
"INSERT INTO orders(customer_id,total_amount,status) VALUES(?,?,?)",
Statement.RETURN_GENERATED_KEYS
);

ps.setInt(1,customer_id);
ps.setDouble(2,amount);
ps.setString(3,"Placed");

ps.executeUpdate();


ResultSet key = ps.getGeneratedKeys();

int order_id=0;

if(key.next())
{
    order_id=key.getInt(1);
}


PreparedStatement ps2=con.prepareStatement(
"INSERT INTO order_items(order_id,product_id,quantity) VALUES(?,?,?)"
);

ps2.setInt(1,order_id);
ps2.setInt(2,Integer.parseInt(pid));
ps2.setInt(3,1);

ps2.executeUpdate();


con.close();


%>

<h2 style="color:green;text-align:center;">
✅ Order Placed Successfully!
</h2>

<center>

<a href="orders.jsp">

View My Orders

</a>

</center>


<%

}
catch(Exception e)
{
out.println(e);
}

}

%>


</div>

</body>

</html>