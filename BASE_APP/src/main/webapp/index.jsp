<!DOCTYPE html>
<html>

<head>
  <title>Coding Quiz App</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: Arial, sans-serif;
    }

    .landing-image {
      position: relative;
      height: 100vh;
      background-image: url('/resources/land2.jpg');
      background-size: cover;
      background-position: center;
      overflow: hidden;
    }

    .overlay {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, 0.6);
      backdrop-filter: blur(2px);
      display: flex;
      justify-content: center;
      align-items: center;
      flex-direction: column;
      text-align: center;
      color: #fff;
    }

    .heading {
      font-size: 48px;
      font-weight: bold;
      margin-bottom: 20px;
    }

    .start-button {
      display: inline-block;
      padding: 10px 20px;
      font-size: 18px;
      background-color: #007bff;
      color: #fff;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      transition: background-color 0.3s;
    }

    .start-button:hover {
      background-color: #0056b3;
    }

    .footer {
      position: fixed !important;
      bottom: 0;
      width: 100vw;
      background-color: #f8f9fa;
      padding: 20px;
      text-align: center;
      color: #969696;
      backdrop-filter: blur(2px);
      background: rgba(255, 255, 255, 0.05);
    }

    .heart{
      color: #ff0000
    }
    .start-button{

      transition: .3s all ease;
      width: 120px;
    }
    .start-button:hover{
      color: #fff;
      text-decoration: none;
      width: 140px;
    }
  </style>
</head>

<body>
  <div class="landing-image">
    <div class="overlay">
      <h1 class="heading">Coding Quiz App</h1>
      <a href="/login" class="start-button">Start App</a>
    </div>
  </div>

  <footer class="footer flex justify-content-between">
    <div class="d-flex justify-content-around w-100">
      <span>Developed by Mohd Danish</span>
      <span>Designed with <span class="heart">&#10084</span> at NSBT</span>
      <span>Version: 1.0.0</span>
    </div>
  </footer>

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script>
    $(document).ready(function () {
      $(".heart").click(function () {
        alert("Designed with love by NSBT!");
      });
    });
  </script>
</body>

</html>