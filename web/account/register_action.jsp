<%@ include file="/databases.jsp" %>
<%@ page import="main.java.helpers.AccountHelper" %>

<%
    RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
    List<String> errorMessages = new ArrayList();

    String dispName = request.getParameter("disp_name").trim().replaceAll("\\s", "_");
    String uname = request.getParameter("username").trim();
    String pass = request.getParameter("password").trim().equals(request.getParameter("conf_password").trim()) ? request.getParameter("conf_password").trim() : " ";
    boolean validForm = pass.length() >= 8 && dispName.matches("[a-z_A-Z]{4,32}") && uname.matches("\\w{4,64}");
    if (!validForm) {
        if (pass.length() < 8)
            errorMessages.add("Password must match and contain 8 characters or more");
        if (!dispName.matches("[a-z_A-Z]{4,32}"))
            errorMessages.add("Display name must contain 4 to 32 characters only a-z _ A-Z");
        if (!uname.matches("[\\w]{4,64}")) errorMessages.add("Username need to be 4 to 64 characters and contain only a-z A-Z _ 0-9");
        request.setAttribute("errorMessages", errorMessages);
        rd.forward(request, response);
    } else {
        String query = "SELECT * FROM users WHERE username=? LIMIT 1";
        try {
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, uname);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                errorMessages.add("This username is already taken");
                request.setAttribute("errorMessages", errorMessages);
                rd.forward(request, response);
            }
        } catch (SQLException e) {
            errorMessages.add("Fatal error (registration1): please contact an admin");
            request.setAttribute("errorMessages", errorMessages);
            rd.forward(request, response);
        }

        query = "INSERT INTO Users(username, password, display_name, salt, admin) VALUES (?, ?, ?, ?, ?)";
        byte[] salt = AccountHelper.getNewSalt();
        String saltString = AccountHelper.toHex(salt);
        String hashedPass = AccountHelper.toHex(AccountHelper.hash(salt, pass.getBytes()));

        try {
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, uname);
            stmt.setString(2, hashedPass);
            stmt.setString(3, dispName);
            stmt.setString(4, saltString);
            stmt.setString(5, "n");
            int ret = stmt.executeUpdate();

            if (ret == 1) {
                rd = request.getRequestDispatcher("login.jsp");
                errorMessages.add("Registration successful");
                request.setAttribute("errorMessages", errorMessages);
                rd.forward(request, response);
            } else {
                errorMessages.add("Fatal error (registration3): Server offline. please contact an admin");
                request.setAttribute("errorMessages", errorMessages);
                rd.forward(request, response);
            }
        } catch (SQLException e) {
            errorMessages.add("Fatal error (registration2): Server offline. please contact an admin");
            request.setAttribute("errorMessages", errorMessages);
            rd.forward(request, response);
        }
    }
%>