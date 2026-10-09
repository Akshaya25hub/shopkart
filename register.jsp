<%@ page import="java.sql.*" %>

<%
String message="";

if(request.getMethod().equalsIgnoreCase("POST"))
{
    String name=request.getParameter("name");
    String email=request.getParameter("email");
    String password=request.getParameter("password");
    String phone=request.getParameter("phone");
    String gender=request.getParameter("gender");
    String address=request.getParameter("address");
    String aadhaar=request.getParameter("aadhaar");
    String question=request.getParameter("question");
    String answer=request.getParameter("answer");

    try
    {
        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection con=DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/shopkart",
        "root",
        "ShopKart@1234");

        // Check whether email already exists
        PreparedStatement check=con.prepareStatement(
        "SELECT * FROM customers WHERE email=?");

        check.setString(1,email);

        ResultSet rs=check.executeQuery();

        if(rs.next())
        {
            message="Email already registered!";
        }
        else
        {
            PreparedStatement ps=con.prepareStatement(

            "INSERT INTO customers(name,email,password,phone,address,aadhaar,security_question,security_answer,gender) VALUES(?,?,?,?,?,?,?,?,?)"

            );

            ps.setString(1,name);
            ps.setString(2,email);
            ps.setString(3,password);
            ps.setString(4,phone);
            ps.setString(5,address);
            ps.setString(6,aadhaar);
            ps.setString(7,question);
            ps.setString(8,answer);
            ps.setString(9,gender);

            int i=ps.executeUpdate();

            if(i>0)
            {
                message="Registration Successful!";
            }
            else
            {
                message="Registration Failed!";
            }

            ps.close();
        }

        rs.close();
        check.close();
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

<title>Customer Registration</title>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:Arial;
}

body{
background:linear-gradient(to right,#2193b0,#6dd5ed);
display:flex;
justify-content:center;
align-items:center;
min-height:100vh;
padding:30px;
}

.container{
background:white;
width:500px;
padding:30px;
border-radius:15px;
box-shadow:0px 0px 15px gray;
}

.container h2{
text-align:center;
margin-bottom:20px;
color:#1565C0;
}

input,textarea,select{
width:100%;
padding:12px;
margin:10px 0;
border:1px solid #ccc;
border-radius:5px;
font-size:15px;
}

.gender{
margin:10px 0;
}

.gender label{
font-weight:bold;
margin-right:15px;
}

.gender input{
width:auto;
margin-right:5px;
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
margin-bottom:15px;
font-weight:bold;
color:green;
}

a{
text-decoration:none;
color:#1565C0;
font-weight:bold;
}

</style>

</head>

<body>

<div class="container">

<h2>Customer Registration</h2>

<div class="msg">
<%=message%>
</div>

<form method="post">

<input
type="text"
name="name"
placeholder="Enter Full Name"
required>

<input
type="email"
name="email"
placeholder="Enter Email"
required>

<input
type="password"
name="password"
placeholder="Enter Password"
required>

<input
type="text"
name="phone"
placeholder="Enter Mobile Number"
maxlength="10"
pattern="[0-9]{10}"
required>

<div class="gender">

<label>Gender :</label>

<input
type="radio"
name="gender"
value="Male"
required> Male

<input
type="radio"
name="gender"
value="Female"> Female

</div>

<textarea
name="address"
placeholder="Enter Address"
required></textarea>

<input
type="text"
name="aadhaar"
placeholder="Enter 12 Digit Aadhaar Number"
maxlength="12"
pattern="[0-9]{12}"
required>

<select
name="question"
required>

<option value="">Select Security Question</option>

<option>What is your favourite pet's name?</option>

<option>What is your favourite teacher's name?</option>

<option>What is your birth city?</option>

<option>What is your favourite colour?</option>

<option>What is your favourite food?</option>

</select>

<input
type="text"
name="answer"
placeholder="Enter Security Answer"
required>

<button type="submit">

Register

</button>

</form>

<br>

<center>

Already have an account?

<a href="login.jsp">

Login

</a>

</center>

</div>

</body>
</html>