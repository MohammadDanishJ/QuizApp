<%@ page isELIgnored="false" %>
  <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
    <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
      <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

        <html>

        <head>
          <title>BRD Maker Checker - Menu</title>

          <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
            integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
            crossorigin="anonymous" />

          <link rel="stylesheet" type="text/css" href="/resources/landing.css">
          <link rel="stylesheet" type="text/css" href="/resources/base.css">
        </head>

        <body>
          <div class="container-sm">
            <nav class="navbar navbar-dark bg-dark mb-2">
              <span class="navbar-brand mb-0 h1">NucCode | Access Denied</span>
            </nav>
            <!-- Contents Below -->

            <div class=" mx-5 flex-center flex-column mt-5 pt-5">
              <h3>
                <spring:message code="heading.accessDenied" />
              </h3>
              <h5 class="text-muted text-center">
                <spring:message code="heading.accessDeniedBody" />
                <strong>
                  <a href="/login">
                    <spring:message code="heading.accessDeniedRedirectLink" />
                  </a>
                </strong>
              </h5>
            </div>


            <!-- Contents Above -->
            <footer class="bg-light text-muted py-3 mt-5 landing-footer">
              <div class="container">
                <div class="row">
                  <div class="col-sm-4">
                    <p class="mb-0">
                      <spring:message code="text.developedBy" /> <strong>Mohd. Danish</strong>
                    </p>
                  </div>
                  <div class="col-sm-4 text-center">
                    <p class="mb-0 display-flex justify-content-center align-items-center">
                      <spring:message code="text.developedWith" />
                      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                        class="bi bi-heart" viewBox="0 0 16 16">
                        <path
                          d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z"
                          fill="#e25555" />
                      </svg>
                      at <strong>NSBT</strong>
                    </p>
                  </div>
                  <div class="col-sm-4 text-right">
                    <p class="mb-0">
                      <spring:message code="text.version" /> 2.1.8
                    </p>
                  </div>
                </div>
              </div>
            </footer>

          </div>
          <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
            integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
            crossorigin="anonymous"></script>
          <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
            integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
            crossorigin="anonymous"></script>
          <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
            integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
            crossorigin="anonymous"></script>
        </body>

        </html>