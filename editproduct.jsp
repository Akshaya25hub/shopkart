<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.sql.*"%>

<%
String admin=(String)session.getAttribute("admin");

if(admin==null)
{
    response.sendRedirect("adminlogin.jsp");
    return;
}

String pid=request.getParameter("product_id");

if(pid==null)
{
    out.println("Product not found");
    return;
}
%>
<%
String productName="";
String description="";
double price=0;
int stock=0;
String image="";

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/shopkart",
"root",
"ShopKart@1234");

PreparedStatement ps=con.prepareStatement(
"SELECT * FROM products WHERE product_id=?");

ps.setInt(1,Integer.parseInt(pid));

ResultSet rs=ps.executeQuery();

if(rs.next())
{
    productName=rs.getString("product_name");
    description=rs.getString("description");
    price=rs.getDouble("price");
    stock=rs.getInt("stock");
    image=rs.getString("image");
}
%>