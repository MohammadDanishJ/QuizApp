<%@ page isELIgnored="false" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

                <html>

                <head>
                    <title>Create Group</title>
                    <!-- Include Bootstrap and other styling libraries -->
                </head>

                <body>
                    <h2>Create Group</h2>
                    <form:form action="/a/groups/create" method="POST" modelAttribute="userGroup">
                        <table>
                            <tr>
                                <td><label for="name">Group Name:</label></td>
                                <td>
                                    <form:input path="groupName" id="name" />
                                </td>
                            </tr>
                            <tr>
                                <td><label for="code">Group Code:</label></td>
                                <td>
                                    <form:input path="groupCode" id="code" />
                                </td>
                            </tr>
                            <tr>
                                <td><label for="userIds">Users:</label></td>
                                <td>
                                    <c:forEach items="${users}" var="user" varStatus="loop">

                                        <form:checkbox path="userIds" value="${user.id}" 
                                        id="user=${user.id}" />
                                        ${user.username} <br>
                                    </c:forEach>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2"><input type="submit" value="Create Group" /></td>
                            </tr>
                        </table>
                    </form:form>
                </body>

                </html>