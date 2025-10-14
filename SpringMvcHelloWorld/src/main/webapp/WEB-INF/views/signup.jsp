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
    <title>HarvestHub - Signup</title>

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
                        <h2>Join HarvestHub</h2>
                        <p>Start your journey to fresh, local produce</p>
                    </div>
                    <form class="auth-form" id="signupForm" method="post" action="<c:url value='/signup' />">
                        <div class="input-row">
                            <div class="input-group">
                                <label for="firstName">First Name</label>
                                <input type="text" id="firstName" name="firstName" required>
                            </div>
                            <div class="input-group">
                                <label for="lastName">Last Name</label>
                                <input type="text" id="lastName" name="lastName" required>
                            </div>
                        </div>
                        <div class="input-group">
                            <label for="signupEmail">Email Address</label>
                            <input type="email" id="signupEmail" name="email" required>
                        </div>
                        <div class="input-group">
                            <label for="signupPassword">Password</label>
                            <input type="password" id="signupPassword" name="password" required>
                            <div class="password-toggle" onclick="togglePassword('signupPassword', this)">see</div>
                        </div>
                        <div class="input-group">
                            <label for="confirmPassword">Confirm Password</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" required>
                            <div class="password-toggle" onclick="togglePassword('confirmPassword', this)">see</div>
                        </div>
                        <div class="input-group">
                            <label for="userType">I am a:</label>
                            <select id="userType" name="userType" required>
                                <option value="">Select...</option>
                                <option value="customer">Customer</option>
                                <option value="farmer">Local Farmer</option>
                            </select>
                        </div>
                        <div class="form-options">
                            <label class="checkbox-container">
                                <input type="checkbox" name="terms" required> <span class="checkmark"></span> I agree to the
                                <a href="#" class="terms-link">Terms & Conditions</a>
                            </label>
                        </div>
                        <button type="submit" class="submit-btn">Create Account</button>
                    </form>
                    <div class="form-footer">
                        <p>Already have an account? <a href="<c:url value='/login' />" class="switch-form">Sign in here</a></p>
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
        document.getElementById('signupForm').addEventListener('submit', (e) => {
            // Get form values
            const password = document.getElementById('signupPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const termsChecked = document.querySelector('input[name="terms"]').checked;

            // Client-side validation
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Passwords do not match!');
                return;
            }

            if (password.length < 6) {
                e.preventDefault();
                alert('Password must be at least 6 characters long!');
                return;
            }

            if (!termsChecked) {
                e.preventDefault();
                alert('Please accept the Terms & Conditions to continue.');
                return;
            }

            // If all validations pass, the form will submit normally to the server
        });

        // Real-time password confirmation
        document.getElementById('confirmPassword').addEventListener('input', function() {
            const password = document.getElementById('signupPassword').value;
            const confirmPassword = this.value;

            if (confirmPassword && password !== confirmPassword) {
                this.style.borderColor = '#e74c3c';
            } else if (confirmPassword && password === confirmPassword) {
                this.style.borderColor = '#27ae60';
            } else {
                this.style.borderColor = 'rgba(168, 213, 186, 0.3)';
            }
        });

        // Floating animation for leaves
        function animateLeaves() {
            const leaves = document.querySelectorAll('.leaf');
            leaves.forEach((leaf, index) => {
                const delay = index * 1.5;
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