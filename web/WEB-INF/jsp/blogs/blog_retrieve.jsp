<%@include file="/WEB-INF/jsp/databases.jsp" %>
<jsp:useBean id="user" class="main.java.beans.UserBean" scope="session"/>

<%
    RequestDispatcher rd = request.getRequestDispatcher("/account/login");
    List<String> errorMessages = new ArrayList();

    String query = "SELECT * FROM blogs WHERE blog_id=? LIMIT 1";
    try {
        long blogID = Long.parseLong(request.getParameter("blog_id"));
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setLong(1, blogID);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            session.setAttribute("curBlogID", blogID);
            out.print(String.format("<contents><author>%s</author><title>%s</title><content>%s</content></contents>", rs.getString("author"), rs.getString("title"), rs.getString("content")));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>