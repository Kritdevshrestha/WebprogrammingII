<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Register - Perfume Website</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
</head>
<body class="d-flex justify-content-center align-items-center vh-100"
      style="background: url('<c:url value="/resources/images/image.png"/>') no-repeat center center/cover; height:100vh;">

  <div class="card shadow-lg p-4 rounded-4" style="max-width: 500px; width: 100%;">
    <h2 class="text-center text-purple mb-4">Create an Account</h2>

    <form action="signup" method="post">
      <div class="mb-3">
        <label for="name" class="form-label fw-semibold">Full Name</label>
        <input type="text" class="form-control border-purple" id="name" name="name" placeholder="Enter your full name" required>
      </div>

      <div class="mb-3">
        <label for="email" class="form-label fw-semibold">Email Address</label>
        <input type="email" class="form-control border-purple" id="email" name="email" placeholder="Enter your email" required>
      </div>

      <div class="mb-3">
        <label for="phone" class="form-label fw-semibold">Phone Number</label>
        <input type="tel" class="form-control border-purple" id="phone" name="phone" placeholder="e.g. 98xxxxxxx" required>
      </div>

      <div class="mb-3">
        <label for="password" class="form-label fw-semibold">Password</label>
        <input type="password" class="form-control border-purple" id="password" name="password" placeholder="Enter password" required>
      </div>

      <div class="mb-3">
        <label for="address" class="form-label fw-semibold">Address</label>
        <textarea class="form-control border-purple" id="address" name="address" rows="2" placeholder="Enter your address" required></textarea>
      </div>

      <button type="submit" class="btn btn-purple w-100">Register</button>
    </form>

    <p class="text-center mt-3">Already have an account? <a href="login" class="text-purple fw-semibold">Login</a></p>
  </div>
</body>
</html>
