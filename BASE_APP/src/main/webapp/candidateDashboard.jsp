<%@ page isELIgnored="false" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>Candidate Dashboard</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
                    integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
                    crossorigin="anonymous">
            </head>
            
            <!-- Navbar -->
            <!-- Navbar -->
            <nav class="navbar navbar-dark bg-dark justify-space-between px-4">
                <div class="container">
                    <a class="navbar-brand" href="#">Candidate Dashboard</a>
                <c:if test="${not empty message}">
                    <script>alert("${message}");</script>
                </c:if>
                <div class="navbar-nav flex-row">
                    <div class="">
                        <a class="nav-link" href="/logout" style="color:#ff0000">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                class="mr-1 bi bi-box-arrow-right" viewBox="0 0 16 16">
                                <path fill-rule="evenodd"
                                    d="M10 12.5a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-9a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v2a.5.5 0 0 0 1 0v-2A1.5 1.5 0 0 0 9.5 2h-8A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-2a.5.5 0 0 0-1 0v2z" />
                                <path fill-rule="evenodd"
                                    d="M15.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 0 0-.708.708L14.293 7.5H5.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3z" />
                            </svg>
                            Log Out
                        </a>
                    </div>
                </div>
                </div>
            </nav>

            <!-- Test List Section -->
            <section class="mt-4">
                <div class="container">

                    <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="pills-unattempted-tab" data-bs-toggle="pill"
                                data-bs-target="#pills-unattempted" type="button" role="tab" aria-controls="pills-unattempted"
                                aria-selected="true">Alloted Tests</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="pills-attempted-tab" data-bs-toggle="pill"
                                data-bs-target="#pills-attempted" type="button" role="tab" aria-controls="pills-attempted"
                                aria-selected="false">Attempted Tests</button>
                        </li>
                    </ul>
                    <div class="tab-content" id="pills-tabContent">
                        <div class="tab-pane fade show active" id="pills-unattempted" role="tabpanel"
                            aria-labelledby="pills-unattempted-tab">

                            <c:choose>
                                <c:when test="${not empty testDetails}">

                                    <!-- Table to display the list of tests -->
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>Test Name</th>
                                                <th>Description</th>
                                                <th>Duration (minutes)</th>
                                                <!-- Add more table headers as needed -->
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <!-- Populate the table with the list of assigned tests -->
                                            <c:forEach items="${testDetails}" var="test">
                                                <tr>
                                                    <td><a href="test/${test.id}">${test.testName}</a></td>
                                                    <td>${test.description}</td>
                                                    <td>${test.testTimer} min</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>

                                </c:when>

                                <c:when test="${empty testDetails}">
                                    No Test Allotted to you
                                </c:when>
                            </c:choose>
                        </div>
                        <div class="tab-pane fade" id="pills-attempted" role="tabpanel"
                            aria-labelledby="pills-attempted-tab">
                        
                            <c:choose>
                                <c:when test="${not empty submittedTests}">

                                    <!-- Table to display the list of tests -->
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>Test Name</th>
                                                <th>Description</th>
                                                <th>Duration (minutes)</th>
                                                <!-- Add more table headers as needed -->
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <!-- Populate the table with the list of assigned tests -->
                                            <c:forEach items="${submittedTests}" var="test">
                                                <tr>
                                                    <td><a href="viewResult/${test.id}">${test.testName}</a></td>
                                                    <td>${test.description}</td>
                                                    <td>${test.testTimer} min</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>

                                </c:when>

                                <c:when test="${empty submittedTests}">
                                    You havent attempted any test
                                </c:when>
                            </c:choose>

                        </div>
                    </div>

                </div>
            </section>

            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
                crossorigin="anonymous"></script>
            </body>

            </html>