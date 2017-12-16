<%@tag description="Overall Page template" pageEncoding="UTF-8" %>
<%@attribute name="head" fragment="true" %>
<%@attribute name="style" fragment="true" %>
<%@attribute name="bodyTop" fragment="true" %>
<%@attribute name="bodyBottom" fragment="true" %>
<%@attribute name="scripts" fragment="true" %>
<%@include file="../jsp/taglibs.jsp" %>
<jsp:useBean id="user" class="main.java.beans.UserBean" scope="session"/>

<html>
<head>
    <jsp:invoke fragment="head"/>
    <link rel="shortcut icon" href="<c:url value="/resource/open.png"/>" type="image/png" />
    <meta name="author" content="Ee Zheng - CS166 Security Project">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, height=device-height initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css"
          integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">

    <style>
        .jumbotron {
            color: #555555;
            background: #f5f5f5;
            height: calc(100% - 66px);
            margin: 0;
        }

        #err-msg {
            color: red;
            font-size: 0.8em;
            font-family: Consolas;
        }

        .info {
            align-items: center;
        }

        footer {
            position: relative;
            width: 100%;
        }

        p.footer-text {
            position: absolute;
            width: 100%;
            color: #555555;
            font-size: 0.8em;
            text-align: center;
            bottom: 0;
        }

        <jsp:invoke fragment="style"/>
    </style>
</head>
<body id="inject-body">
<nav class="navbar navbar-expand-lg navbar-light ">
    <a class="navbar-brand mb-0" href="<c:url value="/"/>"><i class="fa fa-2x fa-user-secret" aria-hidden="true"></i><span class="d-inline-block align-top" style="font-size: 1.1em;"> NotSecure</span></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar" aria-controls="navbar"
            aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbar">
        <ul class="nav navbar-nav mr-auto">
            <c:if test="${user.loggedIn}">
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value="#"/>">MyInfo</a>
                </li>
                <c:if test="${user.isAdmin().equals('y')}">
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value="#"/>">admin only</a>
                    </li>
                </c:if>
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value="#"/>">search courses</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value="#"/>">Gradebook</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value="#"/>">Employees</a>
                </li>
            </c:if>

            <c:if test="${user.loggedIn && user.admin == 'y'}">
                <li class="nav-item">
                    <a style="color: red;" class="nav-link" href="<c:url value="#"/>">Access</a>
                </li>
            </c:if>
        </ul>

        <ul class="nav navbar-nav">
            <form class="form-inline my-2 my-md-0" style="margin-right: 20px;">
                <input class="form-control mr-sm-2" type="text" placeholder="Search">
                <button class="btn btn-outline-secondary my-2 my-sm-0" type="submit">Search</button>
            </form>
            <c:choose>
                <c:when test="${user.loggedIn}">
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value="/account/logout_action"/>">Sign Out</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="nav-item ">
                        <a class="nav-link" href="<c:url value="/account/login"/>">Login</a>
                    </li>
                    <li class="nav-item ">
                        <a class="nav-link" href="<c:url value="/account/register"/>">Register</a>
                    </li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</nav>
<div class="jumbotron">
    <div class="container">
        <div class="row justify-content-center" id="body-top">
            <jsp:invoke fragment="bodyTop"/>
        </div>
        <div class="row" id="body-middle">
            <jsp:doBody/>
        </div>
        <div class="row justify-content-center" id="body-bottom">
            <jsp:invoke fragment="bodyBottom"/>
        </div>
    </div>
</div>
<footer id="static-footer">
    <p class="footer-text">
        Created by: Ee Yieng Zheng (eeyieng.zheng@sjsu.edu)<br>
        For SJSU CS 166 - Information Security</p>
</footer>

<script src="https://code.jquery.com/jquery-3.2.1.min.js"
        integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"
        integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh"
        crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js"
        integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ"
        crossorigin="anonymous"></script>
<script>
    setInterval(function () {
        if (window.innerHeight >= 800) $("#static-footer").fadeIn();
        if (window.innerHeight < 800) $("#static-footer").fadeOut();
    }, 500);
</script>
<jsp:invoke fragment="scripts"/>
</body>
</html>