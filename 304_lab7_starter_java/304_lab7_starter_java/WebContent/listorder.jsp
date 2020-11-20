
<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html>
<head>
	<header style= "margin: 20px;
	padding: 40px;">


<title class="header">Spectacular Spirits Grocery Order List </title>
	
</head>
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
	<body style="background-color:aliceblue;">
	
<h1 class="header">Spectacular Spirits </h1>
<hr />
<br/>
<h2 style="text-align: center">Order Information</h2>

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

{	String sql = "select os.orderId, os.orderDate, ci.customerId, concat(ci.firstName, ' ' , ci.lastName), os.totalAmount from customer ci join ordersummary as os on ci.customerId = os.customerId";	
	String sql2= "select productId, quantity, price from orderproduct op where orderId=? order by productId asc";
	PreparedStatement ps = con.prepareStatement(sql2);
	ResultSet rst = stmt.executeQuery(sql);	
	NumberFormat currFormat = NumberFormat.getCurrencyInstance(new Locale("en", "US"));
	out.print("<T1><table border='1'>"+
		"<tr>"+
			"<th>order Id</th>"+
			"<th>order Date</th>"+
			"<th>Customer Id</th>"+
			"<th>Customer Name</th>"+
			"<th>Total Amount</th>"+
		"</tr>");

	while (rst.next())
	{	
		String ordId= rst.getString(1);
	
		out.print("<tr>"+
						"<td>"+ordId+"</td>"+
						"<td>"+rst.getString(2)+"</td>"+
						"<td>"+rst.getString(3)+"</td>"+
						"<td>"+rst.getString(4)+"</td>"+
						"<td>"+currFormat.format(Double.parseDouble(rst.getString(5)))+"</td>"+
					"</tr>");
		ps.setString(1, ordId);
		ResultSet rst2 = ps.executeQuery();
		
		
		out.print("<tr>"+
						"<tr align='right'>" +
							"<td colspan='5'>" + 
							  "<table border='1'>" + 
						  "<tr>" +
						  "<th>Product Id</th>"+
						  "<th>Quantity</th>"+
						  "<th>Price</th>"+
					  " </tr>");
		while(rst2.next()){
			out.print("<tr>"+
						   "<td>"+rst2.getString(1)+"</td>"+
						   "<td>"+rst2.getString(2)+"</td>"+
						   "<td>"+currFormat.format(rst2.getDouble(3))+"</td>"+
					 " </tr>");
		}
		out.print("</table></td></tr>");
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

