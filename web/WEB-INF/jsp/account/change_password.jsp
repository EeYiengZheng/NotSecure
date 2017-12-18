<%@include file="/WEB-INF/jsp/databases.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>

<c:choose>
    <c:when test="${user.loggedIn}">
        <%

        String current_password = request.getParameter("current_password");
        String new_password = request.getParameter("new_password");
        String reenter_password = request.getParameter("reenter_password");
        if (new_password != "" && reenter_password != "" && current_password != "" && new_password.equals(reenter_password)) {
            String query = "UPDATE Users SET password=sha2(?, 256) WHERE username=? AND password=sha2(?, 256)";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, new_password);
            stmt.setString(2, user.getUsername());
            stmt.setString(3, current_password);
            int rows = stmt.executeUpdate();
            if (rows == 0) {
                request.setAttribute("resultMessage", "<p>Incorrect password. Try again.</p>");
            }
            else if (rows == 1) {
                request.setAttribute("resultMessage", "<p>Password changed successfully!</p>");
            }
            else {
                request.setAttribute("resultMessage", "<p>A serious error has occurred. Please contact the system administrator.</p>");
            }
            stmt.close();
            con.close();
        }
        else {
            request.setAttribute("resultMessage", "<p>Passwords did not match.</p>");
        }

        RequestDispatcher rd = request.getRequestDispatcher("");
        rd.forward(request, response);


    %>
    </c:when>
    <c:otherwise>
        <p> You are signed out. </p>
    </c:otherwise>
</c:choose>
