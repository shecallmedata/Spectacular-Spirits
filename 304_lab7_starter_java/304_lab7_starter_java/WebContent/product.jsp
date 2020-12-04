<%@ page import="java.util.HashMap" %>
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
       
        align-items: left;
        background-color: rgba(241, 112, 52, 0.5);
        
}
 </style>
 


 <body style="background: url(otherImages/distilley2.jpg); background-size: 100%;">
    
<%@ include file="header.jsp" %>
<%@ include file="jdbc.jsp" %>
<%

// Get product name to search for
// TODO: Retrieve and display info for the product
// String productId = request.getParameter("productid");
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";

Connection con = DriverManager.getConnection(url, uid, pw);

try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " + e);
}


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
//String binaryImage =  "displayImage.jsp?id="+productId;

out.print("<br><table>"+
    "<th><h2>"+productName+"</h2></th>");
   // String imageUrl= rst.getString(4);

  
  if(productImageURL!=null) {
   out.print("<tr><td style='text-align:left;' class='pstyle;' colspan = 2><img style='height:250px; width: auto;' src=\""+productImageURL+"\"></td>");
   }

    if (productImageBinary!= null){
       out.print("<td style='text-align:left;' class='pstyle;' colspan = 2><img style='height:250px;width: 380px;' src=\"displayImage.jsp?id="+productId+"\"></td></tr>");

}
out.print("<tr>"+
    "<th>Id</th>"+
    "<th>Price</th>"+
"</tr>");

    out.print("<tbody><tr><td align='center'>"+productId+"</td><td>"+currFormat.format(productPrice)+"</td></tr>");
     
        out.print("<td colspan=\"2\"><h2><a href="+cartLink+">Add to Cart</a></h2></td>");
        out.print("<tr><td colspan=\"2\"><h2><a href=listprod.jsp>Continue Shopping</a></h2></td></tr></table>");
       
    }
    closeConnection();  





// TODO: If there is a productImageURL, display using IMG tag
		
// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
		
// TODO: Add links to Add to Cart and Continue Shopping
%>

</body>
</html>

