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
div{
	text-emphasis-color:white;
	color:white;
}
	</style>
	<%@ include file="header.jsp" %>
	<body style="background: url(https://www.luxurylifestylemag.co.uk/wp-content/uploads/2019/09/bigstock-Glass-Of-Whiskey-With-Natural-292232818.jpg); background-repeat: no-repeat; background-size: 100%;">

		
	
		
	<hr />
	<div id="main-content"></div>
<% 
// Get customer id
String custId = request.getParameter("customerId");
//int numcustId = Integer.parseInt(request.getParameter("customerId"));
//Integer numcustId = Integer.valueOf(custId);
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
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
	try (Connection con=DriverManager.getConnection(url, uid, pw);){
	String sql = "SELECT * FROM Customer WHERE customerId= ?";
    PreparedStatement ps = con.prepareStatement(sql);
    ps.setString(1, custId);
    ResultSet rst = ps.executeQuery();
 // Determine if there are products in the shopping cart
 // If either are not true, display an error message
 NumberFormat currFormat = NumberFormat.getCurrencyInstance(new Locale("en", "US"));

 out.print("<table>");
	 if(rst.next() & productList!=null){
    	
		
    	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
    	
    	// Save order information to database in Order table. Use retrieval of auto-generated keys to generate OrderID.
    	// Total is saved as zero and update after iterating through order
		String insertSQL = ("INSERT into ordersummary (totalAmount, customerId) VALUES (?, ?)");
		PreparedStatement ps2 = con.prepareStatement(insertSQL, Statement.RETURN_GENERATED_KEYS);	
		ps2.setDouble(1, 0.0);
		ps2.setString(2, custId);
		

		ps2.executeUpdate();
	ResultSet keys = ps2.getGeneratedKeys();
	keys.next();
	int orderId = keys.getInt(1);
	double total=0.0;
	out.println("<tr><th colspan=\"5\"><h2>Your Order Summary</h2></th></tr>");
	out.print("<tr>"+
		"<th>Product Id</th>"+
		"<th>Product Name</th>"+
		"<th>Quantity</th>"+
		"<th>Price</th>"+
		"<th>Subtotal</th>"+
	"</tr>");
	
	while (iterator.hasNext())
	{ 
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		String productId = (String) product.get(0);
		String productName = (String) product.get(1);
		String price = (String) product.get(2);
		double pr = Double.parseDouble(price);
		int pid = Integer.parseInt(productId);
		int qty = ( (Integer)product.get(3)).intValue();
		double subtotal = (pr*qty);
		
		total += subtotal;
		
		out.print("<tr>"+
						"<td>"+productId+"</td>"+
						"<td>"+productName+"</td>"+
						"<td>"+qty+"</td>"+
						"<td>"+currFormat.format(pr)+"</td>"+
						"<td>"+currFormat.format(subtotal)+"</td>"+
					"</tr>");	
		
		// Insert each item into orderproduct table using OrderId from previous INSERT
		String insertOrderProductSQL = "INSERT Orderproduct (orderId, productId, quantity, price) VALUES(?, ?, ?, ?)";
		PreparedStatement pstInsertOP = con.prepareStatement(insertOrderProductSQL);
		pstInsertOP.setInt(1, orderId);
		pstInsertOP.setInt(2, pid);
		pstInsertOP.setInt(3, qty);
		pstInsertOP.setDouble(4, pr);
		
		pstInsertOP.executeUpdate();
		
	}
		
	// Update total amount for order record
	String updateTotalSQL = "UPDATE ordersummary SET totalAmount = ? WHERE orderId = ?";
	PreparedStatement pstUpdateTotal = con.prepareStatement(updateTotalSQL);
	pstUpdateTotal.setDouble(1, total);
	pstUpdateTotal.setInt(2, orderId);
	pstUpdateTotal.executeUpdate();
	
	
	//order summary
	out.print("<tr>"+
		"<td>"+"Subtotal:"+"</td>"+
		"<td>"+currFormat.format(total)+"</td>"+
		"</tr>");
	
		String stateQuery = "SELECT state FROM customer WHERE customerId=?";
		PreparedStatement pstState = con.prepareStatement(stateQuery);
		pstState.setString(1, custId);
		ResultSet stateRst = pstState.executeQuery();
	
		String userState = "AB";
		if(stateRst.next()){
			userState = stateRst.getString(1);
		}
	
		String shipInfo = "SELECT tax, shipCost FROM shipping WHERE state = ?";
		PreparedStatement pship = con.prepareStatement(shipInfo);
		pship.setString(1, userState);
		ResultSet shipRst = pship.executeQuery();
		
		double tax = 0;
		double shipping = 0;
	
		if(shipRst.next()){
			tax = shipRst.getDouble(1);
			shipping = shipRst.getDouble(2);
		}
	
		
		out.print("<tr>"+
				"<td>Shipping:</td>"+
				"<td>"+currFormat.format(shipping)+"</td>"+
				"</tr>");

		out.print("<tr>"+
					"<td>"+"Taxes:"+"</td>"+
					"<td>"+currFormat.format(total*tax-total)+"</td>"+
					"</tr>");	
		
				total = total*tax + shipping;
	
		out.print("<tr>"+
					"<td><strong>"+"Total:"+"</strong></td>"+
					"<td>"+currFormat.format(total)+"</td>"+
					"</tr></tbody></table>");
	
	
	
	out.print(" <div><strong>Order completed. Will be shipped soon... <div></div> Order reference number is: "+orderId+" <div></div>Shipping to Customer Id: "+rst.getString(1)+" Name: "+rst.getString(2)+" "+rst.getString(3)+"</strong></div>");
	//out.print("</div>");
	
	productList.clear();
	session.invalidate();
	// Head back to homepage after 15 seconds
	//response.setHeader("Refresh", "15;url=shop.html");

}
else{





		
	out.println("<div><h2>Your Order Summary</h2></div>");
	
	//out.print("<div>");
	out.print("<div><strong>Invalid customer ID or empty cart.</strong></div>");
	//out.print("</div>");
	
	//clear product list and end session
	if(productList!=null){productList.clear();}
	session.invalidate();
}
con.close();
} 
//catch (SQLException ex) 
//{ 
//	out.print("<div>");
//		out.print("<div></div><strong>Invalid customer ID or empty cart.</strong></div>");
//		out.print("</div>");
//} 



	

%>
<h2><a href="listprod.jsp?productName=">Continue Shopping</a></h2>
</BODY>
</HTML>