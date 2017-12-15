<%@include file="/databases.jsp" %>
<%@ page import="main.java.helpers.AccountHelper" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>


<%
    RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
    List<String> errorMessages = new ArrayList();

    String uname = request.getParameter("username");
    String password = request.getParameter("password");

    String query = "SELECT * FROM users WHERE username=? LIMIT 1";
    try {
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, uname);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            String dispName = rs.getString("display_name");
            byte[] salt = AccountHelper.toByte(rs.getString("salt"));
            boolean admin = rs.getString("admin").equals("y");
            password = AccountHelper.toHex(AccountHelper.hash(salt, password.getBytes()));
            if (rs.getString("password").equals(password)) {
                user.setDisplayName(dispName);
                user.setUsername(uname);
                user.setLoggedIn(true);
                user.setAdmin(admin);

                errorMessages.add("Welcome, " + dispName);
                errorMessages.add(user.getUsername());
                errorMessages.add(user.getDisplayName());
                errorMessages.add(Boolean.toString(user.isAdmin()));
                errorMessages.add(Boolean.toString(user.isLoggedIn()));
                request.setAttribute("errorMessages", errorMessages);
                rd.forward(request, response);
            }
        }
    } catch (SQLException e) {
        errorMessages.add("Fatal error (login1): please contact an admin");
        request.setAttribute("errorMessages", errorMessages);
        rd.forward(request, response);
    }

    // user doesn't exist or incorrect password
    errorMessages.add("Incorrect username and password combination");
    request.setAttribute("errorMessages", errorMessages);
    rd.forward(request, response);

%>
