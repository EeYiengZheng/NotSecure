<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../taglibs.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>

<c:set var="bodyContent">
    <div class="container">
        <div class="row justify-content-md-center">
            <div class="col-md-6">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h2 class="" style="margin-bottom: 5px;">Login</h2><br>
                    </div>
                    <div class="panel-body">
                        <form role="form" action="login_action.jsp">
                            <div class="form-group">
                                <input type="text" name="username" id="user_name" class="form-control input-sm"
                                       placeholder="Username" required pattern="[a-zA-Z0-9_]{4,64}" minlength="4"
                                       maxlength="64">
                            </div>
                            <div class="form-group">
                                <input type="password" name="password" id="password" size="256"
                                       class="form-control input-sm"
                                       placeholder="Password" required minlength="8" maxlength="256">
                            </div>
                            <input type="submit" value="Login" class="btn btn-primary btn-block" id="login_btn">
                        </form>
                    </div>
                    <div id="err-msg">
                        <c:if test="${not empty errorMessages}">
                            <c:forEach items="${errorMessages}" var="errorMessage">
                                <c:out value="${errorMessage}"/><br>
                            </c:forEach>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</c:set>

<t:template>
    <jsp:attribute name="head">
        <title>Login</title>
    </jsp:attribute>
    <jsp:attribute name="scripts">
        <script>
            $(document).ready(function () {
                var uname = document.getElementById("user_name");
                uname.addEventListener("input", function (event) {
                    if (uname.validity.patternMismatch) {
                        uname.setCustomValidity("Username need to be 4-64 characters and contain only a-z_A-Z0-9");
                    } else uname.setCustomValidity("");
                });
            });
        </script>
    </jsp:attribute>
    <jsp:body>
        ${bodyContent}
    </jsp:body>

</t:template>
