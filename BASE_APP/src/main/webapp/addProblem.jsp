<%@ page isELIgnored="false" %>
  <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
      <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <!----------------------------------------------------------------------------------------------->

        <head>
          <title>Add Problem</title>
          <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
        </head>

        <!----------------------------------------------------------------------------------------------->

        <body>
          <div class="container">
            <h2 class="mt-4">Add Problem</h2>

            <!------------------------------------------------------------------------------------------->
            <form:form action="/api/addProblem" method="POST" modelAttribute="problem" id="problemForm">
              <div class="form-group">
                <label for="title">Title:</label>

                <!--------------------------------------------------------------------------------------->
                <form:input type="text" class="form-control" id="problemName" path="title" required="true" />
              </div>
              <div class="form-group">
                <label for="description">Description:</label>

                <!--------------------------------------------------------------------------------------->
                <form:textarea class="form-control" id="problemDescription" path="description" rows="3" required="true">
                </form:textarea>
              </div>
              <div id="test-cases-container">

                <!--------------------------------------------------------------------------------------->
                <table class="table table-bordered">
                  <thead>
                    <tr>
                      <th>Input</th>
                      <th>Output</th>
                      <th>Action</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach items="${problemRequest.testCases}" var="testCase" varStatus="status"> </c:forEach>
                  </tbody>
                </table>
              </div>
              <div class="flex align-items-center">
                <button type="button" class="btn btn-secondary" onclick="addTestCase ()">Add New Test Case</button>
                <button type="submit" class="btn btn-primary">Save Problem</button>
              </div>
            </form:form>
          </div>

          <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
          <script>
            var testCaseCount = 0;
            addTestCase();

            function addTestCase() {
              var testCasesContainer = $("#test-cases-container");
              var inputTextarea = document.createElement("textarea");
              inputTextarea.className = "form-control";
              inputTextarea.id = "input" + testCaseCount;
              inputTextarea.name = "testCases[" + testCaseCount + "].input";
              inputTextarea.rows = "1";
              //inputTextarea.required = true;
              var outputTextarea = document.createElement("textarea");
              outputTextarea.className = "form-control";
              outputTextarea.id = "output" + testCaseCount;
              outputTextarea.name = "testCases[" + testCaseCount + "].output";
              outputTextarea.rows = "1";
              //outputTextarea.required = true;
              var inputFormGroup = document.createElement("td");
              inputFormGroup.appendChild(inputTextarea);
              var outputFormGroup = document.createElement("td");
              outputFormGroup.appendChild(outputTextarea);
              var deleteButton = document.createElement("td");
              deleteButton.innerHTML = '<button type="button" class="btn btn-danger btn-sm delete-btn" onclick="deleteTestCase(this)">Delete</button>';
              var testCaseDiv = document.createElement("tr");
              testCaseDiv.appendChild(inputFormGroup);
              testCaseDiv.appendChild(outputFormGroup);
              testCaseDiv.append(deleteButton);
              testCasesContainer.find("tbody").append(testCaseDiv);
              testCaseCount++;
            }

            function deleteTestCase(button) {
              $(button).closest("tr").remove();
            }
          </script>

        </body>

        </html>