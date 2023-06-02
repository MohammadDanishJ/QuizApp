<%@ page isELIgnored="false" %>
  <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
      <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

          <!DOCTYPE html>
          <html lang="en">

          <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>View Test Result</title>
            <!-- Bootstrap CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
              crossorigin="anonymous">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
              integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
            <link rel="stylesheet" type="text/css" href="/resources/button.css">
            <link rel="stylesheet" href="/resources/prettyprint.css">
            <style>
              tr:hover {
                cursor: pointer;
                background-color: aliceblue;
              }

              td>i {
                margin-right: 1rem;
              }

            </style>
          </head>

          <body>
            <div class="position-fixed" style="z-index:99;top:1rem;right:1rem;color:red">
              <div id="closeButton" style="color:inherit; text-decoration: none;">
                <span class="left">
                  <span class="circle-left"></span>
                  <span class="circle-right"></span>
                </span>
                <span class="right">
                  <span class="circle-left"></span>
                  <span class="circle-right"></span>
                </span>
              </div>
            </div>
            <div class="container mt-5">
              <h2>Test Result</h2>
              <div class="card">
                <div class="card-body">
                  <h5 class="card-title">Test Submission Details</h5>
                  <p><strong>Submission ID:</strong> ${testSubmission.id}</p>
                  <p><strong>Submission Date:</strong> </p>
                  <p><strong>Test Name:</strong> ${testDetails.testName}</p>
                  <p><strong>Employee:</strong> ${testSubmission.user.username}</p>

                  <c:set var="totalTestCases" value="0" />
                  <c:set var="passedTestCases" value="0" />

                  <!-- TO DO: THIS NESTED LOOP MUST BE REMOVED OR OPTIMIZED WELL  -->
                  <c:forEach items="${testSubmission.problemSubmissions}" var="problemSubmission">
                    <c:forEach items="${testDetails.problems}" var="problem">
                      <c:if test="${problem.id eq problemSubmission.problemId}">
                        <c:set var="totalTestCases" value="${totalTestCases + problem.testCases.size()}" />
                        <c:set var="passedTestCases"
                          value="${passedTestCases + problemSubmission.numberOfTestCasesPassed}" />

                      </c:if>
                    </c:forEach>
                  </c:forEach>

                  <c:set var="overAllResult" value="${(passedTestCases / totalTestCases) * 100}" />

                  <p><strong>Test Result:</strong>
                    <fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2"
                      value="${overAllResult}" />%

                    <c:choose>
                      <c:when test="${overAllResult >= 90}">
                        <span class="badge bg-success">Perfect</span>
                      </c:when>

                      <c:when test="${overAllResult >= 70}">
                        <span class="badge bg-success">Passed</span>
                      </c:when>

                      <c:when test="${overAllResult < 70 and overAllResult>=50}">
                        <span class="badge bg-warning">Average</span>
                      </c:when>

                      <c:when test="${overAllResult < 50 and overAllResult>=30}">
                        <span class="badge bg-danger">Need Attention</span>
                      </c:when>

                      <c:when test="${overAllResult < 30}">
                        <span class="badge bg-danger">You May Go Home...</span>
                      </c:when>
                    </c:choose>

                  </p>
                </div>
              </div>

              <div class="card mt-4">
                <div class="card-body">
                  <h5 class="card-title">Test Results</h5>
                  <table class="table">
                    <thead>
                      <tr>
                        <!-- <th>Problem Id</th> -->
                        <th>Problem</th>
                        <th>Description</th>
                        <th>Passed Test Cases</th>
                        <th>Result</th>
                      </tr>
                    </thead>


                    <tbody>
                      <div class="accordion accordion-flush" id="accordionFlushExample">
                        <!-- TO DO: THIS NESTED LOOP MUST BE REMOVED OR OPTIMIZED WELL  -->
                        <c:forEach items="${testSubmission.problemSubmissions}" var="problemSubmission">
                          <c:forEach items="${testDetails.problems}" var="problem">
                            <c:if test="${problem.id eq problemSubmission.problemId}">
                              <tr data-bs-toggle="collapse" data-bs-target="#collapse-${problem.id}"
                                aria-expanded="false" aria-controls="collapse-${problem.id}">

                                <td><i class="fas fa-circle-plus"></i> ${problem.title}</td>
                                <td>${problem.description}</td>
                                <td>${problemSubmission.numberOfTestCasesPassed}/${problem.testCases.size()}</td>
                                <td>${(problemSubmission.numberOfTestCasesPassed/problem.testCases.size())*100}%</td>

                              </tr>
                              <tr id="collapse-${problem.id}" class="collapse">
                                <td colspan="5">
                                  <!-- Add the content of the submission here -->
                                  <pre class="prettyprint">${problemSubmission.codeSnippet}</pre>
                                </td>
                              </tr>
                              <c:set var="totalTestCases" value="${totalTestCases + problem.testCases.size()}" />
                              <c:set var="passedTestCases"
                                value="${passedTestCases + problemSubmission.numberOfTestCasesPassed}" />
                            </c:if>
                          </c:forEach>
                        </c:forEach>
                      </div>
                    </tbody>


                  </table>
                </div>
              </div>
            </div>

            <!-- jQuery -->
            <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
            <!-- Bootstrap JS -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
              integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
              crossorigin="anonymous"></script>
            <!-- Prettier -->
            <script src="https://cdn.jsdelivr.net/gh/google/code-prettify@master/loader/run_prettify.js"></script>

            <script>
              $(document).ready(function () {
                // Get the current URL
                var currentURL = window.location.href;

                // Check if the URL contains "/a/"
                if (currentURL.includes("/a/")) {
                  // Redirect to the admin dashboard
                  $("#closeButton").click(function () {
                    window.location.href = "/a/dashboard";
                  });
                } else if (currentURL.includes("/c/")) {
                  // Redirect to the candidate dashboard
                  $("#closeButton").click(function () {
                    window.location.href = "/c/dashboard";
                  });
                }
              });
            </script>

          </body>

          </html>