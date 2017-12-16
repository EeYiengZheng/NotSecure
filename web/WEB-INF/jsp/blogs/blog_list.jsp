<%@ page import="java.time.Instant" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.ZoneId" %>
<%@include file="/WEB-INF/jsp/databases.jsp" %>
<jsp:useBean id="user" class="main.java.beans.UserBean" scope="session"/>

<c:set value="bodyContent">

    <div class="list-group">
        <%
            RequestDispatcher rd = request.getRequestDispatcher("/blogs/list");
            List<String> errorMessages = new ArrayList();

            if (!user.isLoggedIn()) {
                rd = request.getRequestDispatcher("/");
                errorMessages.add("Not authorized to access");
                request.setAttribute("errorMessages", errorMessages);
                rd.forward(request, response);
                response.sendRedirect("/");
            }

            String query = "SELECT title, display_name, LEFT(content , 150) as content, created FROM blogs NATURAL JOIN (SELECT username as author, display_name FROM users)un WHERE author=?;";
            try {
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setString(1, user.getUsername());
                ResultSet rs = stmt.executeQuery();

                while (rs.next()) {
                    String title = rs.getString("title");
                    title = title.length() > 30 ? title.substring(0, 30).trim() + "..." : title.trim();

                    String contentSnip = rs.getString("content");
                    contentSnip = contentSnip.length() == 150 ? contentSnip.trim() + "..." : contentSnip.trim();

                    String dispName = rs.getString("display_name");

                    Instant inst = Instant.ofEpochSecond(((long) rs.getTimestamp("created").getNanos()) * 1_000L);
                    long secondSince = ((long) Instant.now().compareTo(inst)) / 1_000_000_000L;
                    long minuteSince = secondSince >= 60 ? secondSince / 60L : 0;
                    long hourSince = minuteSince >= 60 ? minuteSince / 60L : 0;
                    long daySince = hourSince >= 24 ? hourSince / 24L : 0;
                    long weekSince = daySince >= 7 ? daySince / 7 : 0;
                    boolean switchToDate = weekSince > 3;

                    String timeSince = weekSince > 0 ? Long.toString(weekSince) + " weeks ago" : (
                            daySince > 0 ? Long.toString(daySince) + " days ago" : (
                                    hourSince > 0 ? Long.toString(hourSince) + " hours ago" : (
                                            minuteSince > 0 ? Long.toString(minuteSince) + " minutes ago" : (
                                                    Long.toString(secondSince) + " seconds ago"
                                            )
                                    )
                            ));
                    LocalDateTime ldt = LocalDateTime.ofInstant(inst, ZoneId.systemDefault());
                    String dateSince = String.format("%s %d, %d", ldt.getMonth(), ldt.getDayOfMonth(), ldt.getYear());

                    System.out.println(timeSince);
                    System.out.println(dateSince);
                    System.out.println(title);

        %>
        <a href="#" class="list-group-item list-group-item-action flex-column align-items-start active">
            <div class="d-flex w-100 justify-content-between">
                <h5 class="mb-1"><%=title%></h5>
                <small><%=timeSince%></small>
            </div>
            <p class="mb-1"><%=contentSnip%></p>
            <small>By: <%=dispName%></small>
        </a>
        <%
                }
            } catch (SQLException e) {

            }
        %>
    </>
</c:set>

<t:template>
    <jsp:attribute name="head">
        <title>Your Blogs</title>
    </jsp:attribute>
    <jsp:body>
        ${bodyContent}
    </jsp:body>
</t:template>
