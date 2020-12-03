<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html>
	<link rel="stylesheet" type="text/css" href="stylesheet.css" />
		<style>
			.ptext{
				font-family: sans-serif;
				font-weight: 700;
				font-size: 13px;
			}
			table, th, td {
	background-color: rgba(241, 112, 52, 0.5);
}
			.footer {
			  position: fixed;
			  padding: 5px 5px;
			  right: 0;
			  bottom: 0;
			  width: 10%;
			  background-color:rgba(241, 112, 52, 0.5);
			  color: black;
			  text-align:center;
			  text-decoration: none;
			}
			
			</style>
		<body style="background: url(otherImages/ontherox.jpg); ">
		
		<%@ include file="jdbc.jsp" %>
		<%@ include file="header.jsp" %>
		
		


		<div id="main-content">
	

<hr />
<br/>

<table><th><h2>Search For a Product</h2></th></table>
<form  method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"><div style="color:white">(Leave blank for all products)</div> 

</form>

<% 

// Variable name now contains the search string the user entered
String name = request.getParameter("productName");
		

//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
try(Connection con=DriverManager.getConnection(url, uid, pw);)
{	
	String sql = "SELECT productId, productName, productDesc, productPrice FROM product WHERE productName LIKE ?";
	PreparedStatement ps = con.prepareStatement(sql);

	
	
	
	ps.setString(1, "%"+ name+ "%");
	
	ResultSet rst = ps.executeQuery();
	boolean generaldisplay=true;
	NumberFormat currFormat = NumberFormat.getCurrencyInstance(new Locale("en", "US"));
	
	
		out.print("<br><br><table>"+
					"<thead><tr>"+
						"<th>Add to cart</th>"+
						"<th>Product Name</th>"+
						"<th>Product Description</th>"+
						"<th>Price</th>"+
					"</tr></thead><tbody>");
			
		while(rst.next()){
			String pid= rst.getString(1);
			String pname = rst.getString(2);
			String pdesc = rst.getString(3);
			Double price = rst.getDouble(4);


			// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
			String pnameEncoded = java.net.URLEncoder.encode(pname,"UTF-8").replace("+","%20");
			String cartLink = "addcart.jsp?id="+pid+"&name="+pnameEncoded+"&price="+price;

			String productLink = "product.jsp?id="+pid+"&name="+pnameEncoded+"&price="+price;


			out.print("<tr>"+
				"<td><a href="+cartLink+">Add to Cart</a></td>"+ 
				"<td><a href="+productLink+">"+pname+"</a></td>"+
				"<td>"+pdesc+"</td>"+
				"<td>"+currFormat.format(price)+"</td>"+
			  "</tr>");
	
}
out.print("</tbody></table></div>");

con.close();


} catch (SQLException e){
    System.out.println(e);
} 





// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection

// Print out the ResultSet

// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
// Close connection

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>
<h3 class="footer"><a href=index.jsp >Home</a></h3>
</body>
</html>