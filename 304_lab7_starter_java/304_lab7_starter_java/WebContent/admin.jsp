<%@ page import="java.text.NumberFormat" %>
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
<body style="background: url(otherImages/distilley2.jpg); background-size: 115%;">

	
<hr />
<div id="main-content">
<br/>
<%@ include file="auth.jsp" %>
<%@ include file="jdbc.jsp" %>


<div id="main-content">
<table><th><h2 align="left">Administrator Sales Report by Day</h2></th></table>
<%
try{
    getConnection();

NumberFormat currFormat = NumberFormat.getCurrencyInstance(new Locale("en", "US"));
//String orderDate =(String)request.getParameter("orderDate");
// TODO: Write SQL query that prints out total order amount by day
String sql = "select year(orderDate),month(orderDate),day(orderDate), sum(totalAmount) from ordersummary group by year(orderDate), month(orderDate), day(orderDate)";
PreparedStatement ps = con.prepareStatement(sql);
ResultSet rst = ps.executeQuery();
out.println("<table><tr>"+
    "<th>"+"Order Date"+"</th>"+
    "<th>"+"Total Order Amount" +"</th></tr>");
while(rst.next()){
    out.println("<tr><td>"+rst.getString(1)+"-"+rst.getString(2)+"-"+rst.getString(3)+"-"+"</td><td>"+rst.getDouble(4)+"</td></tr>");
  
}
out.print("</table><br>");

out.println("<h2><a href=inventory.jsp>Click here to see inventory</a></h2>");
out.println("<h2><a href=index.jsp>Home</a></h2>");
}
catch (SQLException ex) { 	
	out.println(ex); 
}
finally {
    closeConnection();}
%>

</body>
</html>

