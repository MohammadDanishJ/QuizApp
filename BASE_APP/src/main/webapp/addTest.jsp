<%@ page isELIgnored="false" %>
  <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
      <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html>
        <!----------------------------------------------------------------------------------------------->

        <head>
          <title>Add Test</title>
          <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
        </head>

        <!----------------------------------------------------------------------------------------------->

        <body>
          <div class="container">
            <h2 class="mt-4">Add Test ${error}</h2>

            <!------------------------------------------------------------------------------------------->
            <form:form action="addTest" method="POST" modelAttribute="testDetails" id="testForm">
              <div class="form-group">
                <label for="name">Test Name:</label>

                <!--------------------------------------------------------------------------------------->
                <form:input type="text" class="form-control" id="name" path="testName" required="true" />
              </div>
              <div class="form-group">
                <label for="description">Description:</label>

                <!--------------------------------------------------------------------------------------->
                <form:textarea class="form-control" id="description" path="description" rows="3" required="true" />
              </div>
              <div class="form-group">
                <label for="timer">Test Timer (in Minutes):</label>

                <!--------------------------------------------------------------------------------------->
                <form:input type="number" class="form-control" id="timer" path="testTimer" required="true" />
              </div>
              <div id="problems-container">
                <div class="card mb-4" data-problem-id="0">
                  <div class="card-header d-flex justify-content-between">
                    <h5 class="card-title m-0">Problem 1</h5>
                    <!-- <button type="button" class="btn btn-danger btn-sm delete-btn" onclick="deleteProblem(this)"
                      disabled="true">
                      Delete
                    </button> -->
                  </div>
                  <div class="card-body">
                    <div class="form-group">
                      <label for="problem0.title">Title:</label>

                      <!------------------------------------------------------------------------------->
                      <form:input type="text" class="form-control" id="problem0.title" path="problems[0].title"
                        required="true" />
                    </div>
                    <div class="form-group">
                      <label for="problem0.description">Description:</label>

                      <!------------------------------------------------------------------------------->
                      <form:textarea class="form-control" id="problem0.description" path="problems[0].description"
                        rows="3" required="true"></form:textarea>
                    </div>
                    <div class="form-group">
                      <!------------------------------------------------------------------------------->
                      <table class="table table-bordered">
                        <thead>
                          <tr>
                            <th>Input</th>
                            <th>Output</th>
                            <th>Action</th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr>
                            <td>
                              <!----------------------------------------------------------------------->
                              <form:textarea class="form-control" path="problems[0].testCases[0].input" rows="1"
                                required="true" />
                            </td>
                            <td>
                              <!----------------------------------------------------------------------->
                              <form:textarea class="form-control" path="problems[0].testCases[0].output" rows="1"
                                required="true" />
                            </td>
                            <td>
                              <!-- <button type="button" class="btn btn-danger btn-sm delete-btn"
                                onclick="deleteTestCase (this)" disabled="true">
                                Delete
                              </button> -->
                            </td>
                          </tr>
                        </tbody>
                      </table>
                      <button type="button" class="btn btn-secondary btn-sm" onclick="addTestCase(this)">
                        Add New Test Case
                      </button>
                    </div>
                  </div>
                </div>


              </div>
              <div class="w-100 d-flex justify-content-center">
                <button type="button" class="btn btn-secondary mx-2" onclick="addProblem()">
                  Add New Problem
                </button>
                <button type="submit" class="btn btn-primary mx-2">Save Test</button>
              </div>
            </form:form>
          </div>
          <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
          <script>
            var problemCount = 1;
            var testCaseCount = 1;

            // addProblem();

            // ------------------------------------------------------------------------------------------>
            function addProblem() {
              var problemsContainer = $("#problems-container");
              var newRow =
                '<div class="card mb-4" data-problem-id="' +
                problemCount +
                '">' +
                '<div class="card-header d-flex justify-content-between">' +
                '<h5 class="card-title m-0">Problem ' +
                (problemCount + 1) +
                "</h5>" +
                '<button type="button" class="btn btn-danger btn-sm delete-btn" onclick="deleteProblem(this)">Delete</button>' +
                "</div>" +
                '<div class="card-body">' +
                '<div class="form-group">' +
                '<label for="problem' +
                problemCount +
                '.title">Title:</label>' +
                '<input type="text" class="form-control" id="problem' +
                problemCount +
                '.title" name="problems[' +
                problemCount +
                '].title" required="true" />' +
                "</div>" +
                '<div class="form-group">' +
                '<label for="problem' +
                problemCount +
                '.description">Description:</label>' +
                '<textarea class="form-control" id="problem' +
                problemCount +
                '.description" name="problems[' +
                problemCount +
                '].description" rows="3" required="true"></textarea>' +
                "</div>" +
                '<div class="form-group">' +
                '<table class="table table-bordered">' +
                "<thead>" +
                "<tr>" +
                "<th>Input</th>" +
                "<th>Output</th>" +
                "<th>Action</th>" +
                "</tr>" +
                "</thead>" +
                "<tbody>" +
                "<tr>" +
                "<td>" +
                '<textarea class="form-control" name="problems[' +
                problemCount +
                '].testCases[0].input" rows="1"></textarea>' +
                "</td>" +
                "<td>" +
                '<textarea class="form-control" name="problems[' +
                problemCount +
                '].testCases[0].output"  rows="1" required="true"></textarea>' +
                "</td>" +
                "<td>" +
                // '<button type="button" class="btn btn-danger btn-sm delete-btn" onclick="deleteTestCase(this)"  disabled="true">Delete</button>' +
                "</td>" +
                "</tr>" +
                "</tbody>" +
                "</table>" +
                '<button type="button" class="btn btn-secondary btn-sm" onclick="addTestCase(this)">Add New Test Case</button>' +
                "</div>" +
                "</div>" +
                "</div>";
              problemsContainer.append(newRow);
              problemCount++;

              console.log("${testDetails}");
            }
            function addTestCase(button) {
              var problemCard = $(button).closest(".card");
              var problemId = problemCard.data("problem-id");
              var testCasesContainer = problemCard.find("tbody");
              var currentTestCaseCount = testCasesContainer[0].childElementCount;

              var newRow =
                "<tr>" +
                "<td>" +
                '<textarea class="form-control" name="problems[' +
                problemId +
                "].testCases[" +
                currentTestCaseCount +
                '].input" rows="1"></textarea>' +
                "</td>" +
                "<td>" +
                '<textarea class="form-control" name="problems[' +
                problemId +
                "].testCases[" +
                currentTestCaseCount +
                '].output"  rows="1" required="true"></textarea>' +
                "</td>" +
                "<td>" +
                '<button type="button" class="btn btn-danger btn-sm delete-btn" onclick="deleteTestCase(this)">Delete</button>' +
                "</td>" +
                "</tr>";
              testCasesContainer.append(newRow);
            }

            function deleteTestCase(button) {
              var testCaseRow = $(button).closest("tr");
              var problemContainer = testCaseRow.closest("tbody");
              var testCaseCount = problemContainer.length;

              // Remove the test case row
              testCaseRow.remove();
              console.log(problemContainer[0].children.length);

              for (
                let index = 0;
                index < problemContainer[0].children.length;
                index++
              ) {
                const element = problemContainer[0].children[index];
                console.log($(element).find("textarea"));

                $(element).find("input, textarea").each(function () {
                  var currentInput = $(this);
                  console.log(currentInput)
                  var inputName = currentInput.attr("name");
                  var updatedInputName = inputName.replace(
                    /testCases\[(\d+)\]/g,
                    "testCases[" + index + "]"
                  );
                  currentInput.attr("name", updatedInputName);

                  // var inputId = currentInput.attr("id");
                  // var updatedInputId = inputId.replace(/testCases\d+/, "testCases"+index);
                  // currentInput.attr("id", updatedInputId);
                });
              }
            }

            function deleteProblem(button) {
              var problemCard = $(button).closest(".card");
              var problemIndex = problemCard.index();
              problemCard.remove();

              // Update problem counter
              problemCount--;

              // Update problem number in UI
              $(".card-header h5.card-title").each(function (index) {
                $(this).text("Problem " + (index + 1));
              });

              // Update input names and IDs for remaining problems
              $(".card").each(function (index) {
                var currentProblem = $(this);
                var currentProblemIndex = currentProblem.index();
                // update data-problem-id
                currentProblem.attr("data-problem-id", currentProblemIndex);

                currentProblem.find("input, textarea").each(function () {
                  var currentInput = $(this);
                  var inputName = currentInput.attr("name");
                  var updatedInputName = inputName.replace(
                    /problems\[(\d+)\]/g,
                    "problems[" + currentProblemIndex + "]"
                  );
                  currentInput.attr("name", updatedInputName);

                  var inputId = currentInput.attr("id");
                  var updatedInputId = inputId.replace(/problem\d+/, "problem" + currentProblemIndex);
                  currentInput.attr("id", updatedInputId);
                });
              });
            }
          </script>
        </body>

        </html>