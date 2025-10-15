<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Login - Afnan Perfumes</title>

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

    .login-card {
      background-color: rgba(255,255,255,0.95);
      border-radius: 15px;
      padding: 30px;
      max-width: 400px;
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
      margin-bottom: 10px;
    }

    .success-message {
      color: #28a745;
      text-align: center;
      font-weight: bold;
      margin-bottom: 10px;
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
  <div class="card login-card shadow-lg">

    <h3 class="text-center mb-4">Login</h3>

    <!-- Messages -->
    <c:if test="${not empty error}">
      <div class="error">${error}</div>
    </c:if>
    <c:if test="${not empty msg}">
      <div class="success-message">${msg}</div>
    </c:if>

    <form id="loginForm" method="post" action="<c:url value='/login' />">

      <div class="mb-3">
        <input type="email" id="loginEmail" name="email" class="form-control" placeholder="Email Address" required>
      </div>

      <div class="mb-3 input-group-wrapper">
        <input type="password" id="loginPassword" name="password" class="form-control" placeholder="Password" required>
        <i class="fa fa-eye password-toggle" onclick="togglePassword('loginPassword', this)"></i>
      </div>

      <div class="mb-3 d-flex justify-content-between align-items-center">
        <div class="form-check">
          <input class="form-check-input" type="checkbox" name="remember" id="remember">
          <label class="form-check-label" for="remember">Remember me</label>
        </div>
        <a href="#" class="text-purple">Forgot Password?</a>
      </div>

      <button type="submit" class="btn btn-purple w-100">Login</button>

    </form>

    <p class="text-center mt-3">
      New to Afnan Perfumes?
      <a href="<c:url value='/signup' />" class="text-purple fw-semibold">Create an account</a>
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

  // Form validation
  document.getElementById("loginForm").addEventListener("submit", function(event) {
    const email = document.getElementById("loginEmail").value.trim();
    const password = document.getElementById("loginPassword").value.trim();

    if (email === "" || password === "") {
      event.preventDefault();
      alert("Please fill in all fields!");
      return;
    }

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
      event.preventDefault();
      alert("Please enter a valid email address!");
    }
  });
</script>

</body>
</html>
