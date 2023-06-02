<%@ page isELIgnored="false" %>
  <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
      <!DOCTYPE html>
      <html>

      <!----------------------------------------------------------------------------------------------->

      <head>
        <title>Code Execution</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

        <!-- ... -->
        <meta name="_csrf" content="${_csrf.token}" />
        <meta name="_csrf_header" content="${_csrf.headerName}" />
        <!-- ... -->

        <style>
          .timer {
            position: fixed;
            top: 0;
            right: 0;
            padding: 1rem 2rem;
            color: #000;
            font-size: 20px;
            z-index: 99;
            background-color: rgba(0, 0, 0, .1);
            backdrop-filter: blur(2px);
            box-shadow: 0 0 16px 4px rgba(0, 0, 0, .5);
            -webkit-box-shadow: 0 0 16px 4px rgba(0, 0, 0, .5);
            -moz-box-shadow: 0 0 16px 4px rgba(0, 0, 0, .5);
            border-radius: 0 0 0 5px;
          }
        </style>
      </head>

      <!----------------------------------------------------------------------------------------------->

      <body>
        <div class="container mt-5">
          <h2>Test Name: ${testDetails.testName}</h2>
          <p>Test Description: ${testDetails.description}</p>
          <span>Test Timing: ${testDetails.testTimer}</span></br>

          <!-- Place this element wherever you want to display the timer -->
          <p class="timer">Time Remaining: <strong><span id="timerDisplay"></span></strong></p>

          </br>
          <form:form id="codeForm" modelAttribute="testSubmission" action="/c/testSubmission" method="POST">
            <form:input type="hidden" name="testDetails.id" id="testDetails.id" path="testDetails.id"
              value="${testDetails.id}" />

            <c:forEach items="${testDetails.problems}" var="problem" varStatus="index">
              <div id="problems-container">
                <div class="card mb-4" data-problem-id="${index.index+1}">
                  <div class="card-header">
                    <h5 class="card-title">Problem ${index.index+1}: ${problem.title}</h5>
                  </div>

                  <div class="card-body">
                    ${problem.description}</br></br>
                    <strong>Test Cases: </strong></br>
                    <table class="table table-striped table-bordered">
                      <thead class="thead-light">
                        <tr>
                          <!-- <th>Test Case Id</th> -->
                          <th>Sample Input</th>
                          <th>Expected Output</th>
                        </tr>
                      </thead>
                      <tbody>
                        <c:forEach items="${problem.testCases}" var="testCase">
                          <tr>
                            <!-- <td>${testCase.id}</td> -->
                            <td>${testCase.input}</td>
                            <td>${testCase.output}</td>
                          </tr>
                        </c:forEach>
                      </tbody>
                    </table>

                    <!-- <form id="codeForm${problem.id}" data-id="${problem.id}" modelAttribute="${codeCapture}"
                    onSubmit="submitForm()"> -->
                    <!----------------------------------------------------------------------------------------->
                    <div class="row mt-4">
                      <div class="col-md-6">
                        <h5>Write Your Code:</h5>
                        <form:input type="hidden" name="problemSubmissions[${index.index}].problemId"
                          id="problemId${problem.id}" path="problemSubmissions[${index.index}].problemId"
                          value="${problem.id}" />
                        <form:textarea id="code${problem.id}" name="problemSubmissions[${index.index}].codeSnippet"
                          class="form-control" rows="10" path="problemSubmissions[${index.index}].codeSnippet" />

                      </div>
                      <div class="col-md-6">
                        <h5>Result:</h5>
                        <pre id="result${problem.id}" class="border p-3"></pre>
                      </div>
                    </div>
                    <button type="button" class="btn btn-secondary mt-3 run-test" data-id="${problem.id}">Run Test
                      Cases</button>
                    <!-- </form> -->
                  </div>
                </div>
            </c:forEach>
            <div class="w-100 d-flex justify-content-center mb-4 pb-4">
              
            <button type="submit" class="btn btn-primary">Submit Test</button>
            </div>
            <div id="resultFinal"></div>
          </form:form>
          <!------------------------------------------------------------------------------------------->

        </div>
        <script>
          // Get the test timer value from the modelAttribute
          var testTimer = "${testDetails.testTimer}";
          var secondsRemaining = testTimer * 60; // Convert minutes to seconds
          var timerInterval;

          // Function to update the timer display
          function updateTimerDisplay() {
            var minutes = Math.floor(secondsRemaining / 60);
            var seconds = secondsRemaining % 60;

            // Format minutes and seconds with leading zeros
            var formattedMinutes = ('0' + minutes).slice(-2);
            var formattedSeconds = ('0' + seconds).slice(-2);

            var timerDisplay = document.getElementById('timerDisplay');
            timerDisplay.innerHTML = formattedMinutes + ':' + formattedSeconds;

            if (secondsRemaining <= 0) {
              clearInterval(timerInterval);
              // Automatically submit the test here
              $("#codeForm").submit();
            } else {
              secondsRemaining--;

              // Change timer color to red when time is below 1 minute
              if (minutes === 0 && seconds <= 59) {
                timerDisplay.style.color = 'red';
              }
            }
          }

          // Start the timer when the page is loaded
          window.onload = function () {
            updateTimerDisplay();
            timerInterval = setInterval(updateTimerDisplay, 1000); // Update the display every second
          };
        </script>



        <script>

          function testCode(e) {
            var id = $(e.currentTarget).data("id");
            var pId = $("#problemId" + id).val()
            var code = $("#code" + id).val()

            var url = "/c/codeCapture";

            var csrfToken = $("meta[name='_csrf']").attr("content");
            var csrfHeader = $("meta[name='_csrf_header']").attr("content");


            $.ajax({
              url: url,
              method: "POST",
              data: {
                problemId: pId,
                codeSnippet: code
              },
              beforeSend: function (xhr) {
                xhr.setRequestHeader(csrfHeader, csrfToken);
              },
              success: function (response) {
                // Update the result element with the execution result
                $("#result" + id).html(response);
              },
              error: function (xhr, status, error) {
                console.error(error);
              },
            });

          }

          $(document).ready(function () {


            $("button.run-test").on("click", testCode)

            // // Submit the code form using AJAX
            // $("form").submit(function (e) {
            //   e.preventDefault(); // Prevent form submission

            //   var form = $(this);
            //   console.log(form)
            //   var formId = form.data("id")
            //   var url = "/c/testSubmision";
            //   var data = form.serialize();
            //   console.log(data)
            //   $.ajax({
            //     url: url,
            //     method: "POST",
            //     data: data,
            //     success: function (response) {
            //       console.log(response);
            //       // Update the result element with the execution result
            //       $("#resultFinal").html(response);
            //     },
            //     error: function (xhr, status, error) {
            //       console.error(error);
            //     },
            //   });
            // });
          });
        </script>

      </body>

      </html>