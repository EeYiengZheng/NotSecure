<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<%
    user.setUsername(null);
    user.setDisplayName(null);
    user.setAdmin(false);
    user.setLoggedIn(false);
    user.setCsrf(null);
    response.sendRedirect("/");
%>