<%@include file="/WEB-INF/jsp/databases.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>


<c:set var="submissionContent">
    <%
        Boolean authorized = false;

        try {
            String query = "SELECT * FROM blogs WHERE blog_id=? AND author=? LIMIT 1";

            long blogID = Long.parseLong(request.getParameter("blog_id"));
            String uname = user.getUsername();
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setLong(1, blogID);
            stmt.setString(2, uname);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) authorized = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (user.isLoggedIn() && (user.isAdmin() || authorized)) {
    %>
    <input id="csrf-token" name="csrf_token" type="hidden" value="${user.csrf}"/>
    <div class="form-group">
        <div class="row">
            <div class="col-sm-6">
                <input id="blog-update-btn" type="submit" value="Update" name="update_btn"
                       class="btn btn-default btn-block">
            </div>
            <div class="col-sm-6" align="right">
                <input id="blog-delete-btn" type="submit" value="Delete" name="delete_btn"
                       class="btn btn-danger">
            </div>
        </div>
    </div>

    <%
        }
    %>
</c:set>

<t:template>
    <jsp:attribute name="head">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/simplemde/latest/simplemde.min.css">
        <script src="https://cdn.jsdelivr.net/simplemde/latest/simplemde.min.js"></script>
    </jsp:attribute>
    <jsp:attribute name="belowHead">
            <div class="container">
                <form id="edit-blog-form" method="POST" action="<c:url value="/blogs/update_action" />">
                    <div class="form-group">
                        <input style="display: block; width: 100%; padding-left: 10px;" class="disabled"
                               id="article_title" name="article_title" type="text" placeholder=" Title?" required
                               disabled pattern="[a-zA-Z_0-9 ',.?!]{1,256}"/>
                    </div>
                    <div class="form-group">
                        <textarea id="article_content" name="article_content" required></textarea>
                            <%--<button type="submit" class="btn btn-default">Submit</button>--%>
                    </div>
                        ${submissionContent}
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
            var getUrlParameter = function getUrlParameter(sParam) {
                var sPageURL = decodeURIComponent(window.location.search.substring(1)),
                    sURLVariables = sPageURL.split('&'),
                    sParameterName,
                    i;
                for (i = 0; i < sURLVariables.length; i++) {
                    sParameterName = sURLVariables[i].split('=');

                    if (sParameterName[0] === sParam) {
                        return sParameterName[1] === undefined ? true : sParameterName[1];
                    }
                }
            };

            var blogid = getUrlParameter("blog_id");
            blogid = blogid === undefined ? "" : blogid;
            $(document).ready(function () {
                $.ajax({
                    url: '<c:url value="/blogs/retrieve"/>',
                    type: 'POST',
                    dataType: 'xml',
                    data: {"blog_id": blogid.valueOf()},
                    success: function (respond) {
                        console.log(respond);
                        var simplemde;
                        <c:choose>
                        <c:when test="${user.loggedIn}" >
                        simplemde = new SimpleMDE({
                            autofocus: true,
                            element: $("#article_content")[0],
                            forceSync: true,
                            placeholder: "Type here...",
                            initialValue: $("<div/>").html($(respond).find("content").text()).text()
                        });
                        </c:when>
                        <c:otherwise>
                        simplemde = new SimpleMDE({
                            autofocus: true,
                            element: $("#article_content")[0],
                            forceSync: true,
                            placeholder: "Type here...",
                            initialValue: $("<div/>").html($(respond).find("content").text()).text(),
                            toolbar: false,
                            toolbarTips: false
                        });
                        </c:otherwise>
                        </c:choose>
                        simplemde.togglePreview();
                        $("#article_title").val($("<div/>").html($(respond).find('title').text()).text() + " - By: " + $("<div/>").html($(respond).find('author').text()).text());


                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(thrownError);
                        console.log("POST request failed. " + thrownError + " :" + xhr.status);
                        var simplemde = new SimpleMDE({
                            autofocus: true,
                            element: $("#article_content")[0],
                            forceSync: true,
                            placeholder: "Type here...",
                            initialValue: "Error: could not retrieve an article",
                            toolbar: false,
                            toolbarTips: false
                        });
                        simplemde.togglePreview();
                    }
                });
                var title = document.getElementById("article_title");
                title.addEventListener("input", function (event) {
                    if (title.validity.patternMismatch) {
                        title.setCustomValidity("Title must contains only a-zA-Z_0-9 ',.?! and spaces");
                    } else title.setCustomValidity("");
                });

            });
        </script>
    </jsp:attribute>
    <jsp:body>

    </jsp:body>
</t:template>