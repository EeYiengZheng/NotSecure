<%@tag description="Overall Page template" pageEncoding="UTF-8" %>
<%@attribute name="head" fragment="true" %>
<%@attribute name="style" fragment="true" %>
<%@attribute name="belowHead" fragment="true" %>
<%@attribute name="bodyTop" fragment="true" %>
<%@attribute name="bodyBottom" fragment="true" %>
<%@attribute name="scripts" fragment="true" %>
<%@include file="/WEB-INF/jsp/taglibs.jsp" %>
<jsp:useBean id="user" class="main.java.beans.UserBean" scope="session"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="icon" href="<c:url value="/resource/open.png"/>" type="image/png"/>
    <link rel="shortcut icon" href="<c:url value="/resource/open.png"/>" type="image/png"/>
    <meta charset="utf-8">
    <meta name="author" content="Ee Zheng - CS166 Security Project">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css"
          integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
    <jsp:invoke fragment="head"/>
    <style>
        html {
            position: relative;
            background: #f5f5f5;
            min-height: 100%;
        }

        body {
            /* Margin bottom by footer height */
            margin-bottom: 0;
            background: #f5f5f5;
        }

        .footer {
            position: absolute;
            bottom: 0;
            width: 100%;
            /* Set the fixed height of the footer here */
            height: 60px;
        }

        .jumbotron {
            background: #f5f5f5;
            background-size: cover;
        }

        .list-group {
            margin-bottom: 60px;
        }

        #err-msg {
            color: red;
            font-size: 0.8em;
            font-family: Consolas;
        }

        .link-danger {
            color: red !important;
        }

        .link-primary {
            color: #868e96 !important;;
        }

        h1.-text-size {
            font-size: 4rem;
        }

        h3.-text-size {
            font-size: 2rem;
        }

        p.-text-size {
            font-size: 1rem;
        }

        p.footer-text {
            font-size: 0.8em;
            text-align: center;
        }

        <jsp:invoke fragment="style"/>
    </style>
</head>
<body id="inject-body">
<nav class="navbar navbar-expand-xl navbar-light ">
    <a class="navbar-brand mb-0" href="<c:url value="/"/>"><i class="fa fa-2x fa-user-secret"
                                                              aria-hidden="true"></i><span
            class="d-inline-block align-top" style="font-size: 1.1em;"> NotSecure</span></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar" aria-controls="navbar"
            aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse justify-content-between" id="navbar">
        <ul class="nav navbar-nav">
            <li class="nav-item">
                <a class="nav-link link-primary" href="<c:url value="/demo/links"/>">CS166 Articles</a>
            </li>
            <c:if test="${user.loggedIn}">
                <li class="nav-item">
                    <a class="nav-link link-primary" href="<c:url value="/blogs/list"/>">My Blogs</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link link-primary" href="<c:url value="/blogs/create"/>">Create Blogs</a>
                </li>
            </c:if>
        </ul>
        <ul class="nav navbar-nav">
            <c:if test="${user.admin == true}">
                <li class="nav-item">
                    <a class="nav-link link-danger" style="pointer-events: none;">Admin Access</a>
                </li>
            </c:if>
        </ul>
        <ul class="nav navbar-nav">
            <form id="front-page-search" method="POST" action="<c:url value="/blogs/search" />"
                  class="form-inline my-2 my-md-0" style="margin-right: 20px;">
                <input class="form-control mr-sm-2" name="title_filter" type="text" placeholder="Search titles">
                <button class="btn btn-outline-secondary my-2 my-sm-0" type="submit">Search</button>
            </form>
            <c:choose>
                <c:when test="${user.loggedIn}">
                    <li class="nav-item">
                        <a class="nav-link disabled" style="color: #7a7a7a;">Hi, <%=user.getDisplayName()%>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link link-danger" href="<c:url value="/account/logout_action"/>">Sign Out</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="nav-item">
                        <a class="nav-link disabled" style="color: #7a7a7a;">Welcome, Guest </a>
                    </li>
                    <li class="nav-item ">
                        <a class="nav-link link-primary" href="<c:url value="/account/login"/>">Login</a>
                    </li>
                    <li class="nav-item ">
                        <a class="nav-link link-primary" href="<c:url value="/account/register"/>">Register</a>
                    </li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</nav>
<main role="main" class="container">
    <div class="jumbotron">
        <div class="container">
            <div class="container">
                <jsp:invoke fragment="belowHead"/>
            </div>
            <div class="row justify-content-center" id="body-top">
                <jsp:invoke fragment="bodyTop"/>
            </div>
            <div class="row justify-content-center" id="body-middle">
                <jsp:doBody/>
            </div>
            <div class="row justify-content-center" id="body-bottom">
                <jsp:invoke fragment="bodyBottom"/>
            </div>
        </div>
    </div>
</main>
<footer class="footer">
    <div class="container">
        <p class="footer-text">
            <a href="<c:url value="/blogs/view?blog_id=1"/>">
                <span class="text-muted">Privacy Policy and Contact Information</span>
            </a>
            <span class="text-muted" style="font-size: 0.7em">
                <br>Created by Ee Yieng Zheng, for SJSU CS 166 Information Security
            </span>
        </p>
    </div>
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
        if ($(window).scrollTop() + $(window).height() > $(document).height() - 50) {
            $("#static-footer").fadeIn();
        }
        else $("#static-footer").fadeOut();
    }, 2000);
</script>
<jsp:invoke fragment="scripts"/>
</body>

</html>