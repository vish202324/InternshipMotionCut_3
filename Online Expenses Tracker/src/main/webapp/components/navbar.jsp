<%@ page import="jakarta.servlet.http.HttpSession" %>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg bg-primary">
    <div class="container-fluid">
        <a class="navbar-brand" style="color: white;" href="#">Online Expenses Tracker</a>
	<%
	String Test = (String) session.getAttribute("user");
	if(Test != null){
	%>
	        <ul class="navbar-nav ms-auto">
	    <li class="nav-item"><a class="nav-link" style="color: white;" href="home.jsp"><i class="fa-solid fa-house-user"></i>&nbsp;Home</a></li>
        <li class="nav-item"><a class="nav-link" style="color: white;" href="addExpenses.jsp"><i class="fa-solid fa-plus"></i>&nbsp;Add Expenses</a></li>
        <li class="nav-item"><a class="nav-link" style="color: white;" href="viewExpenses.jsp"><i class="fa-solid fa-eye"></i>&nbsp;View Expenses</a></li></ul>
        <%
	}else { 
		%>
	    <ul class="navbar-nav ms-auto"><li class="nav-item"><a class="nav-link" style="color: white;" href="index.jsp"><i class="fa-solid fa-house"></i>&nbsp;Home</a></li></ul>
	<% 
	    } 
	%>

        <!-- Navbar Toggler Button -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <%
                    // Retrieve the username from session to check if user is logged in
                    String userName = (String) session.getAttribute("user");
                    if (userName != null) {
                %>
                <!-- Display user-specific options when logged in -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" style="color: white;" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Welcome, <%=userName%>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">  
                        <li><a class="dropdown-item" href="profile.jsp"><i class="fa-solid fa-circle-user"></i>&nbsp;Profile</a></li>
                        <li><a class="dropdown-item" href="../logout"><i class="fa-solid fa-right-from-bracket"></i>&nbsp;Logout</a></li>
                    </ul>
                </li>
                <%
                    } else {
                %>
                <!-- Show options for non-logged-in users -->
                <li class="nav-item"><a class="nav-link" style="color: white;" href="login.jsp"><i class="fa-solid fa-arrow-right-to-bracket"></i>&nbsp;Login</a></li>
                <li class="nav-item"><a class="nav-link" style="color: white;" href="register.jsp"><i class="fa-solid fa-user-plus"></i>&nbsp;Register</a></li>
                <%
                    }
                %>
            </ul>
        </div>
    </div>
</nav>

<!-- Bootstrap JS and Popper.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.11.6/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.min.js"></script>
