<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${not empty sessionScope.user}">
    <c:redirect url="/home" />
</c:if>

<c:if test="${not empty error}">
    <div class="error">${error}</div>
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Afnan Perfumes - Luxury Fragrances</title>

    <!-- Styles -->
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css' />">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</head>
<body>

<!-- Header (consistent with your main site) -->
<header class="custom-header">
  <nav class="navbar navbar-expand-md custom-navbar py-3">
    <div class="container">
      <!-- Logo -->
      <a class="navbar-brand me-3 d-flex align-items-center" href="<c:url value='/index' />">
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
          <li class="nav-item"><a class="nav-link" href="<c:url value='/index' />">Home</a></li>
          <li class="nav-item"><a class="nav-link" href="<c:url value='/about' />">About</a></li>
          <li class="nav-item"><a class="nav-link" href="<c:url value='/products' />">Products</a></li>
          <li class="nav-item"><a class="nav-link" href="<c:url value='/contact' />">Contact</a></li>
          <li class="nav-item"><a class="nav-link" href="<c:url value='/blogs' />">Blog</a></li>
          <li class="nav-item"><a class="nav-link" href="<c:url value='/cart' />"><i class="fas fa-shopping-cart"></i> Cart</a></li>
          <li class="nav-item"><a class="nav-link" href="<c:url value='/login' />"><i class="fas fa-user"></i> Login</a></li>
        </ul>
      </div>
    </div>
  </nav>
</header>

<!-- Hero Section -->
<section class="hero-section text-center py-20 bg-gradient-royal-lavender text-white">
    <div class="container">
        <h1 class="display-4 fw-bold mb-4">Elegance in Every Bottle</h1>
        <p class="lead mb-5">
            Discover Afnan’s exclusive perfume collection crafted with luxury, sophistication, and timeless aroma.
        </p>
        <a href="<c:url value='/products' />" class="btn btn-purple btn-lg">Explore Collection</a>
    </div>
</section>

<!-- Featured Perfumes -->
<section class="featured-perfumes py-16 bg-soft-gray">
    <div class="container">
        <h2 class="text-center text-royal-purple fw-bold mb-12">Featured Fragrances</h2>
        <div class="row g-4">
            <div class="col-12 col-md-4">
                <div class="card product-card">
                    <img src="<c:url value='/resources/images/9am.png' />" class="card-img-top" alt="Afnan 9AM">
                    <div class="card-body text-center">
                        <h5 class="card-title">Afnan 9AM</h5>
                        <p class="price">Rs. 5000</p>
                        <a href="<c:url value='/product/9am' />" class="btn btn-purple w-100 mb-2">View More</a>
                    </div>
                </div>
            </div>
            <div class="col-12 col-md-4">
                <div class="card product-card">
                    <img src="<c:url value='/resources/images/9amblue.png' />" class="card-img-top" alt="Afnan 9AM Dive">
                    <div class="card-body text-center">
                        <h5 class="card-title">Afnan 9AM Dive</h5>
                        <p class="price">Rs. 6500</p>
                        <a href="<c:url value='/product/9amblue' />" class="btn btn-purple w-100 mb-2">View More</a>
                    </div>
                </div>
            </div>
            <div class="col-12 col-md-4">
                <div class="card product-card">
                    <img src="<c:url value='/resources/images/9pmpurple.png' />" class="card-img-top" alt="Afnan 9PM Pour Femme">
                    <div class="card-body text-center">
                        <h5 class="card-title">Afnan 9PM Pour Femme</h5>
                        <p class="price">Rs. 6500</p>
                        <a href="<c:url value='/product/9pmpurple' />" class="btn btn-purple w-100 mb-2">View More</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- About Section -->
<section class="about-section py-16 bg-white text-center">
    <div class="container max-w-4xl mx-auto">
        <h2 class="text-3xl fw-bold text-royal-purple mb-6">About Afnan Perfumes</h2>
        <p class="text-gray-600 lead">
            Afnan Perfumes combines art and science to create fragrances that reflect elegance, confidence, and personality.
            Each scent is crafted using the finest ingredients to deliver an unforgettable olfactory experience.
        </p>
    </div>
</section>

<!-- Footer -->
<footer class="bg-midnight py-5 text-center text-gray-300">
  <p class="mb-0">&copy; 2025 Krit's Perfume Collection | Afnan Perfumes</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
