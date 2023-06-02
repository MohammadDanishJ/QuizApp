<%@ page isELIgnored="false" %>
    <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <title>Login Page</title>
                    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
                    <style>
                        body {
                            background-color: #f8f9fa;
                        }

                        .container {
                            height: 100vh;
                            display: flex;
                            justify-content: center;
                            align-items: center;
                        }

                        img {
                            height: 100% !important;
                            background-size: cover;
                            box-shadow: 10px 10px 35px 1px rgba(0, 0, 0, 0.75);
                            -webkit-box-shadow: 10px 10px 35px 1px rgba(0, 0, 0, 0.75);
                            -moz-box-shadow: 10px 10px 35px 1px rgba(0, 0, 0, 0.75);
                            border-radius: 5px;
                        }

                        .login-container {
                            max-width: 600px;
                            margin: 0 auto;
                            padding: 40px;
                            background-color: #fff;
                            box-shadow: 10px 10px 35px 1px rgba(0, 0, 0, 0.75);
                            -webkit-box-shadow: 10px 10px 35px 1px rgba(0, 0, 0, 0.75);
                            -moz-box-shadow: 10px 10px 35px 1px rgba(0, 0, 0, 0.75);
                            border-radius: 5px;
                            border-radius: 5px;
                        }

                        .login-container h2 {
                            text-align: center;
                            margin-bottom: 30px;
                        }

                        .login-container form {
                            margin-bottom: 20px;
                        }

                        .login-container label {
                            font-weight: bold;
                        }

                        .login-container input[type="text"],
                        .login-container input[type="password"] {
                            width: 100%;
                            padding: 10px;
                            border: 1px solid #ced4da;
                            border-radius: 5px;
                            outline: none;
                        }

                        .login-container input[type="submit"] {
                            width: 100%;
                            padding: 10px;
                            background-color: #007bff;
                            color: #fff;
                            border: none;
                            border-radius: 5px;
                            cursor: pointer;
                        }

                        .login-container input[type="submit"]:hover {
                            background-color: #0056b3;
                        }

                        .register-link {
                            text-align: center;
                        }
                    </style>
                </head>

                <body>
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-block">
                                <img src="/resources/banner2.jpg" alt="Coding Quiz" class="img-fluid">
                            </div>
                            <div class="col-lg-6">
                                <div class="login-container">
                                    <h2>Register</h2>
                                    <c:if test="${param.error!=null}">
                                        <div class="alert alert-danger">
                                            Invalid username and password.
                                        </div>
                                    </c:if>
                                    <c:if test="${param.logout!=null}">
                                        <div class="alert alert-danger">
                                            You have been logged out
                                        </div>
                                    </c:if>
                                    <form:form action="/register" method="post" modelAttribute="employee">
                                        <div class="form-group">
                                            <label for="username">Username:</label>
                                            <form:input type="text" class="form-control" id="username" name="username"
                                                path="username" />
                                        </div>
                                        <div class="form-group">
                                            <label for="email">Email:</label>
                                            <form:input type="email" class="form-control" id="email" name="email"
                                                path="email" />
                                        </div>
                                        <div class="form-group">
                                            <label for="password">Password:</label>
                                            <form:password class="form-control" id="password" name="password"
                                                path="password" />
                                        </div>
                                        <input type="submit" value="Sign Up" class="btn btn-primary" />
                                    </form:form>
                                    <div class="register-link">
                                        <a href="/login">Already a User? Login here</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
                </body>

                </html>