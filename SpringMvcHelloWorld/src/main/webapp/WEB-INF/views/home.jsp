<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Afnan Perfumes - Home</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
  <div class="container sd-flex flex-column min-vh-100">

    <!-- Header -->
<header class="custom-header">
  <nav class="navbar navbar-expand-md custom-navbar">
    <div class="container">
      <!-- Logo -->
      <a class="navbar-brand me-3" href="index.html">
        <img src="${pageContext.request.contextPath}/resources/images/afnanlogo.png" alt="Logo" class="logo" >
      </a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive"
        aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">

        <form class="d-flex mx-auto my-2 my-md-0 search-form" role="search">
          <input class="form-control me-2 search-input" type="search" placeholder="Search products...">
          <button class="btn btn-search" type="submit">Search</button>
        </form>

        <ul class="navbar-nav ms-auto mb-2 mb-md-0 gap-3">
          <li class="nav-item"><a class="nav-link" href="index.html">Home</a></li>
          <li class="nav-item"><a class="nav-link" href="about.html">About</a></li>
          <li class="nav-item"><a class="nav-link" href="products.html">Products</a></li>
          <li class="nav-item"><a class="nav-link" href="contact.html">Contact</a></li>
          <li class="nav-item"><a class="nav-link" href="blog.html">Blog</a></li>
          <li class="nav-item"><a class="nav-link active" href="cart.html"><i class="fas fa-shopping-cart"></i> Cart</a></li>
          <li class="nav-item"><a class="nav-link" href="login.html"><i class="fas fa-user"></i> Login</a></li>
        </ul>
      </div>
    </div>
  </nav>
</header>






   <!-- Brand Description -->
<section class="brand-description my-4 mx-auto" style="max-width: 1000px";>
  <p>
    Welcome to Krit's Perfume Collection — featuring the elegant range of Afnan Perfumes.
    Our collection is carefully curated to offer you an unforgettable fragrance experience.
  </p>
  <p>
    Each fragrance is crafted with precision, blending exotic ingredients from around the world.
    From timeless classics to modern signatures, our perfumes cater to every mood, occasion, and personality.
  </p>
  <p>
    We believe that a perfume is more than just a scent — it’s a statement, a memory, and a reflection of individuality.
    Explore our selection and find your perfect fragrance that resonates with your style and essence.
  </p>
  <p>
    Shop with confidence knowing that every bottle is made with the highest quality standards,
    ensuring a long-lasting and enchanting aroma that defines sophistication and elegance.
  </p>
</section>


  <!-- New Releases -->
  <section class="new-releases my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <h2>New Releases</h2>
      <a href="all-new-releases.html" class="btn btn-link text-decoration-none" style="color:#5f14ab;">See All Products</a>
    </div>
    <div class="row justify-content-center gx-4 gy-2">
      <div class="col-8 col-md-4">
        <div class="card product-card h-auto">
          <img src="images/9am.png" class="card-img-top" alt="Afnan 9AM" />
          <div class="card-body text-center">
            <h5 class="card-title">Afnan 9AM Edp De Parfum 100ML</h5>
            <p class="price">Rs 5000</p>
            <a href="9am.html" class="btn btn-purple w-100 mb-2">View More</a>
           <a href="cart.html" class="btn btn-purple flex-fill">Add to Cart</a>
          </div>
        </div>
      </div>
      <div class="col-8 col-md-4 col-lg-4">
        <div class="card product-card h-100">
          <img src="images/9amblue.png" class="card-img-top" alt="Afnan 9AM Dive" />
          <div class="card-body text-center">
            <h5 class="card-title">Afnan 9AM Dive Eau De Perfume 100ML</h5>
            <p class="price">Rs 6500</p>
            <a href="9amblue.html" class="btn btn-purple w-100 mb-2">View More</a>
            <a href="cart.html" class="btn btn-purple flex-fill">Add to Cart</a>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- Category Highlights -->
  <section class="category-highlights my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <h2>Category Highlights</h2>
      <a href="all-categories.html" class="btn btn-link text-decoration-none" style="color:#5f14ab;">See All Products</a>
    </div>
    <div class="row justify-content-center gx-4 gy-4">
      <div class="col-8 col-md-4">
        <div class="card product-card h-100">
          <img src="images/9amred.png" class="card-img-top" alt="Men's Collection" />
          <div class="card-body text-center">
            <h5 class="card-title">Men's Collection</h5>
            <a href="category-men.html" class="btn btn-purple w-100">Explore</a>
          </div>
        </div>
      </div>
      <div class="col-8 col-md-4">
        <div class="card product-card h-100">
          <img src="images/9pmblack.png" class="card-img-top" alt="Women's Collection" />
          <div class="card-body text-center">
            <h5 class="card-title">Women's Collection</h5>
            <a href="category-women.html" class="btn btn-purple w-100">Explore</a>
          </div>
        </div>
      </div>
      <div class="col-8 col-md-4">
        <div class="card product-card h-100">
          <img src="images/9pmpurple.png" class="card-img-top" alt="Unisex Collection" />
          <div class="card-body text-center">
            <h5 class="card-title">Unisex Collection</h5>
            <a href="category-unisex.html" class="btn btn-purple w-100">Explore</a>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- Featured Products -->
  <section class="mb-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <h2>Featured Products</h2>
      <a href="all-featured.html" class="btn btn-link text-decoration-none" style="color:#5f14ab;">See All Products</a>
    </div>
    <div class="row justify-content-center gx-4 gy-4">
<div class="col-8 col-md-4">
        <div class="card product-card h-100">
          <img src="images/9am.png" class="card-img-top" alt="Afnan 9AM" />
          <div class="card-body text-center">
            <h5 class="card-title">Afnan 9AM Edp De Parfum 100ML</h5>
            <p class="price">Rs 5000</p>
            <a href="9am.html" class="btn btn-purple w-100 mb-2">View More</a>
            <a href="cart.html" class="btn btn-purple flex-fill">Add to Cart</a>
          </div>
        </div>
      </div>

 <div class="col-8 col-md-4">
        <div class="card product-card h-100">
          <img src="images/9amblue.png" class="card-img-top" alt="Afnan 9AM Dive" />
          <div class="card-body text-center">
            <h5 class="card-title">Afnan 9AM Dive Eau De Perfume 100ML</h5>
            <p class="price">Rs 6500</p>
            <a href="9amblue.html" class="btn btn-purple w-100 mb-2">View More</a>
            <a href="cart.html" class="btn btn-purple flex-fill">Add to Cart</a>
          </div>
        </div>
      </div>

<div class="col-8 col-md-4">
        <div class="card product-card h-auto">
          <img src="images/9amred.png" class="card-img-top" alt="Afnan 9AM Pour Femme" />
          <div class="card-body text-center">
            <h5 class="card-title">Afnan 9AM Pour Femme EDP 100ML</h5>
            <p class="price">Rs 6500</p>
            <a href="9amred.html" class="btn btn-purple w-100 mb-2">View More</a>
            <a href="cart.html" class="btn btn-purple flex-fill">Add to Cart</a>
          </div>
        </div>
      </div>

<div class="col-8 col-md-4">
        <div class="card product-card h-100">
          <img src="images/9pmblack.png" class="card-img-top" alt="Afnan 9PM" />
          <div class="card-body text-center">
            <h5 class="card-title">Afnan 9PM Edp De Parfum 100ML</h5>
            <p class="price">Rs 5000</p>
            <a href="9pmblack.html" class="btn btn-purple w-100 mb-2">View more</a>
           <a href="cart.html" class="btn btn-purple flex-fill">Add to Cart</a>
          </div>
        </div>
      </div>

<div class="col-8 col-md-4">
        <div class="card product-card h-100">
          <img src="images/9pmpurple.png" class="card-img-top" alt="Afnan 9PM Pour Femme" />
          <div class="card-body text-center">
            <h5 class="card-title">Afnan 9PM Pour Femme EDP for Women 100ml</h5>
            <p class="price">Rs 6500</p>
            <a href="9pmpurple.html" class="btn btn-purple w-100 mb-2">View More</a>
            <a href="cart.html" class="btn btn-purple flex-fill">Add to Cart</a>
          </div>
        </div>
      </div>

    </div>
  </section>
  <hr>

  <!-- Customer Ratings -->
  <section class="ratings my-5">
    <h2 class="text-center mb-4">Customer Ratings</h2>
    <div class="row justify-content-center gx-4 gy-4">

      <div class="col-12 col-md-4">
        <div class="card h-100 text-center p-3">
          <h5 class="card-title">Person</h5>
          <p>
            <i class="bi bi-star-fill text-warning"></i>
            <i class="bi bi-star-fill text-warning"></i>
            <i class="bi bi-star-fill text-warning"></i>
            <i class="bi bi-star-fill text-warning"></i>
            <i class="bi bi-star-fill text-warning"></i>
          </p>
          <p>"Amazing fragrance, lasts all day!"</p>
        </div>
      </div>

      <div class="col-12 col-md-4">
        <div class="card h-100 text-center p-3">
          <h5 class="card-title">Person1</h5>
          <p>
            <i class="bi bi-star-fill text-warning"></i>
            <i class="bi bi-star-fill text-warning"></i>
            <i class="bi bi-star-fill text-warning"></i>
            <i class="bi bi-star-fill text-warning"></i>
            <i class="bi bi-star-fill text-warning"></i>
          </p>
          <p>"Beautiful scent, very elegant!"</p>
        </div>
      </div>

      <div class="col-12 col-md-4">
        <div class="card h-100 text-center p-3">
          <h5 class="card-title">Person2</h5>
          <p>
            <i class="bi bi-star-fill text-warning"></i>
            <i class="bi bi-star-fill text-warning"></i>
            <i class="bi bi-star-fill text-warning"></i>
            <i class="bi bi-star-fill text-warning"></i>
            <i class="bi bi-star-fill text-warning"></i>
          </p>
          <p>"Highly recommend these perfumes."</p>
        </div>
      </div>

    </div>
  </section>

    <!-- Footer -->
    <footer>
      <p>&copy; 2025 Krit's Perfume Collection. All rights reserved.</p>
      <p>Contact us at: <a href="mailto:info@afnanperfumes.com">info@afnanperfumes.com</a></p>
    </footer>

  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
