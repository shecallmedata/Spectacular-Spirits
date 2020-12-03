
<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>

		<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500&display=swap" rel="stylesheet">
		<link rel="stylesheet" type="text/css" href="stylesheet.css">
		<title>
		</title>
	</head>
	<%@ include file="header.jsp" %>
	<body style="background: url(https://bentwoodinn.com/wp-content/uploads/2017/02/wyoming-whiskey.jpg); ">

		
	
		
	<hr />
	<div id="main-content"></div>
<table><th><h1 style="color:white; font-size:20;">Enter your customer id and password to complete the transaction:</h1></th></table>

<style>
		table, th, td {
	background-color: rgba(241, 112, 52, 0.5);
}

  .footer {
  position: fixed;
  padding: 20px 10px;
  right: 0;
  bottom: 0;
  width: 20%;
  background-color:rgba(241, 112, 52, 0.5);
  color: black;
  text-align:center;
  text-decoration: none;
}
</style>
<body>

    <body>


 <div style="padding-top: 5px;">
</div>




<div style="padding: 20px;"></div>

<table><th><form name="MyForm" method=post action="order.jsp">
    <label>Customer Id:</label> <input type="text" name="customerId" size="30">

  
  <div style="padding: 2px;"></div>
  <form name="MyForm" method=post action="order.jsp">
<label>Password: &nbsp;&nbsp;&nbsp;&nbsp;</label> <input type="text" name="password" size="30">
<div style="padding: 2px;"></div>
<input type="Submit" value="Submit">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="Reset" value="Reset"></th></table>


</form>
<h3 class="footer"><a href="listprod.jsp?productName=">Continue Shopping</a></h3>
</body>
</html>