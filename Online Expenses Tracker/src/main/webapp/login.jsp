<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - My Website</title>
<%@include file="components/all_css.jsp" %>
</head>

<body>
    <!-- Navbar -->
    <%@include file="components/navbar.jsp" %>
    <!-- Login Form -->
    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <h2 class="text-center">Login</h2>
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
                <form action="userLogin" method="post">
                    <div class="mb-3">
                        <label for="loginEmail" class="form-label">Email address</label>
                        <input type="email" class="form-control" id="loginEmail" placeholder="Enter your email" name="email">
                    </div>
                    <div class="mb-3">
                        <label for="loginPassword" class="form-label">Password</label>
                        <input type="password" class="form-control" id="loginPassword" placeholder="Enter your password" name="password">
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Login</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
