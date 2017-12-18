<%@ page import="java.time.Instant" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.ZoneId" %>
<%@include file="/WEB-INF/jsp/databases.jsp" %>
<jsp:useBean id="user" class="main.java.beans.UserBean" scope="session"/>


<c:set var="bodyContent">
    <div class="list-group">
        <%
            RequestDispatcher rd = request.getRequestDispatcher("/blogs/search");
            List<String> errorMessages = new ArrayList();

            String query = "SELECT DISTINCT blog_id, title, display_name, LEFT(content , 150) AS content, created FROM blogs NATURAL JOIN (SELECT username AS author, display_name FROM users)un WHERE title LIKE ? OR content LIKE ? LIMIT ?";

            try {
                PreparedStatement stmt = conn.prepareStatement(query);

                String titleFilter = request.getParameter("title_filter");
                String contentFilter = request.getParameter("content_filter");
                String limitCount = request.getParameter("limit_count");

                titleFilter = titleFilter == null ? "" : titleFilter.trim();
                contentFilter = contentFilter == null ? "" : contentFilter.trim();
                limitCount = limitCount == null ? "" : limitCount.trim().replaceAll("[^0-9]", "");

                int limit = 0;
                titleFilter = !titleFilter.equals("") ? "%" + titleFilter + "%" : "";
                contentFilter = !contentFilter.equals("") ? "%" + contentFilter + "%" : "";
                limit = !limitCount.equals("") ? Integer.parseInt(limitCount) : 30;
                limit = limit > 30 ? 30 : limit;
                stmt.setString(1, titleFilter);
                stmt.setString(2, contentFilter);
                stmt.setInt(3, limit);
                ResultSet rs = stmt.executeQuery();

                while (rs.next()) {
                    long blogID = rs.getLong("blog_id");

                    String dispName = rs.getString("display_name");
                    String title = rs.getString("title");
                    title = title.length() > 30 ? title.substring(0, 30).trim() + "..." : title.trim();

                    String contentSnip = rs.getString("content");
                    contentSnip = contentSnip.length() == 150 ? contentSnip.trim() + "..." : contentSnip.trim();


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
        <a href="<c:url value="/blogs/view?blog_id="/><%=blogID%>" class="list-group-item list-group-item-action flex-column align-items-start">
            <div class="d-flex w-100 justify-content-between">
                <h5 class="mb-1"><%=title%>
                </h5>
                <small><%=timeSince%>
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
                rd = request.getRequestDispatcher("/");
                errorMessages.add("Error retrieving blogs");
                request.setAttribute("errorMessages", errorMessages);
                rd.forward(request, response);
                response.sendRedirect("/");
            }
        %>
    </div>
</c:set>

<t:template>
    <jsp:attribute name="head">
        <title>Your Blogs</title>
    </jsp:attribute>
    <jsp:attribute name="belowHead">
        <div class="panel panel-heading" style="margin-bottom: 30px;">
            <h3 class="text-center panel-text-size">Search for blogs</h3>
            <p class="text-center panel-text-size">Did you find you want? <br>
                You can search by title, content or both<br>
                Further refine your search below
            </p>
        </div>
        <form id="convFilter" method="POST" class="form-horizontal" action="">
            <div class="row justify-content-md-center" style="margin-bottom: 50px;" align="center">
                <div class="col-md-8">
                    <div class="form-group">
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="title_filter" id="title_filter"
                                   placeholder="Search by title">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="content_filter" id="content_filter"
                                   placeholder="Search by content">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="limit_count" id="limit_count"
                                   placeholder="Number of results to return">
                        </div>
                    </div>
                    <div class="col-sm-10">

                        <button type="submit" class="btn btn-secondary btn-lg btn-block">Filter</button>
                    </div>
                </div>
            </div>
        </form>

    </jsp:attribute>
    <jsp:body>
        ${bodyContent}
    </jsp:body>
</t:template>
