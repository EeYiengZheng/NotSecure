<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../databases.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>
<c:choose>
	<c:when test="${user.loggedIn}">
        <%

            String query = "UPDATE users SET nickname=?, email=?, phone_number=?, address=?, ethnicity=?, gender=? WHERE username=?";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, request.getParameter("nickname") == "" ? null : request.getParameter("nickname"));
            stmt.setString(2, request.getParameter("email") == "" ? null : request.getParameter("email"));
            stmt.setString(3, request.getParameter("phone_number") == "" ? null : request.getParameter("phone_number"));
            stmt.setString(4, request.getParameter("address") == "" ? null : request.getParameter("address"));
            stmt.setString(5, request.getParameter("ethnicity") == "" ? null : request.getParameter("ethnicity"));
            stmt.setString(6, request.getParameter("gender") == "" ? null : request.getParameter("gender"));
            stmt.setString(7, user.getUsername());
            try {
                stmt.executeUpdate();
                request.setAttribute("resultMessage", "<p>Info successfully updated.</p>");
            }
            catch(Exception e) {
                request.setAttribute("resultMessage", "<p>Email taken.</p>");
            }
            finally {
                stmt.close();
                con.close();
            }

            RequestDispatcher rd = request.getRequestDispatcher("myInfo.jsp");
            rd.forward(request, response);


        %>
	</c:when>
	<c:otherwise>
		<p> You are signed out. </p>
	</c:otherwise>
</c:choose>
