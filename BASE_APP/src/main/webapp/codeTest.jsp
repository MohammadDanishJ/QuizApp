<%@ page isELIgnored="false" %>
  <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
    <!DOCTYPE html>
    <html>

    <!----------------------------------------------------------------------------------------------->

    <head>
      <title>Code Execution</title>
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
      <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    </head>

    <!----------------------------------------------------------------------------------------------->

    <body>
      <div class="container mt-5">
        <h2>Code Execution</h2>

        <!------------------------------------------------------------------------------------------->
        <form id="codeForm" modelAttribute="${codeCapture}">

          <!----------------------------------------------------------------------------------------->
          <div class="row mt-4">
            <div class="col-md-6">
              <h5>Write Your Code:</h5>
              <input type="text" name="problemId" />
              <textarea id="code" name="codeSnippet" class="form-control" rows="10"></textarea>
            </div>
            <div class="col-md-6">
              <h5>Result:</h5>
              <pre id="result" class="border p-3"></pre>
            </div>
          </div>
          <button type="submit" class="btn btn-primary mt-3">Execute</button>
        </form>
      </div>

      <script>
        $(document).ready(function () {
          // Submit the code form using AJAX
          $("#codeForm").submit(function (e) {
            console.log("started");
            e.preventDefault(); // Prevent form submission

            var form = $(this);
            var url = "/api/codeCapture";
            var data = form.serialize();
            $.ajax({
              url: url,
              method: "POST",
              data: data,
              success: function (response) {
                console.log(response);
                // Update the result element with the execution result
                $("#result").html(response);
              },
              error: function (xhr, status, error) {
                console.error(error);
              },
            });
          });
        });
      </script>

    </body>

    </html>