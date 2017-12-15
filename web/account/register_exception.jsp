<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/taglibs.jsp"%>
<%@ page isErrorPage="true" %>

<html>
<head>
    <title>Registration Error</title>
    <meta http-equiv="Refresh" content="5;url=register.jsp">
</head>
<body>
<c:out value="Registration caused an error."/>
<c:out value="Please provide correct inputs for each fields."/>
<c:out value="You will be redirected in 5 seconds."/>
</body>
</html>
