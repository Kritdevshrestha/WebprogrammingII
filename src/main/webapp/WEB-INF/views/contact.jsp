<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Afnan Perfumes</title>

    <!-- Styles -->
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css' />">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</head>
<body>

<!-- Header (Same as About Page) -->
<header class="custom-header">
    <nav class="navbar navbar-expand-md custom-navbar py-3">
        <div class="container">
            <!-- Logo -->
            <a class="navbar-brand me-3 d-flex align-items-center" href="<c:url value='/home' />">
                <img src="<c:url value='/resources/images/afnanlogo.png' />" alt="Afnan Perfumes Logo" class="logo me-2">
                <span class="fw-bold text-royal-purple">Afnan Perfumes</span>
            </a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive"
                    aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarResponsive">
                <!-- Search -->
                <form class="d-flex mx-auto my-2 my-md-0 search-form" role="search">
                    <input class="form-control me-2 search-input" type="search" placeholder="Search perfumes...">
                    <button class="btn btn-search" type="submit">Search</button>
                </form>

                <!-- Nav Links -->
                <ul class="navbar-nav ms-auto mb-2 mb-md-0 gap-3">
                    <li class="nav-item"><a class="nav-link" href="<c:url value='/home' />">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="<c:url value='/about' />">About</a></li>
                    <li class="nav-item"><a class="nav-link" href="<c:url value='/products' />">Products</a></li>
                    <li class="nav-item"><a class="nav-link active" href="<c:url value='/contact' />">Contact</a></li>
                    <li class="nav-item"><a class="nav-link" href="<c:url value='/blogs' />">Blog</a></li>
                    <li class="nav-item"><a class="nav-link" href="<c:url value='/cart' />"><i class="fas fa-shopping-cart"></i> Cart</a></li>

                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <li class="nav-item"><a class="nav-link" href="#"><i class="fas fa-user"></i> ${sessionScope.user.firstName}</a></li>
                            <li class="nav-item">
                                <form action="<c:url value='/logout' />" method="POST" class="m-0">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <button type="submit" class="nav-link btn btn-link p-0 text-decoration-none text-danger">Logout</button>
                                </form>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item"><a class="nav-link" href="<c:url value='/login' />"><i class="fas fa-user"></i> Login</a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>
</header>

<!-- Contact Section -->
<div class="container max-w-7xl mx-auto py-16">
    <div class="row align-items-start">
        <!-- Left: Contact Info -->
        <div class="col-md-5 mb-4">
            <div class="p-4 bg-light rounded shadow">
                <h3 class="text-royal-purple mb-4">Contact Information</h3>
                <p><i class="fa-solid fa-phone me-2 text-royal-purple"></i> +977-9812345678</p>
                <p><i class="fa-solid fa-location-dot me-2 text-royal-purple"></i> Kathmandu, Nepal</p>
                <p><i class="fa-solid fa-envelope me-2 text-royal-purple"></i> krit@afnan.com</p>
                <p><i class="fa-solid fa-briefcase me-2 text-royal-purple"></i> wholesale@afnan.com</p>
                <p class="text-muted mt-3">We'd love to hear from you! Reach out via the form or contact us directly.</p>
            </div>
        </div>

        <!-- Right: Contact Form -->
        <div class="col-md-7">
            <div class="p-4 bg-white rounded shadow">
                <h3 class="text-royal-purple mb-4">Send Us a Message</h3>
                <form action="<c:url value='/submitContact' />" method="post" enctype="multipart/form-data">
                    <div class="row mb-3">
                        <div class="col">
                            <input type="text" name="firstName" placeholder="First Name" class="form-control" required>
                        </div>
                        <div class="col">
                            <input type="text" name="lastName" placeholder="Last Name" class="form-control" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <input type="tel" name="phone" placeholder="Phone Number" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <input type="email" name="email" placeholder="Email" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <textarea name="message" placeholder="Message" rows="4" class="form-control" required></textarea>
                    </div>
                    <div class="mb-3">
                        <input type="file" name="photo" accept="image/*" class="form-control">
                    </div>
                    <button type="submit" class="btn bg-royal-purple text-white w-100">Send Message</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="bg-midnight py-5 text-center text-gray-300">
    <p class="mb-0">&copy; 2025 Krit's Perfume Collection | Afnan Perfumes</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="<c:url value='/resources/js/script.js' />"></script>
</body>
</html>
