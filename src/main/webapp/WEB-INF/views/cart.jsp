<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Your Cart - Afnan Perfumes</title>

  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="<c:url value='/resources/css/style.css' />" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

  <style>
    .cart-img {
      width: 70px;
      height: 70px;
      object-fit: cover;
      border-radius: 8px;
    }
    .remove-btn {
      cursor: pointer;
      color: #dc3545;
      font-size: 1.2rem;
    }
    .btn-purple {
      background-color: #a564c6;
      color: white;
      border: none;
    }
    .btn-purple:hover {
      background-color: #8c45ae;
      color: white;
    }
  </style>
</head>
<body>
<div class="container d-flex flex-column min-vh-100">

  <!-- Header -->
  <header class="custom-header">
    <nav class="navbar navbar-expand-md custom-navbar py-3">
      <div class="container">
        <a class="navbar-brand me-3 d-flex align-items-center" href="<c:url value='/home' />">
          <img src="<c:url value='/resources/images/afnanlogo.png' />" alt="Afnan Perfumes Logo" class="logo me-2">
          <span class="fw-bold text-royal-purple">Afnan Perfumes</span>
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive"
                aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarResponsive">
          <form class="d-flex mx-auto my-2 my-md-0 search-form" role="search">
            <input class="form-control me-2 search-input" type="search" placeholder="Search perfumes...">
            <button class="btn btn-search" type="submit">Search</button>
          </form>

          <ul class="navbar-nav ms-auto mb-2 mb-md-0 gap-3">
            <li class="nav-item"><a class="nav-link" href="<c:url value='/home' />">Home</a></li>
            <li class="nav-item"><a class="nav-link" href="<c:url value='/about' />">About</a></li>
            <li class="nav-item"><a class="nav-link" href="<c:url value='/products' />">Products</a></li>
            <li class="nav-item"><a class="nav-link" href="<c:url value='/contact' />">Contact</a></li>
            <li class="nav-item"><a class="nav-link" href="<c:url value='/blogs' />">Blog</a></li>
            <li class="nav-item"><a class="nav-link active" href="<c:url value='/cart' />"><i class="fas fa-shopping-cart"></i> Cart</a></li>

            <c:choose>
              <c:when test="${not empty sessionScope.user}">
                <li class="nav-item"><a class="nav-link"><i class="fas fa-user"></i> ${sessionScope.user.firstName}</a></li>
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

  <!-- Cart Content -->
  <div class="container my-5">
    <h2 class="text-center mb-4 text-royal-purple fw-bold">Your Shopping Cart</h2>

    <c:choose>
      <c:when test="${empty cartItems}">
        <div class="text-center py-5 text-muted">
          <p>Your cart is empty.</p>
          <a href="<c:url value='/products' />" class="btn btn-purple"><i class="fa-solid fa-plus"></i> Shop Now</a>
        </div>
      </c:when>

      <c:otherwise>
        <div class="table-responsive">
          <table class="table table-bordered align-middle text-center">
            <thead style="background-color: #a564c6; color: white;">
              <tr>
                <th>Product</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Total</th>
                <th>Remove</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="item" items="${cartItems}">
                <tr>
                  <td class="d-flex align-items-center justify-content-center gap-3">
                    <img src="<c:url value='${item.image}' />" alt="${item.name}" class="cart-img">
                    <span>${item.name}</span>
                  </td>
                  <td>Rs ${item.price}</td>
                  <td>
                    <form action="<c:url value='/cart/update' />" method="post" class="d-flex justify-content-center align-items-center">
                      <input type="hidden" name="id" value="${item.id}">
                      <input type="number" name="quantity" value="${item.quantity}" min="1" class="form-control" style="width:80px;">
                      <button type="submit" class="btn btn-sm btn-purple ms-2">Update</button>
                    </form>
                  </td>
                  <td>Rs ${item.price * item.quantity}</td>
                  <td>
                    <form action="<c:url value='/cart/remove' />" method="post">
                      <input type="hidden" name="id" value="${item.id}">
                      <button type="submit" class="btn btn-link text-danger remove-btn"><i class="fas fa-trash"></i></button>
                    </form>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>

        <!-- Total and Checkout -->
        <div class="d-flex justify-content-between mt-3 align-items-center">
          <a href="<c:url value='/products' />" class="btn btn-secondary">
            <i class="fa-solid fa-plus"></i> Add More Items
          </a>

          <div class="text-end">
            <h4>Grand Total: <span class="fw-bold text-royal-purple">Rs ${grandTotal}</span></h4>
            <a href="<c:url value='/checkout' />" class="btn btn-purple mt-2">Proceed to Checkout</a>
          </div>
        </div>
      </c:otherwise>
    </c:choose>
  </div>

  <!-- Footer -->
  <footer class="bg-midnight py-5 text-center text-gray-300 mt-auto">
    <p class="mb-0">&copy; 2025 Krit's Perfume Collection | Afnan Perfumes</p>
  </footer>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
