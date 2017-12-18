<%@include file="/WEB-INF/jsp/databases.jsp" %>
<jsp:useBean id="user" class="main.java.beans.UserBean" scope="session"/>
<%
    RequestDispatcher rd = request.getRequestDispatcher("/blogs/create");
    List<String> errorMessages = new ArrayList();

    if (!user.isLoggedIn()) {
        rd = request.getRequestDispatcher("/");
        errorMessages.add("Not authorized to access");
        request.setAttribute("errorMessages", errorMessages);
        rd.forward(request, response);
        response.sendRedirect("/");
    }

%>
<t:template>
    <jsp:attribute name="head">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/simplemde/latest/simplemde.min.css">
        <script src="https://cdn.jsdelivr.net/simplemde/latest/simplemde.min.js"></script>
    </jsp:attribute>
    <jsp:attribute name="belowHead">
            <div class="panel panel-heading" style="margin-bottom: 30px;">
                <h3 class="text-center panel-text-size">New Blog</h3>
                <p class="text-center panel-text-size">NotSecure supports Markdown! <br>
                    Click on the eye symbol to preview your Markdown article.<br>
                    Confused? Learn more about <a href="<c:url value="/blogs/view?blog_id=29"/>">Markdown syntax</a>
                </p>
            </div>
            <div class="container">
                <form id="article_form" method="POST" action="<c:url value="/blogs/create_action"/>">
                    <div class="form-group">
                        <input style="display: block; width: 100%; padding-left: 10px;" class="disabled"
                               id="article_title" name="article_title" type="text" placeholder=" Title?" required
                               pattern="[a-z A-Z_0-9]{1,256}"/>
                    </div>
                    <div class="form-group">
                        <textarea id="article_content" name="article_content" required></textarea>
                    </div>
                    <input id="csrf-token" name="csrf_token" type="hidden" value="${user.csrf}"/>
                    <div class="form-group">
                        <div class="row justify-content-center">
                            <div class="col-sm-4">
                                <input id="blog-update-btn" type="submit" value="Publish" name="publish_btn"
                                       class="btn btn-primary btn-block ">
                            </div>
                        </div>
                    </div>
                </form>
                <div id="err-msg">
                        <c:if test="${not empty errorMessages}">
                            <c:forEach items="${errorMessages}" var="errorMessage">
                                <c:out value="${errorMessage}"/><br>
                            </c:forEach>
                        </c:if>
                </div>
            </div>
    </jsp:attribute>
    <jsp:attribute name="scripts">
        <script>
            var simplemde = new SimpleMDE({
                autofocus: true,
                element: $("#article_content")[0],
                forceSync: true,
                placeholder: "Type here..."
            });

            var title = document.getElementById("article_title");
            title.addEventListener("input", function (event) {
                if (title.validity.patternMismatch) {
                    title.setCustomValidity("Title must contains only a-zA-Z_0-9 and spaces");
                } else title.setCustomValidity("");
            });
        </script>
    </jsp:attribute>
    <jsp:body>

    </jsp:body>
</t:template>