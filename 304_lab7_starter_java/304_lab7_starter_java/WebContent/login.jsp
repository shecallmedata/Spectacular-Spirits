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
<body style="background: url(otherImages/distilley2.jpg); ">
	<%@ include file="header.jsp" %>

<br>

	<table><tr><th><div align="right"><h1 style= "color: white">Please Login to System</h1></div></th></tr></table>

<%
// Print prior error login message if present
if (session.getAttribute("loginMessage") != null){
	out.println("<th><h4 style= 'color:white'>"+"Sorry, invalid login" +"<p>"+ session.getAttribute("loginMessage").toString()+"</p>"+"</h4></th></table>");
	//Object username=session.getAttribute("username");
	
	//out.print(request.setAttribute("username", "index.jsp"));

	
}
%>

<br><div align="right" style="margin-right: 38%;">
<table> 
<form name="MyForm" method=post action="validateLogin.jsp">
</div>
<tr>
	<td><div align="right"><font color= white face="Arial, Helvetica, sans-serif" size="4">Username:</font></div></td>
	<td><input type="text" name="username"  size=20 maxlength=20></td>
</tr>
<tr>
	<td><div align="right"><font color= white face="Arial, Helvetica, sans-serif" size="4">Password:</font></div></td>
	<td><input type="password" name="password" size=20 maxlength="20"></td>
</tr>
</table>
<br/>
<input style= "margin-left: 775px;"  type="submit" name="Submit2" value="Log In">
</form>

</body>
</html>

