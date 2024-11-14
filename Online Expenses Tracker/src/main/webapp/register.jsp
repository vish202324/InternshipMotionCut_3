<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <% request.getSession().setAttribute("formAccessed", true); %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - My Website</title>
    <%@include file="components/all_css.jsp" %>
</head>

<body>
    <!-- Navbar -->
    <%@include file="components/navbar.jsp" %>
    
    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <h2 class="text-center">Register</h2>

                <!-- Display Messages -->
                <%
                    String message = (String) session.getAttribute("message");
                    String messageType = (String) session.getAttribute("messageType");
                    if (message != null && messageType != null) {
                %>
                    <div class="alert alert-<%= messageType %> alert-dismissible fade show" role="alert">
                        <%= message %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <%
                    session.removeAttribute("message");
                    session.removeAttribute("messageType");
                    }
                %>

                <!-- Register Form -->
                <form action="userRegister" method="post">
                    <div class="mb-3">
                        <label for="registerName" class="form-label">Full Name</label>
                        <input type="text" class="form-control" id="registerName" placeholder="Enter your full name" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label for="registerEmail" class="form-label">Email address</label>
                        <input type="email" class="form-control" id="registerEmail" placeholder="Enter your email" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label for="registerPassword" class="form-label">Password</label>
                        <input type="password" class="form-control" id="registerPassword" placeholder="Create a password" name="password" required>
                    </div>
                    <div class="mb-3">
                        <label for="mobile" class="form-label">Mobile No.</label>
                        <input type="tel" class="form-control" id="mobile" placeholder="Enter Mobile No." name="mobile" required>
                    </div>
                    <button type="submit" class="btn btn-success w-100">Register</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
