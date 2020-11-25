<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>

<%
// TODO: Include files auth.jsp and jdbc.jsp
%>
<%

// TODO: Write SQL query that prints out total order amount by day
String sql = "select sum(totalAmount), orderDate from ordersummary where orderDate= ? order by orderDate asc";
PreparedStatement ps = con.prepareStatement(sql);
ps.setString(1, orderDate);
ResultSet rst = ps.executeQuery();
try{
    getConnection();
String prodId = request.getParameter("id");

}
con.close();

catch (SQLException ex) { 	
	out.println(ex); 
}
%>

</body>
</html>

