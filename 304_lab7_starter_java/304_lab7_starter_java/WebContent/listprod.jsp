<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html>
<head>
	<header style= "margin: 20px;
	padding: 40px;">

<title class= "header">Spectacular Spirits Grocery Order List <color> </color:></title>
	
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
</style>
<body>
	
	<body style="background-color:aliceblue;">
	
<h1 class= "header">Spectacular Spirits </h1>
<hr />
<br/>
<h2 style="text-align: center">Search for the products you want to buy:</h2>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)

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

			


			out.print("<tr>"+
				"<td><a href="+cartLink+">Add to Cart</a></td>"+
				"<td>"+pname+"</td>"+
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

</body>
</html>