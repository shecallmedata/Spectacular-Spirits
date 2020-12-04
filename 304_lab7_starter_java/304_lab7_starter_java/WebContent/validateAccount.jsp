<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>
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

try{
    getConnection();
    String firstName= request.getParameter("firstName");
    String lastName= request.getParameter("lastName");
    String email= request.getParameter("email");
    String phoneNum= request.getParameter("phoneNum");
    String address= request.getParameter("address");
    String city= request.getParameter("city");
    String state= request.getParameter("state");
    String postalCode= request.getParameter("postalCode");
    String country= request.getParameter("country");
    String username= request.getParameter("user");
    String password= request.getParameter("pw");
    String sql= "select * from customer where userId = ?";
    PreparedStatement ps= con.prepareStatement(sql);
    ps.setString(1, username);
    ResultSet rst = ps.executeQuery();
    out.print("<table>");
    if(rst.next()){
        out.print("<tr><td><h2>Sorry, "+username+" already exists</h2></td></tr><br><tr><td><h2>please try again</h2></td></tr>");
        %>
        <br>
    <tr><td><h2><a href="createAccount.jsp">Back to Create Account Page</a></h2></td></tr>
        <%
        return;
    } else if(firstName== null || firstName.equals("") || lastName== null || lastName.equals("") || 
    phoneNum== null || phoneNum.equals("") || address== null || address.equals("") ||
     city== null || city.equals("") || state== null || state.equals("") ||
     postalCode== null || postalCode.equals("") || country== null || country.equals("") || username== null || 
     username.equals("") || password== null || password.equals("") ){
        out.print("<tr><td><h2>Sorry, missing fields</h2></td></tr><br><tr><td><h2>Please go back and enter all of the fields</h2></td></tr>");
        %>
        <br>
    <tr><td><h2><a href="createAccount.jsp">Back to Create Account Page</a></h2></td></tr>
        <%
    
    } else if(email == null || !email.contains("@")){
        out.print("<tr><td><h2>Sorry, invalid email</h2></td></tr><br><tr><td><h2>Please go back and enter a valid email</h2></td></tr>");
        %> 
    <tr><td><h2><a href="createAccount.jsp">Back to Create Account Page</a></h2></td></tr>
        <%
        return;
    
    } else {
        String sql2 = "insert into customer values (?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement ps2 = con.prepareStatement(sql2);
        ps2.setString(1, firstName);
        ps2.setString(2, lastName);
        ps2.setString(3, email);
        ps2.setString(4, phoneNum);
        ps2.setString(5, address);
        ps2.setString(6, city);
        ps2.setString(7, state);
        ps2.setString(8, postalCode);
        ps2.setString(9, country);
        ps2.setString(10, username);
        ps2.setString(11, password);
        ps2.executeUpdate();
        String sql3 = "select customerId from customer where userid=?";
        PreparedStatement ps3 = con.prepareStatement(sql3);
        ps3.setString(1, username);
        ResultSet rst3 = ps3.executeQuery();
        rst3.next();
        Integer custId = rst3.getInt("customerId");
        out.println("<tr><td><h2>Your account "+username+ " has been created</h2></td></tr>");
        out.println("<tr><td><h2>Your Customer Id is : "+custId+"</h2></td></tr>");
        %>
        <br>
    <tr><td><h2><a href="login.jsp">Click here to login.</a></h2></td></tr>
        <%
    }
    out.print("</table>");
}

catch (SQLException ex) { 	
	out.println(ex); 
}


%> 
</div>>
</body>
</html>