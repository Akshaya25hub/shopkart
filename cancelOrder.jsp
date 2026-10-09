<%@ page import="java.sql.*" %>

<%
String order_id=request.getParameter("order_id");
out.println("Order ID = " + order_id);

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/shopkart",
"root",
"ShopKart@1234");

PreparedStatement ps=con.prepareStatement(
"UPDATE orders SET status='Cancelled' WHERE order_id=?");
if(order_id==null)
{
    out.println("Order ID not received");
    return;
}

ps.setInt(1,Integer.parseInt(order_id));

ps.executeUpdate();

con.close();

response.sendRedirect("orders.jsp");
%>