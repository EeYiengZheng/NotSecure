<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/databases.jsp" %>

<%@ page import="java.time.Instant" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.ZoneId" %>

<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>

<c:set var="bodyContent">
    <div class="list-group">
        <%
            RequestDispatcher rd = request.getRequestDispatcher("/blogs/list");
            List<String> errorMessages = new ArrayList();

            String query = "SELECT blog_id, title, display_name, LEFT(content , 150) AS content, created FROM blogs NATURAL JOIN (SELECT username AS author, display_name FROM users)un ORDER BY RAND() LIMIT 5";
            try {
                PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    long blogID = rs.getLong("blog_id");

                    String title = rs.getString("title");
                    title = title.length() > 30 ? title.substring(0, 30).trim() + "..." : title.trim();

                    String contentSnip = rs.getString("content");
                    contentSnip = contentSnip.length() == 150 ? contentSnip.trim() + "..." : contentSnip.trim();

                    String dispName = rs.getString("display_name");

                    Instant inst = Instant.ofEpochSecond(rs.getTimestamp("created").getTime() / 1000);
                    Instant now = Instant.now();
                    long secondSince = (now.getEpochSecond() - inst.getEpochSecond());
                    double minuteSince = secondSince >= 60 ? secondSince / 60.0 : 0;
                    double hourSince = minuteSince >= 60 ? minuteSince / 60.0 : 0;
                    double daySince = hourSince >= 24 ? hourSince / 24.0 : 0;
                    double weekSince = daySince >= 7 ? daySince / 7.0 : 0;
                    boolean switchToDate = weekSince > 3;
                    String timeSince = (long) weekSince > 0 ? Long.toString((long) weekSince) + " weeks ago" : (
                            (long) daySince > 0 ? Long.toString((long) daySince) + " days ago" : (
                                    (long) hourSince > 0 ? Long.toString((long) hourSince) + " hours ago" : (
                                            (long) minuteSince > 0 ? Long.toString((long) minuteSince) + " minutes ago" : (
                                                    Long.toString(secondSince) + " seconds ago"
                                            )
                                    )
                            ));
                    LocalDateTime ldt = LocalDateTime.ofInstant(inst, ZoneId.systemDefault());
                    String dateSince = String.format("%s %d, %d", ldt.getMonth(), ldt.getDayOfMonth(), ldt.getYear());

                    String dateOrTime = switchToDate ? dateSince : timeSince;
        %>
        <a href="<c:url value="/blogs/view?blog_id="/><%=blogID%>"
           class="list-group-item list-group-item-action flex-column align-items-start">
            <div class=" d-flex w-100 justify-content-between">
                <h5 class="mb-1"><%=title%>
                </h5>
                <small><%=dateOrTime%>
                </small>
            </div>
            <p class="mb-1"><%=contentSnip%>
            </p>
            <small>By: <%=dispName%>
            </small>
        </a>
        <%
                }
            } catch (SQLException e) {

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
            <div class="panel panel-heading" style="margin-bottom: 30px;">
                <h1 class="text-center panel-text-size">NotSecure</h1>
                <h3 class="text-center panel-text-size">A blog for security nerds</h3>
                <p class="text-center panel-text-size">Below is a small set of what you can expect</p>
                <p class="text-center panel-text-size">Not enough? Use the search bar.<br>How about signup and write your own?</p>
            </div>
            <div id="err-msg" align="center">
                <c:if test="${not empty errorMessages}">
                    <c:forEach items="${errorMessages}" var="errorMessage">
                        <c:out value="${errorMessage}"/><br>
                    </c:forEach>
                </c:if>
            </div>
            <br>
            <div class="panel-body">
                    ${bodyContent}
            </div>
        </div>
    </jsp:body>
</t:template>