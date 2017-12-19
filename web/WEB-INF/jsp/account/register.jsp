<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/jsp/taglibs.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>

<%
    if (user.isLoggedIn()) {
        RequestDispatcher rd = request.getRequestDispatcher("/");
        response.sendRedirect("/");
    }
%>

<c:set var="bodyContent">
    <div class="container">
        <div class="row justify-content-md-center">
            <div class="col-md-8">
                <div class=" ">
                    <div class="">
                        <h2 class="" style="margin-bottom: 5px;">Register
                        </h2><br>
                    </div>
                    <div class="">
                        <form id="reg_form" role="form" method="POST"
                              action="<c:url value="/account/register_action"/>">
                            <div class="form-group">
                                <input type="text" name="disp_name" id="display_name_input" size="32"
                                       class="form-control input-sm"
                                       placeholder="Display Name" required pattern="[a-z_A-Z]{4,32}" minlength="4"
                                       maxlength="32">
                            </div>
                            <div class="form-group">
                                <input type="text" name="username" id="user_name" size="64"
                                       class="form-control input-sm"
                                       placeholder="Username" required pattern="[a-zA-Z0-9_]{4,64}" minlength="4"
                                       maxlength="64">
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="password" name="password" size="256" id="password"
                                               class="form-control input-sm" placeholder="Password"
                                               onchange="valid_pass()" required minlength="8"
                                               maxlength="256">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="password" name="conf_password" size="256"
                                               id="password_confirmation"
                                               class="form-control input-sm" placeholder="Verify Password"
                                               required pattern="">
                                    </div>
                                </div>
                            </div>
                            <div id='recaptcha' class="g-recaptcha"
                                 data-sitekey="6LcaOz0UAAAAAC3DojhPM94PuuAU7Qr0OEKS88v_"
                                 data-callback="onSubmit"
                                 data-size="invisible">
                            </div>
                            <input id="reg_btn" type="submit" value="Register" class="btn btn-primary btn-block">
                        </form>
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
    </div>
</c:set>

<t:template>
    <jsp:attribute name="head">
        <title>Register</title>
    </jsp:attribute>
    <jsp:attribute name="scripts">
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
        <script>
            $(document).ready(function () {
                var uname = document.getElementById("user_name");
                uname.addEventListener("input", function (event) {
                    if (uname.validity.patternMismatch) {
                        uname.setCustomValidity("Username need to be 4-64 characters and contain only a-z_A-Z0-9");
                    } else uname.setCustomValidity("");
                });

                var dname = document.getElementById("display_name_input");
                dname.addEventListener("input", function (event) {
                    if (dname.validity.patternMismatch) {
                        dname.setCustomValidity("Display name need to be 4-32 characters and contain only a-z_A-Z");
                    } else dname.setCustomValidity("");
                });

                var pass1 = document.getElementById("password_confirmation");
                pass1.addEventListener("input", function (event) {
                    if (pass1.validity.patternMismatch) {
                        pass1.setCustomValidity("Password doesn't match");
                    } else pass1.setCustomValidity("");
                });
            });


            function valid_pass() {
                $("#password_confirmation").attr("pattern", $("#password").val());
            }

            $("#reg_form").submit(function (e) {
                e.preventDefault();
                fail = "";
                if (!$("#user_name").val()) fail += "need username";
                if (!$("#display_name_input").val()) fail += "need display name";
                if (!fail) grecaptcha.execute();
                else console.log(fail);
            });

            function onSubmit(token) {
                $.ajax({
                    url: '<c:url value="/account/register_action"/>',
                    type: 'POST',
                    dataType: 'html',
                    data: $("#reg_form").serialize(),
                    success: function (respond) {
                        console.log("ajax success");
                        console.log("register_action triggered");
                        $("html").html(respond);
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(thrownError);
                        $("#err-msg").text("Failed to contact server. " + thrownError + " :" + xhr.status);
                    }
                });
            }
        </script>

    </jsp:attribute>
    <jsp:body>
        ${bodyContent}
    </jsp:body>

</t:template>