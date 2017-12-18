<%@include file="/WEB-INF/jsp/databases.jsp" %>
<%@ page import="main.java.helpers.AccountHelper" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>

<%
    RequestDispatcher rd = request.getRequestDispatcher("/account/login");
    List<String> errorMessages = new ArrayList();

    String uname = request.getParameter("username");
    uname = uname == null ? null : uname.trim();
    String password = request.getParameter("password");
    if (uname != null && password != null && password.length() >= 8 && uname.matches("\\w{4,64}")) {
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
                    String newCSRF = AccountHelper.generateCSRFToken();

                    query = "UPDATE users SET csrf_token=? WHERE username=?";
                    stmt = conn.prepareStatement(query);
                    stmt.setString(1, newCSRF);
                    stmt.setString(2, uname);
                    int ret = stmt.executeUpdate();
                    if (ret == 1) {
                        user.setDisplayName(dispName);
                        user.setUsername(uname);
                        user.setLoggedIn(true);
                        user.setAdmin(admin);
                        user.setCsrf(newCSRF);

                        rd = request.getRequestDispatcher("/");
                        errorMessages.add("Welcome, " + dispName);
                        request.setAttribute("errorMessages", errorMessages);
                        rd.forward(request, response);
                    }
                }
            }
        } catch (SQLException e) {
            out.print(e.getStackTrace());
            errorMessages.add("Fatal error (login1): please contact an admin");
            request.setAttribute("errorMessages", errorMessages);
            rd.forward(request, response);
        }
    }

    // user doesn't exist or incorrect password
    errorMessages.add("Incorrect username and password combination");
    request.setAttribute("errorMessages", errorMessages);
    rd.forward(request, response);
%>
