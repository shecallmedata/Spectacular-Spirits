
<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
 <title><h2>Spirits</h2> </title>
</head>
<h2 class="header">Spectacular Spirits</h2>
<h3>Checkout Line</h3>
<h1 style="color:rgb(1, 1, 39); font-size:20;">Enter your customer id and password to complete the transaction:</h1>

<style>
   .header {
    overflow: hidden;
    background-color: powderblue ;
    padding: 20px 10px;
    text-align: center;
    font-family: serif;
    color: rgb(1, 1, 39);
  }
  .footer {
  position: fixed;
  padding: 20px 10px;
  right: 0;
  bottom: 0;
  width: 20%;
  background-color: powderblue ;
  color: blue;
  text-align:center;
  }
</style>
<body>

    <body style="color:rgb(1, 1, 39);font-size:20px; background-color:aliceblue;">


 <div style="padding-top: 5px;">
<!-- <form method="get" action="order.jsp">
    <label>Customer Id:</label> <input type="text" name="customerId" size="30">
</form> -->
</div>




<div style="padding: 20px;"></div>

<form name="MyForm" method=post action="order.jsp">
    <label>Customer Id:</label> <input type="text" name="customerId" size="30">

  
  <div style="padding: 2px;"></div>
<label>Password: &nbsp;&nbsp;&nbsp;&nbsp;</label> <input type="password" placeholder="Password" name="pw" size="30">
<div style="padding: 2px;"></div>
<input type="Submit" value="Submit">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="Reset" value="Reset">


</form>
<h3 class="footer"><a href="listprod.jsp?productName=">Continue Shopping</a></h3>
</body>
</html>