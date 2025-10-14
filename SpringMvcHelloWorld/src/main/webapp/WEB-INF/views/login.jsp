<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${not empty error}">
    <div class="error">${error}</div>
</c:if>
<c:if test="${not empty msg}">
    <div class="success-message">${msg}</div>
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HarvestHub - Login</title>

    <!-- External CSS -->
    <link rel="stylesheet" href="<c:url value='/resources/css/auth.css' />">
</head>
<body>
    <main class="main-content">
        <div class="auth-container">
            <div class="form-container">
                <div class="logo-section">
                    <div class="logo"><span class="logo-text">HarvestHub</span></div>
                </div>

                <div class="form-wrapper">
                    <div class="form-header">
                        <h2>Welcome Back</h2>
                        <p>Connect with local farmers and get fresh produce</p>
                    </div>
                    <form class="auth-form" id="loginForm" method="post" action="<c:url value='/login' />">
                        <div class="input-group">
                            <label for="loginEmail">Email Address</label>
                            <input type="email" id="loginEmail" name="email" required>
                        </div>
                        <div class="input-group">
                            <label for="loginPassword">Password</label>
                            <input type="password" id="loginPassword" name="password" required>
                            <div class="password-toggle" onclick="togglePassword('loginPassword', this)">see</div>
                        </div>
                        <div class="form-options">
                            <label class="checkbox-container">
                                <input type="checkbox" name="remember"> <span class="checkmark"></span> Remember me
                            </label>
                            <a href="#" class="forgot-password">Forgot Password?</a>
                        </div>
                        <button type="submit" class="submit-btn">Sign In</button>
                    </form>
                    <div class="form-footer">
                        <p>New to HarvestHub? <a href="<c:url value='/signup' />" class="switch-form">Create an account</a></p>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- External JS -->
    <script>
        // Password toggle function
        function togglePassword(inputId, toggleBtn) {
            const input = document.getElementById(inputId);
            if (input.type === 'password') {
                input.type = 'text';
                toggleBtn.textContent = '🙈';
            } else {
                input.type = 'password';
                toggleBtn.textContent = '👁️';
            }
        }

        // Form validation before submission
        document.getElementById('loginForm').addEventListener('submit', (e) => {
            // Get form values
            const email = document.getElementById('loginEmail').value;
            const password = document.getElementById('loginPassword').value;

            // Basic client-side validation
            if (!email || email.trim() === '') {
                e.preventDefault();
                alert('Email is required!');
                return;
            }

            if (!password || password.trim() === '') {
                e.preventDefault();
                alert('Password is required!');
                return;
            }

            // Basic email format validation
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                e.preventDefault();
                alert('Please enter a valid email address!');
                return;
            }

            // If all validations pass, the form will submit normally to the server
        });

        // Floating animation for leaves
        function animateLeaves() {
            const leaves = document.querySelectorAll('.leaf');
            leaves.forEach((leaf, index) => {
                const delay = index * 2;
                leaf.style.animationDelay = `${delay}s`;
            });
        }

        // Initialize animations when page loads
        window.addEventListener('load', () => {
            animateLeaves();
        });
    </script>
</body>
</html>