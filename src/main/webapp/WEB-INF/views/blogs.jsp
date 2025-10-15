<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Afnan Perfumes - Blog</title>

    <!-- Styles -->
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css' />">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</head>
<body>

<!-- Header (Same as About/Contact page) -->
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
                    <li class="nav-item"><a class="nav-link" href="<c:url value='/contact' />">Contact</a></li>
                    <li class="nav-item"><a class="nav-link active" href="<c:url value='/blogs' />">Blog</a></li>
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

<!-- Main Content -->
<main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">

    <!-- Hero Section -->
    <div class="text-center mb-12">
        <h1 class="text-4xl font-bold text-royal-purple mb-4">Afnan Perfumes Blog</h1>
        <p class="text-xl text-gray-600 max-w-2xl mx-auto">
            Explore fragrance guides, perfume care tips, and seasonal scent recommendations from Afnan Perfumes.
        </p>
    </div>

    <!-- Blog Entries -->
    <div class="space-y-16">

        <!-- Blog Row 1: Image Left, Text Right -->
        <div class="md:flex md:items-center md:space-x-8">
            <div class="md:w-1/2 text-center mb-6 md:mb-0">
                <img src="<c:url value='/resources/images/blog1.png' />" alt="Fragrance Guide" class="mx-auto rounded shadow">
            </div>
            <div class="md:w-1/2">
                <h3 class="text-2xl font-bold text-royal-purple mb-4">Fragrance Guide: Choosing Your Signature Scent</h3>
                <p class="text-gray-600 mb-4">
                    Perfume is more than just a scent — it’s an expression of who you are. In this guide,
                    we explore how to choose a fragrance that reflects your unique personality and lifestyle.
                    From floral to woody notes, discover what makes a scent truly yours.
                </p>
                <a href="blog.html" class="inline-block bg-royal-purple text-white px-6 py-2 rounded hover:bg-purple-700 transition-colors">
                    Read More
                </a>
            </div>
        </div>
        <hr class="border-gray-300">

        <!-- Blog Row 2: Text Left, Image Right -->
        <div class="md:flex md:items-center md:space-x-8 md:flex-row-reverse">
            <div class="md:w-1/2 text-center mb-6 md:mb-0">
                <img src="<c:url value='/resources/images/blog2.png' />" alt="Perfume Care" class="mx-auto rounded shadow">
            </div>
            <div class="md:w-1/2">
                <h3 class="text-2xl font-bold text-royal-purple mb-4">Perfume Care: Making Your Scent Last Longer</h3>
                <p class="text-gray-600 mb-4">
                    Did you know storing your perfumes the right way makes a huge difference?
                    Learn how to extend the life of your favorite scents and keep them fresh
                    throughout the seasons. Simple tips for maximum fragrance impact.
                </p>
                <a href="blog.html" class="inline-block bg-royal-purple text-white px-6 py-2 rounded hover:bg-purple-700 transition-colors">
                    Read More
                </a>
            </div>
        </div>
        <hr class="border-gray-300">

        <!-- Blog Row 3: Image Left, Text Right -->
        <div class="md:flex md:items-center md:space-x-8">
            <div class="md:w-1/2 text-center mb-6 md:mb-0">
                <img src="<c:url value='/resources/images/blog3.png' />" alt="Seasonal Perfumes" class="mx-auto rounded shadow">
            </div>
            <div class="md:w-1/2">
                <h3 class="text-2xl font-bold text-royal-purple mb-4">Top Perfumes for Every Season</h3>
                <p class="text-gray-600 mb-4">
                    Each season has its perfect scent. From the refreshing florals of spring
                    to the cozy spices of winter, discover our curated perfume recommendations
                    that will make you feel confident all year round.
                </p>
                <a href="blog.html" class="inline-block bg-royal-purple text-white px-6 py-2 rounded hover:bg-purple-700 transition-colors">
                    Read More
                </a>
            </div>
        </div>

    </div>
</main>

<!-- Footer -->
<footer class="bg-midnight py-5 text-center text-gray-300">
    <p class="mb-0">&copy; 2025 Krit's Perfume Collection | Afnan Perfumes</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="<c:url value='/resources/js/script.js' />"></script>
</body>
</html>
