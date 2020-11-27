// TODO: Include files auth.jsp and jdbc.jsp
<%@ page import="java.util.Locale" %>
<%@ include file="jdbc.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>
   
<%

%>
<%
try{
    getConnection();

//NumberFormat currFormat = NumberFormat.getCurrencyInstance(new Locale("en", "US"));
//String orderDate =(String)request.getParameter("orderDate");
// TODO: Write SQL query that prints out total order amount by day
String sql = "select orderDate,sum(totalAmount)as total from ordersummary group by orderDate order by orderDate asc";
PreparedStatement ps = con.prepareStatement(sql);
ResultSet rst = ps.executeQuery();
out.println("<table><tr>"+
    "<th>"+"Order Date"+"</th>"+
    "<th>"+"Total Order Amount"+"</th></tr>");
while(rst.next()){
    out.println("<tr><td>"+rst.getDate(1)+"</td><td>"+(rst.getDouble(2))+"</td></tr>");
  
}
out.println("</table><br>");
}
catch (SQLException ex) { 	
	out.println(ex); 
}
finally {
    closeConnection();}
%>

</body>
</html>

