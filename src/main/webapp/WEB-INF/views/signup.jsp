<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Signup - Afnan Perfumes</title>

  <!-- Bootstrap & Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

  <style>
    body {
      background: url('<c:url value="/resources/images/image.png"/>') no-repeat center center/cover;
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .signup-card {
      background-color: rgba(255,255,255,0.95);
      border-radius: 15px;
      padding: 30px;
      max-width: 500px;
      width: 100%;
    }

    .btn-purple {
      background-color: #6f42c1;
      color: white;
    }

    .btn-purple:hover {
      background-color: #5932a0;
      color: white;
    }

    .text-purple {
      color: #6f42c1;
    }

    .error {
      color: #dc3545;
      text-align: center;
      font-weight: bold;
    }

    .success-message {
      color: #28a745;
      text-align: center;
      font-weight: bold;
    }

    .password-toggle {
      cursor: pointer;
      position: absolute;
      right: 10px;
      top: 50%;
      transform: translateY(-50%);
    }

    .input-group-wrapper {
      position: relative;
    }
  </style>
</head>
<body>

<div class="container d-flex justify-content-center align-items-center flex-grow-1">
  <div class="card signup-card shadow-lg">

    <h3 class="text-center mb-4">Sign Up</h3>

    <!-- Messages -->
    <c:if test="${not empty error}">
      <div class="error mb-3">${error}</div>
    </c:if>
    <c:if test="${not empty msg}">
      <div class="success-message mb-3">${msg}</div>
    </c:if>

    <form id="signupForm" method="post" action="<c:url value='/signup' />">

      <div class="row mb-3">
        <div class="col">
          <input type="text" id="firstName" name="firstName" class="form-control" placeholder="First Name" required>
        </div>
        <div class="col">
          <input type="text" id="lastName" name="lastName" class="form-control" placeholder="Last Name" required>
        </div>
      </div>

      <div class="mb-3">
        <input type="email" id="signupEmail" name="email" class="form-control" placeholder="Email Address" required>
      </div>

      <div class="mb-3 input-group-wrapper">
        <input type="password" id="signupPassword" name="password" class="form-control" placeholder="Password" required>
        <i class="fa fa-eye password-toggle" onclick="togglePassword('signupPassword', this)"></i>
      </div>

      <div class="mb-3 input-group-wrapper">
        <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Confirm Password" required>
        <i class="fa fa-eye password-toggle" onclick="togglePassword('confirmPassword', this)"></i>
      </div>

      <div class="mb-3">
        <select id="userType" name="userType" class="form-select" required>
          <option value="">I am a...</option>
          <option value="customer">Customer</option>
          <option value="seller">Seller</option>
        </select>
      </div>

      <button type="submit" class="btn btn-purple w-100">Create Account</button>
    </form>

    <p class="text-center mt-3">
      Already have an account?
      <a href="<c:url value='/login' />" class="text-purple fw-semibold">Login here</a>
    </p>

  </div>
</div>

<script>
  // Password toggle
  function togglePassword(id, icon) {
    const input = document.getElementById(id);
    if (input.type === "password") {
      input.type = "text";
      icon.classList.replace("fa-eye", "fa-eye-slash");
    } else {
      input.type = "password";
      icon.classList.replace("fa-eye-slash", "fa-eye");
    }
  }

  // Client-side validation
  document.getElementById("signupForm").addEventListener("submit", function(event) {
    const password = document.getElementById("signupPassword").value.trim();
    const confirmPassword = document.getElementById("confirmPassword").value.trim();

    if (password !== confirmPassword) {
      event.preventDefault();
      alert("Passwords do not match!");
    } else if (password.length < 6) {
      event.preventDefault();
      alert("Password must be at least 6 characters long!");
    }
  });
</script>

</body>
</html>
