<%@page import="java.sql.*, java.util.*" %>
<%@include file="taglibs.jsp" %>
<%
    Connection conn = null;
    try {
        String dbUrl = System.getenv("JDBC_DATABASE_URL");
        Class.forName("org.mariadb.jdbc.Driver");
        conn = DriverManager.getConnection(dbUrl);
    } catch (Exception e) {
        out.print("An error occurred while connecting to the database");
        return;
    }

%>