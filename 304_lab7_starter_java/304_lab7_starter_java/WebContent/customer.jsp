<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>
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




<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%> 

<%

// TODO: Print Customer information
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}
try (Connection con=DriverManager.getConnection(url, uid, pw); Statement stmt = con.createStatement();)
{
	String sql = "SELECT customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid FROM customer WHERE userid=?";
	PreparedStatement ps = con.prepareStatement(sql);
	ps.setString(1, userName);
	ResultSet rst = ps.executeQuery();

	if(rst.next()){
    	out.print("<table border='1' colspan='5'><th colspan=\"2\"><h2>Customer Profile</h2></th>");
			
			out.print("<tr><th>Id</th>"+
				"<td>"+rst.getString(1)+"</td>"+
			"</tr>"+
        	
			"<th>First Name</th>"+
				"<td>"+rst.getString(2)+"</td>"+
			"</tr>"+
			
			"<th>Last Name</th>"+
				"<td>"+rst.getString(3)+"</td>"+
			"</tr>"+
			
			"<th>Email</th>"+
				"<td>"+rst.getString(4)+"</td>"+
			"</tr>"+
			
			"<th>Phone</th>"+ 
				"<td>"+rst.getString(5)+"</td>"+
			"</tr>"+
			
			"<th>Address</th>"+
				"<td>"+rst.getString(6)+"</td>"+
			"</tr>"+
			
			"<th>City</th>"+
				"<td>"+rst.getString(7)+"</td>"+
			"</tr>"+
			
			"<th>State</th>"+
				"<td>"+rst.getString(8)+"</td>"+
			"</tr>"+
			
			"<th>Postal Code</th>"+
				"<td>"+rst.getString(9)+"</td>"+
			"</tr>"+
			
			"<th>Country</th>"+
				"<td>"+rst.getString(10)+"</td>"+
			"</tr>"+
			
			"<th>User ID</th>"+
				"<td>"+rst.getString(11)+"</td>"+
			"</tr></thead><tbody>");
	}
	
}
catch (SQLException ex) 
{ 	out.println(ex); 
}
// Make sure to close connection
%>

</body>
</html>

