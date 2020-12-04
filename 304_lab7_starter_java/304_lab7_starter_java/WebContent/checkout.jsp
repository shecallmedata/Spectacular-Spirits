
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
	<style>
		table, th, td {
	background-color: rgba(241, 112, 52, 0.5);
}
	</style>
	<%@ include file="header.jsp" %>
	<body style="background: url(https://www.luxurylifestylemag.co.uk/wp-content/uploads/2019/09/bigstock-Glass-Of-Whiskey-With-Natural-292232818.jpg); background-repeat: no-repeat; background-size: 100%;">

		
	
		
	<hr />
	<div id="main-content"></div>
<table><th><h1 style="color:black; font-size:20;">Enter your customer id and password to complete the transaction:</h1></th></table>

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
  <%
  String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
  String uid = "SA";
  String pw = "YourStrong@Passw0rd";
  try
  {    // Load driver class
      Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
  }
  catch (java.lang.ClassNotFoundException e)
  {
      out.println("ClassNotFoundException: " +e);
  }
  try (Connection con=DriverManager.getConnection(url, uid, pw); Statement stmt = con.createStatement();)
  {
    String userName = (String) session.getAttribute("authenticatedUser");
    userName = "\'"+userName+"\'";
    
    String sql = "SELECT customerId  FROM customer WHERE userid="+userName;
    PreparedStatement ps = con.prepareStatement(sql);
    ResultSet rst = ps.executeQuery();
    
    if(rst.next())  {
      out.print("<table><td class='pwelcome'><h2>"+"Your Customer Number is: "+rst.getString(1)+"</h2></td></table>");
    }
    
    } 
    catch (SQLException ex) 
    {     out.println(ex); 
    }
  %>


 
      <div style="padding-top: 5px;">
        <!-- <form method="get" action="order.jsp">
            <label>Customer Id:</label> <input type="text" name="customerId" size="30">
        </form> -->
        </div>
        
        <div style="padding: 20px;"></div>
        <table><td>
        <form name="MyForm" method=post action="order.jsp">
        <label>Customer Id:</label> <input type="text" name="customerId" size="30">
        <div style="padding: 2px;"></div>
        <label>Password: &nbsp;&nbsp;&nbsp;&nbsp;</label> <input type="password" name="pw" size="30">
        <div style="padding: 10px;"></div>
        <label>Name on Card:</label> <input type="text" name="cardName" size="30">
        <div style="padding: 2px;"></div>
        <label>Card Number:&nbsp;</label> <input type="password" name="cardNum" size="16">
        <div style="padding: 2px;"></div>
        <label>Expiration Date:</label> <input type="text" name="expDate" size="5">
        <label>CVV:</label> <input type="password" name="CVV" size="3">
        <div style="padding: 2px;"></div>
        
        
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="Submit" value="Submit">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="Reset" value="Reset">
      </td></table>
        
        </form>
        <h3 class="footer"><a href="listprod.jsp?productName=">Continue Shopping</a></h3>
        </body>
        </html>