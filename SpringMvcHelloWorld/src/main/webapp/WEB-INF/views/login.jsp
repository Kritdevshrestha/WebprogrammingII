<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Login - Perfume Website</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
</head>
<body class="d-flex justify-content-center align-items-center vh-100"
      style="background: url('<c:url value="/resources/images/image.png"/>') no-repeat center center/cover; height:100vh;">

  <div class="container justify-content-center align-items-center flex-grow-1 d-flex">
    <div class="card login-card shadow-lg p-4" style="max-width: 500px; width: 100%;">
      <h3 class="text-center mb-4">Login</h3>
      <form action="login" method="post">
        <div class="mb-3">
          <label class="form-label">Full Name</label>
          <input type="text" name="name" class="form-control" placeholder="Enter your name" required>
        </div>
        <div class="mb-3">
          <label class="form-label">Password</label>
          <input type="password" name="password" class="form-control" placeholder="Enter your password" required>
        </div>
        <button type="submit" class="btn btn-purple w-100">Login</button>
      </form>
      <p class="text-center text-danger mt-2">${error}</p>
      <p class="text-center mt-3">
        Don’t have an account?
        <a href="signup" class="text-purple fw-semibold">Sign Up</a>
      </p>
    </div>
  </div>
</body>
</html>
