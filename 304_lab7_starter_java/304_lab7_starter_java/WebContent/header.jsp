
<!DOCTYPE html>
<html>
<head>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="stylesheet.css">
    <title>
    </title>
</head>
<body>    
 

   <div class="header">
       <div class="inner_header">
            <div class= "logo_container">
            <h1>
            <Image>
                <a href="index.jsp"><img src="otherImages/SS---1.png"  width="auto" height="275" position= "absolute" class="center"></a>
              
            </Image>
                  
                  
            </h1>
            </div>
            <u1 class="navigation">
                <a href="logout.jsp"><li>Logout</li></a>
                <a href="login.jsp"><li>Login</li></a>
               
           
            <%
                if(session.getAttribute("authenticatedUser")!= null){
                  out.print("<b><a><li>"+"welcome "+session.getAttribute("authenticatedUser").toString()+"!"+"</li></a></b>");
                  
              }
             
              %>
            
            <a href="createAccount.jsp"><li>Create Account</li></a>

            </u1>
            <u1 class="navigation2">
                <br><br><br><br>
                
            <a href="index.jsp"><li><img src="otherImages/home.png" alt="Home" height="60" ></li></a>
            <a href="addcart.jsp"><li><img src="otherImages/cart.png" alt="Cart" height="60" ></li></a>
            <a href="listprod.jsp?productName="><li>Shop</li></a>
            <a href="customer.jsp"><li>Customer</li></a>
            <a href="admin.jsp"><li>Administators</li></a>
            <a href="listorder.jsp"><li>Orders</li></a>

            
             </table>
             
       
      


             </u1>
        </div>
    </div>



</body>
</html>

