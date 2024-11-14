<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>

    <!-- Bootstrap CSS -->
    <%@include file="../components/all_css.jsp" %>
</head>

<body>
    <!-- Navbar -->
    <%@include file="../components/navbar.jsp" %>
    <!-- Profile Content -->
    <div class="container my-5">
        <h2 class="text-center">User Profile</h2>
        <div class="row justify-content-center">
            <div class="col-md-8">
                <table class="table table-bordered">
                    <tbody>
                        <%
                            // Retrieve user details from session
                            String name = (String) session.getAttribute("user");
                            String email = (String) session.getAttribute("userEmail");
                            String mobile = (String) session.getAttribute("userMobile"); // Assuming mobile is also stored in session
                        %>
                        <tr>
                            <th scope="row">Name</th>
                            <td><%= name != null ? name : "Not Available" %></td>
                        </tr>
                        <tr>
                            <th scope="row">Email</th>
                            <td><%= email != null ? email : "Not Available" %></td>
                        </tr>
                        <tr>
                            <th scope="row">Mobile</th>
                            <td><%= mobile!= null ? mobile : "+91-9045-XXXXXX" %></td>
                        </tr>
                        <tr>
                            <th scope="row">Account Created</th>
                            <td>2023-11-15</td> <!-- Replace with actual account creation date if available -->
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>

</html>
