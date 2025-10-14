<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${empty sessionScope.user}">
    <c:redirect url="/login" />
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HarvestHub - Home</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/styles.css' />">
    <script src="<c:url value='/resources/js/script.js' />"></script>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        'nature-green': '#2d5016',
                        'light-green': '#4a7c59',
                        'pale-green': '#a8d5ba',
                        'sage-green': '#6b8e23',
                        'forest-green': '#228b22'
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-gray-50">
   <!-- Header -->
<header class="bg-white shadow-sm sticky top-0 z-50">
  <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
    <div class="flex justify-between items-center py-4">
      <!-- Logo -->
      <a href="<c:url value='/home' />" class="flex items-center hover:opacity-80 transition-opacity">
        <div class="w-8 h-8 bg-nature-green rounded flex items-center justify-center mr-3">
          <svg class="w-5 h-5 text-white" fill="currentColor" viewBox="0 0 20 20">
            <path d="M10 2L3 7v11h14V7l-7-5z" />
          </svg>
        </div>
        <span class="text-lg sm:text-xl font-bold text-nature-green">HarvestHub</span>
      </a>

      <!-- Search Bar (desktop only) -->
      <div class="hidden md:flex flex-1 max-w-md mx-4">
        <div class="relative w-full">
          <input
            type="text"
            placeholder="Search..."
            class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-nature-green focus:border-transparent"
          />
          <svg
            class="absolute left-3 top-2.5 w-4 h-4 text-gray-400"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
            />
          </svg>
        </div>
      </div>

      <!-- Right Side - User Info and Logout -->
      <div class="flex items-center space-x-4">
        <!-- Welcome Message -->
        <c:if test="${not empty sessionScope.user}">
          <span class="hidden md:block text-gray-700">
            Welcome, <span class="font-semibold">${sessionScope.user.firstName}</span>!
          </span>
        </c:if>

        <!-- Logout Button -->
        <c:if test="${not empty sessionScope.user}">
          <form action="<c:url value='/logout' />" method="POST" class="m-0">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <button type="submit" class="bg-red-600 text-white px-4 py-2 rounded-lg hover:bg-red-700 transition-colors">
              Logout
            </button>
          </form>
        </c:if>

        <!-- Cart Button -->
        <button
          class="bg-nature-green text-white px-3 sm:px-4 py-2 rounded-lg flex items-center space-x-2 hover:bg-light-green transition-colors"
        >
          <svg
            class="w-5 h-5"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M3 3h2l.4 2M7 13h10l4-8H5.4m0 0L7 13m0 0l-2.5 5M7 13l2.5 5m6-5v6a2 2 0 01-2 2H9a2 2 0 01-2-2v-6m8 0V9a2 2 0 00-2-2H9a2 2 0 00-2 2v4.01"
            />
          </svg>
          <span class="hidden sm:inline">Your Cart</span>
        </button>

        <!-- Mobile Menu Button -->
        <button
          id="mobileMenuBtn"
          class="md:hidden p-2 rounded-lg hover:bg-gray-100 transition-colors"
        >
          <svg
            class="w-6 h-6 text-gray-600"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M4 6h16M4 12h16M4 18h16"
            />
          </svg>
        </button>
      </div>
    </div>
  </div>

  <!-- Mobile Menu Dropdown -->
  <div id="mobileMenu" class="md:hidden bg-white border-t border-gray-200 hidden">
    <div class="px-4 py-4 space-y-4">
      <!-- Mobile Search -->
      <div class="relative">
        <input
          type="text"
          placeholder="Search..."
          class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-nature-green"
        />
        <svg
          class="absolute left-3 top-2.5 w-4 h-4 text-gray-400"
          fill="none"
          stroke="currentColor"
          viewBox="0 0 24 24"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
          />
        </svg>
      </div>

      <a href="<c:url value='/home' />" class="block text-gray-700 hover:text-nature-green py-2">Home</a>
      <a href="<c:url value='/about' />" class="block text-gray-700 hover:text-nature-green py-2">About</a>
      <a href="<c:url value='/products' />" class="block text-gray-700 hover:text-nature-green py-2">Shop</a>
      <a href="<c:url value='/contact' />" class="block text-gray-700 hover:text-nature-green py-2">Contact</a>

      <!-- Mobile User Options -->
      <c:if test="${not empty sessionScope.user}">
        <div class="border-t pt-4">
          <span class="block px-4 py-2 text-gray-500 text-sm">Welcome, ${sessionScope.user.firstName}</span>
          <form action="<c:url value='/logout' />" method="POST" class="m-0">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <button type="submit" class="w-full text-left px-4 py-2 text-gray-700 hover:bg-gray-100">
              Logout
            </button>
          </form>
        </div>
      </c:if>
    </div>
  </div>
</header>

<script>
  document.getElementById("mobileMenuBtn").addEventListener("click", function () {
    const menu = document.getElementById("mobileMenu");
    menu.classList.toggle("hidden");
  });
</script>

    <!-- Hero Section -->
    <section class="relative bg-gradient-to-r from-pale-green to-light-green py-20">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
            <h1 class="text-4xl md:text-6xl font-bold text-nature-green mb-6">
                Welcome to HarvestHub, <c:if test="${not empty sessionScope.user}">${sessionScope.user.firstName}</c:if>!
            </h1>
            <p class="text-xl text-gray-700 mb-8 max-w-2xl mx-auto">
                Connect directly with local farmers and get the freshest produce straight from the field
            </p>
            <button class="bg-nature-green text-white px-8 py-3 rounded-lg text-lg font-semibold hover:bg-light-green transition-colors">
                Shop Now
            </button>
        </div>
    </section>

    <!-- Featured Products -->
    <section class="py-16 bg-white">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <h2 class="text-2xl sm:text-3xl font-bold text-center text-nature-green mb-12">
                Featured Products
            </h2>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                <!-- Product 1 -->
                <div class="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow">
                    <img src="<c:url value='/resources/images/tomatoes.jpg' />" alt="Fresh Tomatoes" class="w-full h-48 object-cover">
                    <div class="p-6">
                        <h3 class="font-semibold text-lg text-gray-800 mb-2">Fresh Tomatoes</h3>
                        <p class="text-2xl font-bold text-nature-green">Rs. 49/kg</p>
                        <button class="mt-4 bg-nature-green text-white px-4 py-2 rounded hover:bg-light-green transition-colors">
                            Add to Cart
                        </button>
                    </div>
                </div>

                <!-- Product 2 -->
                <div class="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow">
                    <img src="<c:url value='/resources/images/carrots.jpg' />" alt="Organic Carrots" class="w-full h-48 object-cover">
                    <div class="p-6">
                        <h3 class="font-semibold text-lg text-gray-800 mb-2">Organic Carrots</h3>
                        <p class="text-2xl font-bold text-nature-green">Rs. 39/kg</p>
                        <button class="mt-4 bg-nature-green text-white px-4 py-2 rounded hover:bg-light-green transition-colors">
                            Add to Cart
                        </button>
                    </div>
                </div>

                <!-- Product 3 -->
                <div class="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow">
                    <img src="<c:url value='/resources/images/corn.jpg' />" alt="Sweet Corn" class="w-full h-48 object-cover">
                    <div class="p-6">
                        <h3 class="font-semibold text-lg text-gray-800 mb-2">Sweet Corn</h3>
                        <p class="text-2xl font-bold text-nature-green">Rs. 29/kg</p>
                        <button class="mt-4 bg-nature-green text-white px-4 py-2 rounded hover:bg-light-green transition-colors">
                            Add to Cart
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Quick Stats -->
    <section class="py-16 bg-gray-100">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8 text-center">
                <div>
                    <div class="text-3xl font-bold text-nature-green">500+</div>
                    <div class="text-gray-600">Local Farmers</div>
                </div>
                <div>
                    <div class="text-3xl font-bold text-nature-green">1000+</div>
                    <div class="text-gray-600">Fresh Products</div>
                </div>
                <div>
                    <div class="text-3xl font-bold text-nature-green">10,000+</div>
                    <div class="text-gray-600">Happy Customers</div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-nature-green text-white py-12">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
                <div>
                    <div class="w-8 h-8 bg-white rounded flex items-center justify-center mb-4">
                        <svg class="w-5 h-5 text-nature-green" fill="currentColor" viewBox="0 0 20 20">
                            <path d="M10 2L3 7v11h14V7l-7-5z"/>
                        </svg>
                    </div>
                    <p class="text-sm">Bhaktithapa Road, Baneshwor, Kathmandu</p>
                    <p class="text-sm mt-2">© 2024 HarvestHub</p>
                </div>
                <div>
                    <h3 class="font-semibold mb-4">MAIN MENU</h3>
                    <ul class="space-y-2 text-sm">
                        <li><a href="<c:url value='/home' />" class="hover:text-pale-green">Home</a></li>
                        <li><a href="<c:url value='/about' />" class="hover:text-pale-green">About</a></li>
                        <li><a href="<c:url value='/products' />" class="hover:text-pale-green">Shop</a></li>
                        <li><a href="<c:url value='/contact' />" class="hover:text-pale-green">Contact</a></li>
                    </ul>
                </div>
                <div>
                    <h3 class="font-semibold mb-4">ACCOUNT</h3>
                    <ul class="space-y-2 text-sm">
                        <c:choose>
                            <c:when test="${not empty sessionScope.user}">
                                <li><span class="text-pale-green">Logged in as: ${sessionScope.user.firstName}</span></li>
                                <li>
                                    <form action="<c:url value='/logout' />" method="POST" class="m-0">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <button type="submit" class="text-left hover:text-pale-green">Logout</button>
                                    </form>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li><a href="<c:url value='/login' />" class="hover:text-pale-green">Login</a></li>
                                <li><a href="<c:url value='/signup' />" class="hover:text-pale-green">Sign Up</a></li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
                <div>
                    <h3 class="font-semibold mb-4">FOLLOW US</h3>
                    <div class="flex space-x-4">
                        <a href="#" class="hover:text-pale-green">
                            <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
                                <path d="M24 4.557c-.883.392-1.832.656-2.828.775 1.017-.609 1.798-1.574 2.165-2.724-.951.564-2.005.974-3.127 1.195-.897-.957-2.178-1.555-3.594-1.555-3.179 0-5.515 2.966-4.797 6.045-4.091-.205-7.719-2.165-10.148-5.144-1.29 2.213-.669 5.108 1.523 6.574-.806-.026-1.566-.247-2.229-.616-.054 2.281 1.581 4.415 3.949 4.89-.693.188-1.452.232-2.224.084.626 1.956 2.444 3.379 4.6 3.419-2.07 1.623-4.678 2.348-7.29 2.04 2.179 1.397 4.768 2.212 7.548 2.212 9.142 0 14.307-7.721 13.995-14.646.962-.695 1.797-1.562 2.457-2.549z"/>
                            </svg>
                        </a>
                        <a href="#" class="hover:text-pale-green">
                            <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
                                <path d="M12.017 0C5.396 0 .029 5.367.029 11.987c0 5.079 3.158 9.417 7.618 11.174-.105-.949-.199-2.403.042-3.441.219-.937 1.406-5.957 1.406-5.957s-.359-.72-.359-1.781c0-1.663.967-2.911 2.168-2.911 1.024 0 1.518.769 1.518 1.688 0 1.029-.653 2.567-.992 3.992-.285 1.193.6 2.165 1.775 2.165 2.128 0 3.768-2.245 3.768-5.487 0-2.861-2.063-4.869-5.008-4.869-3.41 0-5.409 2.562-5.409 5.199 0 1.033.394 2.143.889 2.741.099.12.112.225.085.345-.09.375-.293 1.199-.334 1.363-.053.225-.172.271-.402.165-1.495-.69-2.433-2.878-2.433-4.646 0-3.776 2.748-7.252 7.92-7.252 4.158 0 7.392 2.967 7.392 6.923 0 4.135-2.607 7.462-6.233 7.462-1.214 0-2.357-.629-2.75-1.378l-.748 2.853c-.271 1.043-1.002 2.35-1.492 3.146C9.57 23.812 10.763 24.009 12.017 24.009c6.624 0 11.99-5.367 11.99-11.988C24.007 5.367 18.641.001 12.017.001z"/>
                            </svg>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </footer>
</body>
</html>