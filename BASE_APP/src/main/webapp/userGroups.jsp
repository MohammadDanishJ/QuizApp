<%@ page isELIgnored="false" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>Admin Dashboard</title>
                <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
            </head>

            <body>
                <!-- Navbar -->
                <nav class="navbar navbar-dark bg-dark justify-space-between">
                    <a class="navbar-brand" href="#">Admin Dashboard</a>
                    <c:if test="${not empty message}">
                        <script>alert("${message}");</script>
                    </c:if>
                    <div class="navbar-nav flex-row">
                        <div class="mr-4">
                            <a class="btn btn-secondary" href="groups/create">CreateGroup</a>
                        </div>
                        <div class="">
                            <a class="nav-link" href="/a/dashboard" style="color:#ff0000">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                    class="mr-1 bi bi-box-arrow-right" viewBox="0 0 16 16">
                                    <path fill-rule="evenodd"
                                        d="M10 12.5a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-9a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v2a.5.5 0 0 0 1 0v-2A1.5 1.5 0 0 0 9.5 2h-8A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-2a.5.5 0 0 0-1 0v2z" />
                                    <path fill-rule="evenodd"
                                        d="M15.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 0 0-.708.708L14.293 7.5H5.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3z" />
                                </svg>
                                Back
                            </a>
                        </div>
                    </div>
                </nav>

                <!-- Test List Section -->
                <section>
                    <div class="container">
                        <h2>All Groups</h2>

                        ${userGroups}
                        <!-- Table to display the list of tests -->
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Group Code</th>
                                    <th>Group Name</th>
                                    <th>Participants</th>
                                    <!-- Add more table headers as needed -->
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Populate the table with the list of assigned tests -->
                                <c:forEach items="${userGroups}" var="group">
                                    <tr>
                                        <td>${group.groupCode}</td>
                                        <td>${group.groupName}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </section>

                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
            </body>

            </html>