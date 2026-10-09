<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="java.sql.*" %>

<%@ include file="../includes/session.jsp" %>
<%@ include file="../includes/db.jsp" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>ShopKart - Manage Products</title>

    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/admin.css">

</head>

<body>

<%@ include file="../includes/header.jsp" %>

<%@ include file="../includes/navbar.jsp" %>


<div class="admin-container">

    <h2>Manage Products</h2>

    <div class="admin-actions">

        <a href="addProduct.jsp">
            <button type="button">Add Product</button>
        </a>

        <button type="button" onclick="history.back()">
            ← Back
        </button>

    </div>


    <%
    String message = request.getParameter("message");

    if(message != null && !message.trim().equals(""))
    {
    %>

        <div class="message">
            <%= message %>
        </div>

    <%
    }
    %>


    <div class="table-container">

        <table border="1">

            <tr>

                <th>Product ID</th>

                <th>Product Name</th>

                <th>Category ID</th>

                <th>Price</th>

                <th>Description</th>

                <th>Image</th>

                <th>Stock</th>

                <th>Action</th>

            </tr>


            <%

            try
            {

                Statement st = con.createStatement();

                ResultSet rs = st.executeQuery(
                    "SELECT * FROM products ORDER BY product_id DESC"
                );


                boolean found = false;


                while(rs.next())
                {

                    found = true;

            %>

            <tr>

                <td>
                    <%= rs.getInt("product_id") %>
                </td>


                <td>
                    <%= rs.getString("product_name") %>
                </td>


                <td>
                    <%= rs.getInt("category_id") %>
                </td>


                <td>
                    ₹<%= rs.getDouble("price") %>
                </td>


                <td>
                    <%= rs.getString("description") %>
                </td>


                <td>

                    <%
                    String image = rs.getString("image");

                    if(image != null && !image.trim().equals(""))
                    {
                    %>

                        <img src="../images/products/<%= image %>"
                             alt="Product"
                             width="80"
                             height="80">

                    <%
                    }
                    else
                    {
                    %>

                        No Image

                    <%
                    }
                    %>

                </td>


                <td>
                    <%= rs.getInt("stock") %>
                </td>


                <td>

                    <a href="editProduct.jsp?product_id=<%= rs.getInt("product_id") %>">
                        Edit
                    </a>

                    &nbsp; | &nbsp;

                    <a href="deleteProduct.jsp?product_id=<%= rs.getInt("product_id") %>"
                       onclick="return confirm('Are you sure you want to delete this product?');">
                        Delete
                    </a>

                </td>

            </tr>


            <%

                }


                if(!found)
                {

            %>

            <tr>

                <td colspan="8">
                    No products available.
                </td>

            </tr>

            <%

                }


                rs.close();
                st.close();

            }
            catch(Exception e)
            {

            %>

            <tr>

                <td colspan="8">

                    Database Error:
                    <%= e.getMessage() %>

                </td>

            </tr>

            <%

            }

            %>

        </table>

    </div>

</div>


<%@ include file="../includes/footer.jsp" %>


</body>

</html>