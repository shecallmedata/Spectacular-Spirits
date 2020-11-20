<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html>
<head>
	<style>
		.table {
			margin: 0 auto;
		}
	
		.pcolor {
			text-align: center;
			color: rgb(103, 82, 255);
		}
		.pimage {
			float: right;
  display: block;
  margin-left: 15px;
  margin-right: 15px;
  width: 45%;
  height: 45%;
}
   .header {
    overflow: hidden;
    background-color: powderblue ;
    padding: 20px 10px;
    text-align: center;
    font-family: serif;
	color:rgb(1, 1, 39);
  }
  .pcaption{
	padding: 20px;


  }

		</style>
		<head>
			<header style= "margin: 20px;
			padding: 40px;">
		
		


</head>
<h2 class="header">Spectacular Spirits</h2>
<body>
<figure>
<img src="lahey2.jpg"  width="491" height="363" class="pimage">
</figure>
    <body style="color:rgb(1, 1, 39);font-size:20px; background-color:aliceblue;">
</head>
<body>

<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null)
{	out.println("<H1>Your shopping cart is empty!</H1>");
	productList = new HashMap<String, ArrayList<Object>>();
}
else
{
	NumberFormat currFormat = NumberFormat.getCurrencyInstance(new Locale("en", "US"));
	out.println("<h1>Your Shopping Cart</h1>");
	out.print("<table><tr><th class=\"pcolor\">Product Id</th><th class=\"pcolor\">Product Name</th><th class=\"pcolor\">Quantity</th>");
	out.println("<th class=\"pcolor\">Price</th><th class=\"pcolor\">Subtotal</th></tr>");

	double total =0;
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext()) 
	{	Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		if (product.size() < 4)
		{
			out.println("Expected product with four entries. Got: "+product);
			continue;
		}
		
		out.print("<tr><td>"+product.get(0)+"</td>");
		out.print("<td>"+product.get(1)+"</td>");

		out.print("<td align=\"center\">"+product.get(3)+"</td>");
		Object price = product.get(2);
		Object itemqty = product.get(3);
		double pr = 0;
		int qty = 0;
		
		try
		{
			pr = Double.parseDouble(price.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid price for product: "+product.get(0)+" price: "+price);
		}
		try
		{
			qty = Integer.parseInt(itemqty.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid quantity for product: "+product.get(0)+" quantity: "+qty);
		}		

		out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
		out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td></tr>");
		out.println("</tr>");
		total = total +pr*qty;
	}
	out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
			+"<td align=\"right\">"+currFormat.format(total)+"</td></tr>");
	out.println("</table>");

	out.println("<h2><a href=\"checkout.jsp\">Check Out</a></h2>");
}
%>
<h2><a href="listprod.jsp?productName=">Continue Shopping</a></h2>
</body>
</html> 

