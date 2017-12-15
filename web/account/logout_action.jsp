<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<%
    user.setUsername(null);
    user.setDisplayName("Guest");
    user.setAdmin(false);
    user.setLoggedIn(false);
    response.sendRedirect("/");
%>