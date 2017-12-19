<%@include file="/WEB-INF/jsp/databases.jsp" %>
<jsp:useBean id="user" class="main.java.beans.UserBean" scope="session"/>

<%
    RequestDispatcher rd = request.getRequestDispatcher("/account/login");
    List<String> errorMessages = new ArrayList();

    String query = "SELECT blog_id, title, display_name, content FROM blogs, users WHERE blog_id=? AND author = username LIMIT 1";
    try {
        long blogID = Long.parseLong(request.getParameter("blog_id"));
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setLong(1, blogID);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            session.setAttribute("curBlogID", blogID);
            out.print(String.format("<contents><author>%s</author><title>%s</title><content>%s</content></contents>", rs.getString("display_name"), rs.getString("title"), rs.getString("content")));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>