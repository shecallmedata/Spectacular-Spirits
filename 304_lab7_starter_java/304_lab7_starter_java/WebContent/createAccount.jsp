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
    out.println("<table><th><h2>Please fill in the required fields </h2></th></table><br>");
    %>
    <form name="MyForm" method=post action="validateAccount.jsp">
        <table>
            <tr>
                <td><div align="left">First Name:</div></td>
                <td><input type="text" name="firstName" placeholder="Name" size=30 maxlength=15></td>
            </tr>
            <tr>
                <td><div align="left">Last Name:</div></td>
                <td><input type="text" name="lastName" placeholder="Last Name" size=30 maxlength="20"></td>
            </tr>
            <tr>
                <td><div align="left">Email:</div></td>
                <td><input type="text" name="email" placeholder="spectacularspirits69@hotmail.com" size=30 maxlength="30"></td>
            </tr>
            <tr>
                <td><div align="left">Phone Number:</div></td>
                <td><input type="text" name="phoneNum" placeholder="X-XXX-XXX-XXXX" size=30 maxlength="20"></td>
            </tr>
            <tr>
                <td><div align="left">Address:</div></td>
                <td><input type="text" name="address" placeholder="123 Spectacular Bv" size=30 maxlength="25"></td>
            </tr>
            <tr>
                <td><div align="left">City:</div></td>
                <td><input type="text" name="city" placeholder="Kelowna" size=30 maxlength="20"></td>
            </tr>
            <tr>
                <td><div align="left">Province/State:</div></td>
                <td><input type="text" name="state" placeholder="BC" size=30 maxlength="2"></td>
            </tr>
            <tr>
                <td><div align="left">Postal Code:</div></td>
                <td><input type="text" name="postalCode" placeholder="XXX-XXX" size=30 maxlength="7"></td>
            </tr>
            <tr>
                <td><div align="left">Country:</div></td>
                <td><input type="text" name="country" placeholder="Canada" size=30 maxlength="20"></td>
            </tr>
            <tr>
                <td><div align="left">Username:</div></td>
                <td><input type="text" name="user" placeholder="Enter a Username..." size=30 maxlength=20></td>
            </tr>
            <tr>
                <td><div align="left">Password:</div></td>
                <td><input type="password" name="pw" placeholder="Enter a Password..." size=30 maxlength="20"></td>
            </tr>
            </table>
<br/>
<input class="submit" type="submit" name="createAccount" value="Create Account">
</form>
<%
%> 
</div>
</body>
</html>
