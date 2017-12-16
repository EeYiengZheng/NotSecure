<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../taglibs.jsp" %>
<%@include file="../databases.jsp" %>
<jsp:useBean id='user' scope='session' class='main.java.beans.UserBean'/>
<jsp:setProperty name='user' property='*'/>

<%
    String query = "SELECT * FROM users WHERE username=?";
    PreparedStatement stmt = con.prepareStatement(query);
    stmt.setString(1, user.getUsername());
    ResultSet rs = stmt.executeQuery();
    String nickname = "";
    String email = "";
    String firstName = "";
    String lastName = "";
    String birthday = "";
    String phone_number = "";
    String address = "";
    String ethnicity = "";
    String gender = "";

    if (rs.next()) {
        nickname = rs.getString("nickname") == null ? "" : rs.getString("nickname");
        email = rs.getString("email") == null ? "" : rs.getString("email");
        firstName = rs.getString("first_name") == null ? "" : rs.getString("first_name");
        lastName = rs.getString("last_name") == null ? "" : rs.getString("last_name");
        birthday = rs.getString("birthday") == null ? "" : rs.getString("birthday");
        phone_number = rs.getString("phone_number") == null ? "" : rs.getString("phone_number");
        address = rs.getString("address") == null ? "" : rs.getString("address");
        ethnicity = rs.getString("ethnicity") == null ? "" : rs.getString("ethnicity");
        gender = rs.getString("gender") == null ? "" : rs.getString("gender");

        stmt.close();
        con.close();
    } else {
        // error
    }
%>

<c:set var="bodyContent">
    <c:choose>
        <c:when test="${user.loggedIn}">
            <div class="field-group">
                <div class="col-75"><% if (request.getAttribute("resultMessage") != null) {
                    out.println(request.getAttribute("resultMessage"));
                }
                %>
                    <br></div>

                <div class="col-25"><label class='info-legend'>First Name</label></div>
                <div class="col-25"><input id="firstNameField" name="firstName" type="text" readonly
                                           value="<%=firstName%>">
                </div>
                <br>
                <br>
                <div class="col-25"><label class='info-legend'>Last Name</label></div>
                <div class="col-25"><input id="lastNameField" name="lastName" type="text" readonly
                                           value="<%=lastName%>">
                </div>
                <br>
                <br>
                <br>
                <div class="col-25"><label class='info-legend'>Birthday</label></div>
                <div class="col-25"><input id="birthdayField" name="birthday" type="text" readonly
                                           value="<%=birthday%>">
                </div>
                <br><br>
                <hr>
                <form method="post" action="change_password.jsp">
                    <div class="col-25"><label class='info-legend'>Current Password:</label></div>
                    <div class="col-25"><input id="currentPWField" name="current_password" type="password">
                    </div>
                    <br>
                    <br>
                    <div class="col-25"><label class='info-legend'>New Password:</label></div>
                    <div class="col-25"><input id="newPWField" name="new_password" type="password">
                    </div>
                    <br>
                    <br>
                    <div class="col-25"><label class='info-legend'>Re-enter New Password:</label></div>
                    <div class="col-25"><input id="rePWField" name="reenter_password" type="password">
                    </div>
                    <input type="submit" value="Change Password" class="btn btn-info btn-update">
                </form>
                <hr>
                <form method="post" action="change_info.jsp">
                    <div class="col-25"><label class='info-legend'>Nickname</label></div>
                    <div class="col-25"><input id="nameField" name="nickname" type="text" readonly
                                               value="<%=nickname%>"></div>
                    <div class="col-50">
                        <button type="button" id="changeNameBtn">Edit</button>
                        <button type="button" id="saveNameBtn">Save</button>
                    </div>

                    <br>
                    <br>
                    <div class="col-25"><label class='info-legend'>Email</label></div>
                    <div class="col-25"><input id="emailField" name="email" type="text" readonly value="<%=email%>">
                    </div>
                    <div class="col-50">
                        <button type="button" id="changeEmailBtn">Edit</button>
                        <button type="button" id="saveEmailBtn">Save</button>
                    </div>
                    <br><br>

                    <div class="col-25"><label class='info-legend'>Phone</label></div>
                    <div class="col-25"><input id="phoneField" name="phone_number" type="text" readonly
                                               value="<%=phone_number%>"></div>
                    <div class="col-50">
                        <button type="button" id="changePhoneBtn">Edit</button>
                        <button type="button" id="savePhoneBtn">Save</button>
                    </div>
                    <br><br>

                    <div class="col-25"><label class='info-legend'>Address</label></div>
                    <div class="col-25"><input id="addressField" name="address" type="text" readonly
                                               value="<%=address%>"></div>
                    <div class="col-50">
                        <button type="button" id="changeAddressBtn">Edit</button>
                        <button type="button" id="saveAddressBtn">Save</button>
                    </div>
                    <br><br>

                    <div class="col-25"><label class='info-legend'>Ethnicity</label></div>
                    <div class="col-25"><input id="ethnicityField" name="ethnicity" type="text" readonly
                                               value="<%=ethnicity%>">
                    </div>
                    <div class="col-50">
                        <button type="button" id="changeEthnicityBtn">Edit</button>
                        <button type="button" id="saveEthnicityBtn">Save</button>
                    </div>
                    <br><br>

                    <div class="col-25"><label class='info-legend'>Gender</label></div>
                    <div class="col-25"><input id="genderField" name="gender" type="text" readonly value="<%=gender%>">
                    </div>
                    <div class="col-50">
                        <button type="button" id="changeGenderBtn">Edit</button>
                        <button type="button" id="saveGenderBtn">Save</button>
                    </div>
                    <br>
                    <input type="submit" value="Update Info" class="btn btn-info btn-update">
                    <br><br><br><br>

                </form>
            </div>
        </c:when>
        <c:otherwise>
            <p> You are signed out. </p>
        </c:otherwise>
    </c:choose>
</c:set>

<t:genericpage>
    <jsp:attribute name="head">
        <title>User Information</title>
    </jsp:attribute>
    <jsp:attribute name="header">
        <h1 class="display-3">MyInfo</h1>
    </jsp:attribute>
    <jsp:attribute name="footer"></jsp:attribute>
    <jsp:attribute name="scripts">
        <script>
            $(document).ready(function () {
                $("#saveNameBtn").hide();
                $("#changeNameBtn").on("click", function () {
                    $("#nameField").attr("readonly", false);
                    $("#changeNameBtn").hide();
                    $("#saveNameBtn").show();
                });
                $("#saveNameBtn").on("click", function () {
                    $("#nameField").attr("readonly", true);
                    $("#saveNameBtn").hide();
                    $("#changeNameBtn").show();
                });
                $("#saveEmailBtn").hide();
                $("#changeEmailBtn").on("click", function () {
                    $("#emailField").attr("readonly", false);
                    $("#changeEmailBtn").hide();
                    $("#saveEmailBtn").show();
                });
                $("#saveEmailBtn").on("click", function () {
                    $("#emailField").attr("readonly", true);
                    $("#saveEmailBtn").hide();
                    $("#changeEmailBtn").show();
                });
                $("#savePhoneBtn").hide();
                $("#changePhoneBtn").on("click", function () {
                    $("#phoneField").attr("readonly", false);
                    $("#changePhoneBtn").hide();
                    $("#savePhoneBtn").show();
                });
                $("#savePhoneBtn").on("click", function () {
                    $("#phoneField").attr("readonly", true);
                    $("#savePhoneBtn").hide();
                    $("#changePhoneBtn").show();
                });
                $("#saveAddressBtn").hide();
                $("#changeAddressBtn").on("click", function () {
                    $("#addressField").attr("readonly", false);
                    $("#changeAddressBtn").hide();
                    $("#saveAddressBtn").show();
                });
                $("#saveAddressBtn").on("click", function () {
                    $("#addressField").attr("readonly", true);
                    $("#saveAddressBtn").hide();
                    $("#changeAddressBtn").show();
                });
                $("#saveEthnicityBtn").hide();
                $("#changeEthnicityBtn").on("click", function () {
                    $("#ethnicityField").attr("readonly", false);
                    $("#changeEthnicityBtn").hide();
                    $("#saveEthnicityBtn").show();
                });
                $("#saveEthnicityBtn").on("click", function () {
                    $("#ethnicityField").attr("readonly", true);
                    $("#saveEthnicityBtn").hide();
                    $("#changeEthnicityBtn").show();
                });
                $("#saveGenderBtn").hide();
                $("#changeGenderBtn").on("click", function () {
                    $("#genderField").attr("readonly", false);
                    $("#changeGenderBtn").hide();
                    $("#saveGenderBtn").show();
                });
                $("#saveGenderBtn").on("click", function () {
                    $("#genderField").attr("readonly", true);
                    $("#saveGenderBtn").hide();
                    $("#changeGenderBtn").show();
                });
            });
        </script>
    </jsp:attribute>
    <jsp:body>
        <div class="container justify-content-center" style="width: auto">
        ${bodyContent}
        </div>
    </jsp:body>

</t:genericpage>