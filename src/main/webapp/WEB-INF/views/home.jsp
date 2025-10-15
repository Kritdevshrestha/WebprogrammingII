<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${empty sessionScope.user}">
    <c:redirect url="/login" />
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Afnan Perfumes - Home</title>

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
          <li class="nav-item"><a class="nav-link" href="<c:url value='/blog' />">Blog</a></li>
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

<!-- Brand Description -->
<section class="brand-description my-5 mx-auto text-center max-w-4xl">
  <p>Welcome to Krit's Perfume Collection — featuring the elegant range of Afnan Perfumes.
     Our collection is carefully curated to offer you an unforgettable fragrance experience.</p>
  <p>Each fragrance is crafted with precision, blending exotic ingredients from around the world.
     From timeless classics to modern signatures, our perfumes cater to every mood, occasion, and personality.</p>
  <p>We believe that a perfume is more than just a scent — it’s a statement, a memory, and a reflection of individuality.
     Explore our selection and find your perfect fragrance that resonates with your style and essence.</p>
</section>

<!-- New Releases -->
<section class="new-releases my-5 container">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h2>New Releases</h2>
    <a href="<c:url value='/all-new-releases' />" class="btn btn-link">See All Products</a>
  </div>
  <div class="row justify-content-center gx-4 gy-4">
    <div class="col-8 col-md-4 mb-4">
      <div class="card product-card">
        <img src="<c:url value='/resources/images/9am.png' />" class="card-img-top" alt="Afnan 9AM" />
        <div class="card-body text-center">
          <h5 class="card-title">Afnan 9AM Edp De Parfum 100ML</h5>
          <p class="price">Rs 5000</p>
          <a href="<c:url value='/9am' />" class="btn btn-purple w-100 mb-2">View More</a>
          <a href="<c:url value='/cart' />" class="btn btn-purple w-100">Add to Cart</a>
        </div>
      </div>
    </div>

    <div class="col-8 col-md-4 mb-4">
      <div class="card product-card">
        <img src="<c:url value='/resources/images/9amblue.png' />" class="card-img-top" alt="Afnan 9AM Dive" />
        <div class="card-body text-center">
          <h5 class="card-title">Afnan 9AM Dive Eau De Perfume 100ML</h5>
          <p class="price">Rs 6500</p>
          <a href="<c:url value='/9amblue' />" class="btn btn-purple w-100 mb-2">View More</a>
          <a href="<c:url value='/cart' />" class="btn btn-purple w-100">Add to Cart</a>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Category Highlights -->
<section class="category-highlights my-5 container">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h2>Category Highlights</h2>
    <a href="<c:url value='/all-categories' />" class="btn btn-link">See All Products</a>
  </div>
  <div class="row justify-content-center gx-4 gy-4">
    <div class="col-8 col-md-4 mb-4">
      <div class="card product-card">
        <img src="<c:url value='/resources/images/9amred.png' />" class="card-img-top" alt="Men's Collection" />
        <div class="card-body text-center">
          <h5 class="card-title">Men's Collection</h5>
          <a href="<c:url value='/category-men' />" class="btn btn-purple w-100">Explore</a>
        </div>
      </div>
    </div>
    <div class="col-8 col-md-4 mb-4">
      <div class="card product-card">
        <img src="<c:url value='/resources/images/9pmblack.png' />" class="card-img-top" alt="Women's Collection" />
        <div class="card-body text-center">
          <h5 class="card-title">Women's Collection</h5>
          <a href="<c:url value='/category-women' />" class="btn btn-purple w-100">Explore</a>
        </div>
      </div>
    </div>
    <div class="col-8 col-md-4 mb-4">
      <div class="card product-card">
        <img src="<c:url value='/resources/images/9pmpurple.png' />" class="card-img-top" alt="Unisex Collection" />
        <div class="card-body text-center">
          <h5 class="card-title">Unisex Collection</h5>
          <a href="<c:url value='/category-unisex' />" class="btn btn-purple w-100">Explore</a>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Footer -->
<footer class="bg-midnight py-5 text-center text-gray-300">
  <p class="mb-0">&copy; 2025 Krit's Perfume Collection | Afnan Perfumes</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
