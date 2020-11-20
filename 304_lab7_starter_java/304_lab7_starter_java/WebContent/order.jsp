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
</head>
<h2 class="header">Spectacular Spirits</h2>


<style>
	.header {
	 overflow: hidden;
	 background-color: powderblue ;
	 padding: 20px 10px;
	 text-align: center;
	 font-family: serif;
	 color: rgb(1, 1, 39);
   }
   .pstyle{
	   font-size: large
	   font-weight: bold;
   }
 </style>
 
	 <body style="color:rgb(1, 1, 39);font-size:20px; background-color:aliceblue;">

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
	out.println("<h2>Your Order Summary</h2>");
	out.print("<table><thead><tr>"+
		"<th>Product Id</th>"+
		"<th>Product Name</th>"+
		"<th>Quantity</th>"+
		"<th>Price</th>"+
		"<th>Subtotal</th>"+
	"</tr></thead><tbody>");
	
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
		"<td>"+"Total:"+"</td>"+
		"<td>"+currFormat.format(total)+"</td>"+
		"</tr></tbody></table>");
	
	out.print(" <strong>Order completed. Will be shipped soon... <div></div> order reference number is: "+orderId+" <div></div>Shipping to Customer Name: "+rst.getString(3)+"</strong>");
	//out.print("</div>");
	
	productList.clear();
	session.invalidate();
	// Head back to homepage after 15 seconds
	//response.setHeader("Refresh", "15;url=shop.html");

}
else{
	out.println("<h2>Your Order Summary</h2>");
	
	//out.print("<div>");
	out.print("<strong>Invalid customer ID or empty cart.</strong>");
	//out.print("</div>");
	
	//clear product list and end session
	if(productList!=null){productList.clear();}
	session.invalidate();
}
con.close();
} 
catch (SQLException ex) 
{ 
	out.print("<div>");
		out.print("<strong>Invalid customer ID or empty cart.</strong>");
		out.print("</div>");
} 



%>
<h2><a href="listprod.jsp?productName=">Continue Shopping</a></h2>
</BODY>
</HTML>

