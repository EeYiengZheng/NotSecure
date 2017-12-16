
<%

String csrf = "" + System.currentTimeMillis() + Math.random() * 10000000;
session.setAttribute("csrf", csrf);
%>
<hr>
<h3>Add a blog item</h2>
    <form method="post" action="blog_action.jsp">
        Blog Title: <input name="blogtitle" size=100/><br>
        <textarea name="blogcontent" rows="10" cols="100"></textarea><br>
        <input type="submit" value="Add Blog"/>

        <input type="hidden" name="csrftoken" value=<% out.print(csrf); %>
                </form>
