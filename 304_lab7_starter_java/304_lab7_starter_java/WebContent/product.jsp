<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.util.Locale" %>

<html>
<head>
    <h2 class="header">Spectacular Spirits</h2>
<title>Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>



<style>
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
	 color: rgb(1, 1, 39);
   }
   .pstyle{
	   font-size: large
	   font-weight: bold;
   }
    .alnright { text-align: right; }
 </style>
 
	 <body style="color:rgb(1, 1, 39);font-size:20px; background-color:aliceblue;">

<body>

<%@ include file="header.jsp" %>

<%
// Get product name to search for
// TODO: Retrieve and display info for the product
// String productId = request.getParameter("productid");

try{
    getConnection();
String prodId = request.getParameter("id");
String sql = "select * from product where productId=? ";

PreparedStatement ps = con.prepareStatement(sql);
ps.setString(1, prodId);
ResultSet rst = ps.executeQuery();
NumberFormat currFormat = NumberFormat.getCurrencyInstance(new Locale("en", "US"));


while(rst.next()){
String productId= rst.getString(1);
String productName= rst.getString(2);
Double productPrice = rst.getDouble(3);
String productImageURL= rst.getString(4);
String productImageBinary=rst.getString(5);
String pnameEncoded = java.net.URLEncoder.encode(productName,"UTF-8").replace("+","%20");
String cartLink = "addcart.jsp?id="+productId+"&name="+pnameEncoded+"&price="+productPrice;
String binaryImage =  "displayImage.jsp?id="+productId;

out.print("<table>"+
    "<th><h2>"+productName+"</h2></th>"+
    "<tr><td style='text-align:center;' class='pstyle;' colspan = 2><img style='height:auto; width: auto;' src=\""+productImageURL+"\"></td>"+
        "<td style='text-align:center;' class='pstyle;' colspan = 2><img style='height:auto; width: auto;' src=\"binaryImage\"></td></tr>"+
"<tr>"+
        "<th>Id</th>"+
        "<th>Price</th>"+
    "</tr>");

    out.print("<tbody><tr><td align='center'>"+productId+"</td><td>"+currFormat.format(productPrice)+"</td></tr>");


out.print("</tbody></table>");
out.print("<h2><a href="+cartLink+">Add to Cart</a></h2>");
out.print("<h2><a href=listprod.jsp>Continue Shopping</a></h2>");
    }
con.close();

}
catch (SQLException ex) { 	
	out.println(ex); 
}
// TODO: If there is a productImageURL, display using IMG tag
		
// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
		
// TODO: Add links to Add to Cart and Continue Shopping
%>

</body>
</html>

