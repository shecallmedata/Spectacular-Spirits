
<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
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

.footer {
  position: fixed;
  padding: 20px 10px;
  right: 0;
  bottom: 0;
  width: 20%;
  background-color: rgba(241, 112, 52, 0.5);
  color: blue;
  text-align:center;
}
	</style>
	<%@ include file="header.jsp" %>
	<body style="background: url(https://images3.alphacoders.com/252/thumb-1920-252185.jpg); background-size: 100%;">

		
	
		
	<hr />
	<div id="main-content"></div>
	
	
<hr />
<br/>
<table align="center"><th><h2 style="text-align: right">Order Information</h2></th></table>

<% 
//Note: Forces loading of SQL Server driver
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
try (Connection con=DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();)

{	String sql = "SELECT * FROM productinventory ORDER BY warehouseId ASC";	
	String sql2= "select productId, warehouseId, quantity, price from productinventory op where warehouseId=? order by productId asc";
	PreparedStatement ps = con.prepareStatement(sql2);
	ResultSet rst = stmt.executeQuery(sql);	
	NumberFormat currFormat = NumberFormat.getCurrencyInstance(new Locale("en", "US"));
	

	while (rst.next())
	{
		
		out.print("<T1><table border='1'>"+
			"<tr>"+
				"<th>Warehouse ID</th>"+
			"</tr>");


		int warehouseId= rst.getInt(1);
	
		out.print("<tr align='middle'>"+
					"<td>"+warehouseId+"</td>"+					
				 "</tr>");
		ps.setInt(1, warehouseId);
		ResultSet rst2 = ps.executeQuery();
		
		
		out.print("<tr>"+
						"<tr align='right'>" +
							"<td colspan='5'>" + 
							  "<table border='1'>" + 
						  "<tr>" +
						  "<th>Product ID</th>"+
						  "<th>Quantity</th>"+
						  "<th>Price Per Item</th>"+
					  " </tr>");
		while(rst2.next()){
			out.print("<tr>"+
						   "<td>"+rst2.getString(1)+"</td>"+
						   "<td>"+rst2.getString(3)+"</td>"+
						   "<td>"+currFormat.format(rst2.getDouble(4))+"</td>"+
					 " </tr>");
		}

	
		out.print("</table></td></tr>");

		out.print("<br>"+"</br>");
	}
	
	
	
}


catch (SQLException ex) 
{ 	out.println(ex); 
}


// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection

// Write query to retrieve all order summary records

// For each order in the ResultSet

	// Print out the order summary information
	// Write a query to retrieve the products in the order
	//   - Use a PreparedStatement as will repeat this query many times
	// For each product in the order
		// Write out product information 

// Close connection
%>
<h3 class="footer"><a href="listprod.jsp?productName=">Continue Shopping</a></h3>
</body>
</html>