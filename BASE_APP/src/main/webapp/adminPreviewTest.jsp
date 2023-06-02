<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Test Submissions</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2>Test Submissions</h2>
    <table class="table table-striped">
        <thead>
        <tr>
            <th>Submission ID</th>
            <th>Test Id</th>
            <th>Test Name</th>
            <th>User Id</th>
            <th>Username</th>
            <th>ProblemsSolved</th>
            <!-- Add more columns if needed -->
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${testSubmissions}" var="submission">
            <tr>
                <td><a href="/a/viewResult/${submission.testDetails.id}">${submission.id}</a></td>
                <td>${submission.testDetails.id}</td>
                <td>${submission.testDetails.testName}</td>
                <td>${submission.user.id}</td>
                <td>${submission.user.username}</td>
                <td>${submission.problemSubmissions.size()}</td>
                <!-- Add more columns if needed -->
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
