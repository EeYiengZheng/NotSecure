<%@include file="/WEB-INF/jsp/databases.jsp" %>
<%@ page import="main.java.helpers.AccountHelper" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>


<%
    RequestDispatcher rd = request.getRequestDispatcher("/blogs/create");
    List<String> errorMessages = new ArrayList();

    if (!user.isLoggedIn()) {
        rd = request.getRequestDispatcher("/");
        errorMessages.add("Not authorized to access");
        request.setAttribute("errorMessages", errorMessages);
        rd.forward(request, response);
        response.sendRedirect("/");
    }

    String articleTitle = request.getParameter("article_title");
    String articleContent = request.getParameter("article_content");
    String formCsrf = request.getParameter("csrf_token");

    articleContent = articleContent
            .replace("\"", "&quot;")
            .replace("'", "&apos;")
            .replace("<", "&lt;")
            .replace(">", "&gt;")
            .replace("&", "&amp;");
    articleTitle = articleTitle
            .replace("\"", "&quot;")
            .replace("'", "&apos;")
            .replace("<", "&lt;")
            .replace(">", "&gt;")
            .replace("&", "&amp;");

    if (articleTitle != null && articleContent != null) {
        articleTitle = articleTitle.trim();
        articleContent = articleContent.trim();
        if (formCsrf != null && formCsrf.trim().equals(user.getCsrf())) {
            if (articleContent.equals("") || articleTitle.equals("")) {
                errorMessages.add("Please provide a title and some content for your artcle");
                request.setAttribute("errorMessages", errorMessages);
                rd.forward(request, response);
                response.sendRedirect("/blogs/create");
            }
        } else {
            errorMessages.add("Something happend to the page HTML.<br>" +
                    "Please refresh the page, or use a different browser.");
            request.setAttribute("errorMessages", errorMessages);
            rd.forward(request, response);
            response.sendRedirect("/blogs/create");
        }
    }

    try {
        String query = "INSERT INTO blogs(blog_id, author, title, content, created, updated) VALUE(NULL, ?, ?, ?, NULL, NULL)";
        PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
        stmt.setString(1, user.getUsername());
        stmt.setString(2, articleTitle);
        stmt.setString(3, articleContent);
        int ret = stmt.executeUpdate();
        ResultSet rs = stmt.getGeneratedKeys();

        if (ret == 1 && rs.next()) {
            long blogID = rs.getLong(1);
            System.out.println(user.getUsername() +" created blog_id " + blogID);
            if (blogID > 0) {
                errorMessages.add("Successfully created article: " + articleTitle);
                request.setAttribute("errorMessages", errorMessages);
                response.sendRedirect("/blogs/view?blog_id="+blogID);
            }
        } else {
            errorMessages.add("Fatal error (Create2): Server offline. please contact an admin");
            request.setAttribute("errorMessages", errorMessages);
            rd.forward(request, response);
        }
    } catch (Exception e) {
        e.printStackTrace();
        errorMessages.add("Fatal error (Create1): Server offline. please contact an admin");
        request.setAttribute("errorMessages", errorMessages);
        rd.forward(request, response);
    }

%>