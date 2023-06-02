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
    <form:form action="/admin/groups/create" method="POST" modelAttribute="userGroup">
        <table>
            <tr>
                <td><label for="name">Group Name:</label></td>
                <td><form:input path="name" id="groupName" /></td>
            </tr>
            <tr>
                <td><label for="code">Group Code:</label></td>
                <td><form:input path="code" id="groupCode" /></td>
            </tr>
            <tr>
                <td><label for="userIds">Users:</label></td>
                <td>
                    <form:select path="userIds" id="userIds" multiple="multiple">
                        <form:options items="${users}" itemValue="id" itemLabel="username" />
                    </form:select>
                </td>
            </tr>
            <tr>
                <td colspan="2"><input type="submit" value="Create Group" /></td>
            </tr>
        </table>
    </form:form>
</body>
</html>
