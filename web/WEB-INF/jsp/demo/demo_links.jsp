<%@include file="/WEB-INF/jsp/databases.jsp" %>
<%@page import="main.java.helpers.org.freeshell.zs.common.HtmlManipulator" %>




<c:set var="bodyContent">
    <div class="list-group">
    <%
        String query = "SELECT * FROM blogs WHERE blog_id=? LIMIT 1";
        int[] blogIDs = {1, 29, 32};
        String linkTitle = "No title";
        for (int id : blogIDs) {
            try {
                linkTitle = "No title. Blog_id=" + id;
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setInt(1, id);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    linkTitle = HtmlManipulator.replaceHtmlEntities(rs.getString("title")).trim();
                }
            } catch (Exception e) {
                // do nothing
            }
    %>
        <a href="<c:url value="/blogs/view?blog_id="/><%=id%> " class="list-group-item">
            <%=linkTitle%>
        </a>
    <%
        }
    %>
    </div>
</c:set>

<t:template>
    <jsp:attribute name="head">
        <title>NotSecure - Blogs</title>
    </jsp:attribute>
    <jsp:body>
        <div>
        <div class=" " style="margin-bottom: 30px;">
            <h1 class="text-center -text-size">Links</h1>
            <h3 class="text-center -text-size">to required articles</h3>
            <p class="text-center -text-size">These articles are published and can be accessed site-wide</p>

        </div>
        <div id="err-msg" align="center">
            <c:if test="${not empty errorMessages}">
                <c:forEach items="${errorMessages}" var="errorMessage">
                    <c:out value="${errorMessage}"/><br>
                </c:forEach>
            </c:if>
        </div>
        <br>
        ${bodyContent}
    </jsp:body>
</t:template>