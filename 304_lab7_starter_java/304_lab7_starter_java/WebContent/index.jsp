<!DOCTYPE html>
<html>
<head>
        
</head>
<style>
.pimage {
  position: absolute;
          top:3px;
          margin-left:35%;
}
table.center {
    margin-left:auto; 
    margin-right:auto;
  }

  .div {
  border-style: outset;
  border-color: rgb(255, 125, 65);
  border-width: 5px;
  background-color: rgb(241, 112, 52);
 box-sizing: border-box;
 font-family: serif; font-weight: 2200; color: black; text-decoration: none;
}
.div:hover {
    box-shadow: inset 0 0 100px 100px rgba(255, 255, 255, 0.1);
}
.div2 {
  border-style: outset;
  border-color: rgb(255, 125, 65);
  border-width: 5px;
  background-color: rgb(241, 112, 52);
 box-sizing: border-box;
 font-family: serif; font-weight: 1200; color:white; text-decoration: none;
}
.div2:hover {
    box-shadow: inset 0 0 100px 100px rgba(255, 255, 255, 0.1);
}
</style>

<body style = "background: url(https://content.fortune.com/wp-content/uploads/2020/04/BlinkingOwl1.jpg?resize=1200,600); background-size: 100%;">
      



</style>
<br>
  <br>
  
<table align="right" width="Page"  cellpadding="25"  >
  <td align="center" valign="center"><h2><a href="login.jsp"  class="div2" >Login</a>
  </td></h2>
  <td align="center" ><h2><a href="logout.jsp"  class="div2">Log out</a></h2>
  </td>



</table>
<figure>
  <img src="otherImages/curly_s.png"  width="auto" height="375" class="pimage">

  </figure>
  <br>
  <br>
  
  <br>
  <br>
  <br>
   <br>
  <br>
  <br>
        <br>
        <br>
        <br>
        
        
        <br>
        <br>
        <br>
<table  align="center" width="Page" cellpadding="43">
  <tr>

          
          
          <td  align="center" valign="center"><h1 ><a href="listprod.jsp?productName=" class="div">Begin Shopping</a></h1>
          </td>

          <td  align="center" valign="center"><h1><a href="listorder.jsp" class="div">List All Orders</a></h1>
          </td>

          <td  align="center" valign="center"><h1><a href="customer.jsp" class="div">Customer Info</a></h1>
          </td>

          <td align="center" valign="center"><h1><a href="admin.jsp" class="div">Administrators</a></h1>
          </td>

          
          
  </tr> 
</table>

<%
// TODO: Display user name that is logged in (or nothing if not logged in)	
// Memorise any passed in user.
String username = request.getParameter("username");
if (username != null && username.length() > 0) {
  session.setAttribute("username", username);

out.print(username);
}
//if(authenticated==true){
  //      out.print("name");
//}
%>

</body>
</head>


