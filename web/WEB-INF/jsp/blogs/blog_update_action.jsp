<%@include file="/WEB-INF/jsp/databases.jsp" %>
<%@ page import="main.java.helpers.AccountHelper" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>


<%
    RequestDispatcher rd = request.getRequestDispatcher("/blogs/view?=" + session.getAttribute("curBlogID"));
    List<String> errorMessages = new ArrayList();
    String delete = request.getParameter("delete_btn");
    String update = request.getParameter("update_btn");

    if (!user.isLoggedIn()) {
        rd = request.getRequestDispatcher("/");
        errorMessages.add("Not authorized to access");
        request.setAttribute("errorMessages", errorMessages);
        rd.forward(request, response);
        response.sendRedirect("/");
    }
    String articleContent = request.getParameter("article_content");
    String formCsrf = request.getParameter("csrf_token");

    articleContent = articleContent
            .replace("\"", "&quot;")
            .replace("'", "&apos;")
            .replace("<", "&lt;")
            .replace(">", "&gt;")
            .replace("&", "&amp;");
    if (articleContent != null) {
        articleContent = articleContent.trim();
        if (formCsrf != null && formCsrf.trim().equals(user.getCsrf())) {
            if (articleContent.equals("")) {
                errorMessages.add("Please provide a title and some content for your article");
                request.setAttribute("errorMessages", errorMessages);
                rd.forward(request, response);
                response.sendRedirect("/blogs/create");
            }
        } else {
            errorMessages.add("Something happend to the page HTML.<br>" +
                    "Please refresh the page, or use a different browser.");
            request.setAttribute("errorMessages", errorMessages);
            rd.forward(request, response);
            response.sendRedirect("/blogs/view?=" + session.getAttribute("curBlogID"));
        }
    }

    long cbid = ((Long) session.getAttribute("curBlogID"));

    String query = "";
    System.out.println(update);
    System.out.println(delete);
    if (update != null) {
        query = "UPDATE blogs SET content=? WHERE blog_id=?";
        try {
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, articleContent);
            stmt.setLong(2, cbid);
            int ret = stmt.executeUpdate();

            if (ret == 1) {
                errorMessages.add("Successfully updated article");
                request.setAttribute("errorMessages", errorMessages);
                response.sendRedirect("/blogs/view?blog_id=" + cbid);
            } else {
                errorMessages.add("Fatal error (Update2): Server offline. please contact an admin");
                request.setAttribute("errorMessages", errorMessages);
                rd.forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            errorMessages.add("Fatal error (Delete3): Server offline. please contact an admin");
            request.setAttribute("errorMessages", errorMessages);
            rd.forward(request, response);
        }
    } else if (delete != null) {
        query = "DELETE FROM blogs WHERE blog_id=?";
        try {
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setLong(1, cbid);
            int ret = stmt.executeUpdate();
            System.out.println("here1");
            if (ret == 1) {
                errorMessages.add("Deleted article");
                request.setAttribute("errorMessages", errorMessages);
                response.sendRedirect("/blogs/list");
            } else {
                errorMessages.add("Fatal error (Delete2): Server offline. please contact an admin");
                request.setAttribute("errorMessages", errorMessages);
                rd.forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            errorMessages.add("Fatal error (Delete1): Server offline. please contact an admin");
            request.setAttribute("errorMessages", errorMessages);
            rd.forward(request, response);
        }

    }
    System.out.println("here2");
%>