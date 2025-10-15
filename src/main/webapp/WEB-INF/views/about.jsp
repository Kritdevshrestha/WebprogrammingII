<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Afnan Perfumes</title>

    <!-- Styles -->
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css' />">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</head>
<body>

<!-- Header -->
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
                    <li class="nav-item"><a class="nav-link" href="<c:url value='/blogs' />">Blog</a></li>
                    <li class="nav-item"><a class="nav-link active" href="<c:url value='/cart' />"><i class="fas fa-shopping-cart"></i> Cart</a></li>

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

<!-- Sections -->
<div class="container max-w-7xl mx-auto py-16">

    <!-- Our Story Section -->
    <div class="row align-items-center mb-12">
        <div class="col-md-6 text-center">
            <img src="<c:url value='/resources/images/afnanlogo.png' />" alt="Afnan Perfumes" class="img-fluid rounded shadow">
        </div>
        <div class="col-md-6">
            <h3 class="text-royal-purple mb-4">Our Story</h3>
            <p class="text-gray-600 leading-relaxed mb-3">
                Founded with passion and dedication, our goal is to create perfumes that
                not only smell exquisite but also evoke emotions and memories.
            </p>
            <p class="text-gray-600 leading-relaxed mb-4">
                Inspired by timeless scents and modern artistry, our collection celebrates
                every moment — whether stepping into the day or night.
            </p>
            <a href="about.html" class="btn bg-royal-purple text-white rounded-lg">Read More</a>
        </div>
    </div>

    <hr class="mb-12">

    <!-- Craftsmanship Section -->
    <div class="row align-items-center flex-md-row-reverse mb-12">
        <div class="col-md-6 text-center">
            <img src="<c:url value='/resources/images/craftsmen.jpg' />" alt="Luxury Perfume Bottle" class="img-fluid rounded shadow">
        </div>
        <div class="col-md-6">
            <h3 class="text-royal-purple mb-4">Craftsmanship</h3>
            <p class="text-gray-600 leading-relaxed mb-3">
                Every bottle is carefully designed to reflect the essence of sophistication.
                Our artisans combine traditional perfume-making techniques with modern innovation.
            </p>
            <p class="text-gray-600 leading-relaxed mb-4">
                From sourcing the finest ingredients to ensuring a luxurious presentation,
                each detail matters. Our craftsmanship is a reflection of our values: quality,
                passion, and authenticity.
            </p>
            <a href="about.html" class="btn bg-royal-purple text-white rounded-lg">Read More</a>
        </div>
    </div>

    <hr class="mb-12">

    <!-- Our Promise Section -->
    <div class="row align-items-center mb-12">
        <div class="col-md-6 text-center">
            <img src="<c:url value='/resources/images/image.png' />" alt="Perfume Collection" class="img-fluid rounded shadow">
        </div>
        <div class="col-md-6">
            <h3 class="text-royal-purple mb-4">Our Promise</h3>
            <p class="text-gray-600 leading-relaxed mb-3">
                A fragrance is more than just a scent — it is an identity, a memory, a story.
                We promise to deliver experiences that resonate with your soul and bring
                confidence to every step.
            </p>
            <p class="text-gray-600 leading-relaxed mb-4">
                Whether it’s for everyday wear or a special occasion, our perfumes are designed
                to be your signature — bold, elegant, and everlasting.
            </p>
            <a href="about.html" class="btn bg-royal-purple text-white rounded-lg">Read More</a>
        </div>
    </div>

</div>

<!-- Footer -->
<footer class="bg-midnight py-5 text-center text-gray-300">
    <p class="mb-0">&copy; 2025 Krit's Perfume Collection | Afnan Perfumes</p>
</footer>

<script src="<c:url value='/resources/js/script.js' />"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
