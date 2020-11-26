<!DOCTYPE html>
<html>
<head>
<title>Login Screen</title>
</head>
<body style="background: url(otherImages/distilley2.jpg);">

<div style="margin:0 auto;text-align:center;display:inline">

<h2  style="color: white">Please Login to System</h2>

<%
// Print prior error login message if present
if (session.getAttribute("loginMessage") != null){
	out.println("Sorry, invalid login" +"<p>"+ session.getAttribute("loginMessage").toString()+"</p>");
	//Object username=session.getAttribute("username");
	
	//out.print(request.setAttribute("username", "index.jsp"));
}
else if(session.getAttribute("authenticatedUser")!= null){
	//String name = request.getParameter("name");
	session.getAttribute("authenticatedUser").toString();
	
}
%>

<br>
<form name="MyForm" method=post action="validateLogin.jsp">
<table style="display:inline">
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
<input class="submit" type="submit" name="Submit2" value="Log In">
</form>

</div>

</body>
</html>

