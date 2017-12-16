<%@page import="java.sql.*, java.util.*" %>
<%@include file="taglibs.jsp" %>
<%
    Connection conn = null;
    try {
        Class.forName("org.mariadb.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/notsecure_eezheng", "root", "");
    } catch (Exception e) {
        out.print("An error occurred while connecting to the database");
        return;
    }

%>