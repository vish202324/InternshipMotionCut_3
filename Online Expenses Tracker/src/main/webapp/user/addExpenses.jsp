<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Expenses</title>
<!-- Bootstrap CSS -->
<%@include file="../components/all_css.jsp"%>
</head>
<body>
	<!-- Navbar -->
	<%@include file="../components/navbar.jsp"%>
	<div class="container mt-5">
		<h2 class="text-center mb-4">Add Expense</h2>	
		<div class="row justify-content-center">
			<div class="col-md-6">
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
				<form action="../AddExpenseServlet" method="post">
					<div class="mb-3">
						<label for="title" class="form-label">Title</label> <input
							type="text" class="form-control" id="title" name="title"
							required>
					</div>
					<div class="mb-3">
						<label for="date" class="form-label">Date</label> <input
							type="date" class="form-control" id="date" name="date" required>
					</div>
					<div class="mb-3">
						<label for="category" class="form-label">Category</label> <input
							type="text" class="form-control" id="category" name="category"
							required>
					</div>
					<div class="mb-3">
						<label for="amount" class="form-label">Amount</label> <input
							type="number" class="form-control" id="amount" name="amount"
							required>
					</div>
					<div class="mb-3">
						<label for="description" class="form-label">Description</label>
						<textarea class="form-control" id="description" name="description"
							rows="3"></textarea>
					</div>
					<button type="submit" class="btn btn-primary w-100">Add
						Expense</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>