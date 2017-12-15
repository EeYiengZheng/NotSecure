<%
//Search if cart cookie is found
String cartName = null;
Cookie[] cookies = request.getCookies();
if( cookies != null ) {
	for (int i = 0; i < cookies.length; i++) {
		if ( cookies[i].getName().equalsIgnoreCase("cart") ) {
			cartName = cookies[i].getValue();
			break;
		}
	}
}

if ( null==cartName ) {
	cartName = "CART-001";
	Cookie cartCookie  = new Cookie("cart", cartName);
	cartCookie.setMaxAge(1800);
	response.addCookie(cartCookie);
	out.print( "New cart created: " + cartName); 	
} else {
	out.print( "Existing cart opened: " + cartName); 	
}
%>


<%
// from console -  document.cookie="keyofcookie=valueofcookie"
%>