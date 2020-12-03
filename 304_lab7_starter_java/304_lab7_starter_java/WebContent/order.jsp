<%@ page import="java.sql.*,java.util.Locale" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Map,java.math.BigDecimal" %>
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



		<% 
		// Get customer id
		String custId = request.getParameter("customerId");
		@SuppressWarnings({"unchecked"})
		HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
		
		if (custId == null || custId.equals(""))
			out.println("<h1>Invalid customer id.  Go back to the previous page and try again.</h1>");
		else if (productList == null)
			out.println("<h1>Your shopping cart is empty!</h1>");
		else
		{
			// Check if customer id is a number
			int num=-1;
			try
			{
				num = Integer.parseInt(custId);
			} 
			catch(Exception e)
			{
				out.println("<h1>Invalid customer id.  Go back to the previous page and try again.</h1>");
				return;
			}
				
			String sql = "SELECT customerId, firstName+' '+lastName FROM Customer WHERE customerId = ?";		
				
			String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
			String uid = "SA";
			String pw = "YourStrong@Passw0rd";
			NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
		
			try
			{	// Load driver class
				Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			}
			catch (java.lang.ClassNotFoundException e)
			{
				out.println("ClassNotFoundException: " +e);
			}
		
			try ( Connection con = DriverManager.getConnection(url, uid, pw);) 
			{
				PreparedStatement pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				ResultSet rst = pstmt.executeQuery();
				int orderId=0;
				String custName = "";
		
				if (!rst.next())
					out.println("<h1>Invalid customer id.  Go back to the previous page and try again.</h1>");
				else
				{	custName = rst.getString(2);
		
					// Enter order information into database
					sql = "INSERT INTO OrderSummary (customerId, totalAmount, orderDate) VALUES(?, 0, ?);";
		
					// Retrieve auto-generated key for orderId
					pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
					pstmt.setInt(1, num);
					pstmt.setTimestamp(2, new java.sql.Timestamp(new Date().getTime()));
					pstmt.executeUpdate();
					ResultSet keys = pstmt.getGeneratedKeys();
					keys.next();
					orderId = keys.getInt(1);
		
					out.println("<h1>Your Order Summary</h1>");
						out.println("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");
		
					double total =0;
					Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
					
					while (iterator.hasNext())
					{ 
						Map.Entry<String, ArrayList<Object>> entry = iterator.next();
						ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
						String productId = (String) product.get(0);
						out.print("<tr><td>"+productId+"</td>");
						out.print("<td>"+product.get(1)+"</td>");
						out.print("<td align=\"center\">"+product.get(3)+"</td>");
						String price = (String) product.get(2);
						double pr = Double.parseDouble(price.substring(1));
						int qty = ( (Integer)product.get(3)).intValue();
						out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
						   out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td></tr>");
						out.println("</tr>");
						total = total +pr*qty;
		
						sql = "INSERT INTO OrderProduct (orderId, productId, quantity, price) VALUES(?, ?, ?, ?)";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, orderId);
						pstmt.setInt(2, Integer.parseInt(productId));
						pstmt.setInt(3, qty);
						pstmt.setString(4, price);
						pstmt.executeUpdate();				
					}
					out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
								   +"<td aling=\"right\">"+currFormat.format(total)+"</td></tr>");
					out.println("</table>");
		
					// Update order total
					sql = "UPDATE OrderSummary SET totalAmount=? WHERE orderId=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setDouble(1, total);
					pstmt.setInt(2, orderId);			
					pstmt.executeUpdate();						
		
					out.println("<h1>Order completed.  Will be shipped soon...</h1>");
					out.println("<h1>Your order reference number is: "+orderId+"</h1>");
					out.println("<h1>Shipping to customer: "+custId+" Name: "+custName+"</h1>");
		
					out.println("<h2><a href=\"index.jsp\">Return to shopping</a></h2>");
					
					// Clear session variables (cart)
					session.setAttribute("productList", null);
				}
			}
			catch (SQLException ex)
			{ 	out.println(ex);
			}	
		}
		%>
<h2><a href="listprod.jsp?productName=">Continue Shopping</a></h2>
</BODY>
</HTML>

