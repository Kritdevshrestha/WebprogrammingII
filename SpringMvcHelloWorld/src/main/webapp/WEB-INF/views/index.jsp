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

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HarvestHub - Fresh Farm Products</title>
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
    <link rel="stylesheet" href="styles.css">
</head>
<body class="bg-gray-50">
   <!-- Header -->
<header class="bg-white shadow-sm sticky top-0 z-50">
  <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
    <div class="flex justify-between items-center py-4">
      <!-- Logo -->
      <a href="<c:url value='/index' />"class="flex items-center hover:opacity-80 transition-opacity">
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

      <!-- Desktop Nav -->
<nav class="hidden md:flex items-center space-x-6">
  <a href="<c:url value='/index' />" class="text-gray-700 hover:text-nature-green">Home</a>
  <span class="text-gray-300">|</span>
  <a href="<c:url value='/about' />" class="text-gray-700 hover:text-nature-green">About</a>
  <span class="text-gray-300">|</span>
  <a href="<c:url value='/products' />" class="text-gray-700 hover:text-nature-green">Shop</a>
  <span class="text-gray-300">|</span>
  <a href="<c:url value='/contact' />" class="text-gray-700 hover:text-nature-green">Contact</a>

  <!-- User Dropdown -->
  <div class="relative">
    <button
      id="userMenuButton"
      class="flex items-center text-gray-700 hover:text-nature-green focus:outline-none">
      User
      <svg class="w-4 h-4 ml-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
          d="M19 9l-7 7-7-7" />
      </svg>
    </button>

    <!-- Dropdown Menu -->
    <div
      id="userDropdown"
      class="absolute hidden right-0 mt-2 w-40 bg-white border border-gray-200 rounded-lg shadow-lg">
      <a href="<c:url value='/login' />"
         class="block px-4 py-2 text-gray-700 hover:bg-gray-100">
         Login
      </a>
      <a href="<c:url value='/signup' />"
         class="block px-4 py-2 text-gray-700 hover:bg-gray-100">
         Signup
      </a>
    </div>
  </div>
</nav>

  <!-- User Dropdown -->


      <!-- Right Side Buttons -->
      <div class="flex items-center space-x-2">
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

      <a href="<c:url value='/index' />" class="block text-gray-700 hover:text-nature-green py-2">Home</a>
      <a href="about.html" class="block text-gray-700 hover:text-nature-green py-2">About</a>
      <a href="products.html" class="block text-gray-700 hover:text-nature-green py-2">Shop</a>
      <a href="contact.html" class="block text-gray-700 hover:text-nature-green py-2">Contact</a>
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
                Fresh Harvest, Delivered to Your Door
            </h1>
            <p class="text-xl text-gray-700 mb-8 max-w-2xl mx-auto">
                Connect directly with local farmers and get the freshest produce straight from the field
            </p>
            <button class="bg-nature-green text-white px-8 py-3 rounded-lg text-lg font-semibold hover:bg-light-green transition-colors">
                Shop Now
            </button>
        </div>
        <!-- Background decoration -->

    </section>

<!-- Featured Products -->
<section class="py-16 bg-white">
  <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
    <h2 class="text-2xl sm:text-3xl font-bold text-center text-nature-green mb-12">
      Featured Products
    </h2>

    <div class="relative">
      <!-- Navigation arrows -->

      <!-- Product carousel container -->
      <div class="overflow-hidden">
        <div
          id="productCarousel"
          class="flex transition-transform duration-300 ease-in-out"
        >
          <!-- First slide -->
          <div class="flex justify-center space-x-4 sm:space-x-8 min-w-full flex-wrap sm:flex-nowrap">
            <div class="flex-shrink-0 w-full sm:w-1/2 max-w-sm">
              <a href="product-tomatoes.html" class="block">
                <div class="bg-gray-200 rounded-lg h-56 sm:h-64 mb-4 overflow-hidden">
                  <img
                    src="Images/tomatoes.jpg"
                    alt="Fresh Tomatoes"
                    class="w-full h-full object-cover"
                  />
                </div>
                <h3 class="font-semibold text-lg sm:text-xl text-gray-800">Fresh Tomatoes</h3>
                <p class="text-2xl sm:text-3xl font-bold text-nature-green">Rs. 49/kg</p>
              </a>
            </div>
            <div class="flex-shrink-0 w-full sm:w-1/2 max-w-sm">
              <a href="product-carrots.html" class="block">
                <div class="bg-gray-200 rounded-lg h-56 sm:h-64 mb-4 overflow-hidden">
                  <img
                    src="Images/carrots.jpg"
                    alt="Organic Carrots"
                    class="w-full h-full object-cover"
                  />
                </div>
                <h3 class="font-semibold text-lg sm:text-xl text-gray-800">Organic Carrots</h3>
                <p class="text-2xl sm:text-3xl font-bold text-nature-green">Rs. 39/kg</p>
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>


    <!-- Newsletter Section -->
    <section class="py-16 bg-gray-100">
        <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
            <h2 class="text-3xl font-bold text-nature-green mb-6">Newsletter</h2>
            <p class="text-gray-600 mb-8 max-w-2xl mx-auto">
                Stay updated with the latest harvest seasons, special offers, and farming tips from our community of local farmers.
            </p>
            <div class="flex flex-col sm:flex-row gap-4 max-w-md mx-auto">
                <input type="email" placeholder="Enter your email" class="flex-1 px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-nature-green focus:border-transparent">
                <button class="bg-nature-green text-white px-6 py-3 rounded-lg font-semibold hover:bg-light-green transition-colors">
                    Subscribe
                </button>
            </div>
        </div>
    </section>

    <!-- Product Grid -->
    <section class="py-16 bg-white">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                <!-- Product 1 -->
                <div class="lg:col-span-1">
                    <a href="product-tomatoes.html" class="block">
                        <div class="bg-gray-200 rounded-lg h-64 mb-4 overflow-hidden">
                            <img src="Images/tomatoes.jpg" alt="Fresh Tomatoes" class="w-full h-full object-cover">
                        </div>
                        <h3 class="font-semibold text-lg text-gray-800">Fresh Tomatoes</h3>
                        <p class="text-2xl font-bold text-nature-green">Rs. 49/kg</p>
                    </a>
                </div>

                <!-- Product 2 -->
                <div class="lg:col-span-1">
                    <a href="product-carrots.html" class="block">
                        <div class="bg-gray-200 rounded-lg h-64 mb-4 overflow-hidden">
                            <img src="Images/carrots.jpg" alt="Organic Carrots" class="w-full h-full object-cover">
                        </div>
                        <h3 class="font-semibold text-lg text-gray-800">Organic Carrots</h3>
                        <p class="text-2xl font-bold text-nature-green">Rs. 39/kg</p>
                    </a>
                </div>

                <!-- Product 3 -->
                <div class="lg:col-span-1">
                    <a href="product-corn.html" class="block">
                        <div class="bg-gray-200 rounded-lg h-64 mb-4 overflow-hidden">
                            <img src="Images/corn.jpg" alt="Sweet Corn" class="w-full h-full object-cover">
                        </div>
                        <h3 class="font-semibold text-lg text-gray-800">Sweet Corn</h3>
                        <p class="text-2xl font-bold text-nature-green">Rs. 29/kg</p>
                    </a>
                </div>

                <!-- Product 4 -->
                <div class="lg:col-span-1">
                    <a href="product-peppers.html" class="block">
                        <div class="bg-gray-200 rounded-lg h-64 mb-4 overflow-hidden">
                            <img src="Images/green_peppers.jpg" alt="Green Peppers" class="w-full h-full object-cover">
                        </div>
                        <h3 class="font-semibold text-lg text-gray-800">Green Peppers</h3>
                        <p class="text-2xl font-bold text-nature-green">Rs. 39/kg</p>
                    </a>
                </div>

                <!-- Product 5 -->
                <div class="lg:col-span-1">
                    <a href="product-lettuce.html" class="block">
                        <div class="bg-gray-200 rounded-lg h-64 mb-4 overflow-hidden">
                            <img src="Images/lettuce.jpg" alt="Fresh Lettuce" class="w-full h-full object-cover">
                        </div>
                        <h3 class="font-semibold text-lg text-gray-800">Fresh Lettuce</h3>
                        <p class="text-2xl font-bold text-nature-green">Rs. 29/kg</p>
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- About Section -->
    <section class="py-16 bg-gray-100">
        <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
            <h2 class="text-3xl font-bold text-nature-green mb-6">About HarvestHub</h2>
            <p class="text-gray-600 text-lg leading-relaxed">
                We connect local farmers with consumers, ensuring fresh, organic produce reaches your table while supporting sustainable farming practices and local communities.
            </p>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-nature-green text-white py-12">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="grid grid-cols-1 md:grid-cols-5 gap-8">
                <!-- Company Info -->
                <div class="md:col-span-1">
                    <div class="w-8 h-8 bg-white rounded flex items-center justify-center mb-4">
                        <svg class="w-5 h-5 text-nature-green" fill="currentColor" viewBox="0 0 20 20">
                            <path d="M10 2L3 7v11h14V7l-7-5z"/>
                        </svg>
                    </div>
                    <p class="text-sm mb-2">Bhaktithapa Road, Baneshwor, Kathmandu</p>
                    <p class="text-sm">© HarvestHub</p>
                </div>

                <!-- Main Menu -->
                <div>
                    <h3 class="font-semibold mb-4">MAIN MENU</h3>
                    <ul class="space-y-2 text-sm">
                        <li><a href="index.html" class="hover:text-pale-green">Home</a></li>
                        <li><a href="about.html" class="hover:text-pale-green">About</a></li>
                        <li><a href="products.html" class="hover:text-pale-green">Shop</a></li>
                        <li><a href="contact.html" class="hover:text-pale-green">Contact</a></li>
                    </ul>
                </div>


                <!-- Discover -->
                <div>
                    <h3 class="font-semibold mb-4">DISCOVER</h3>
                    <ul class="space-y-2 text-sm">
                        <li><a href="blog.html" class="hover:text-pale-green">Blog</a></li>
                    </ul>
                </div>

                <!-- Social Media -->
                <div>
                    <h3 class="font-semibold mb-4">FIND US ON</h3>
                    <ul class="space-y-2 text-sm">
                        <li><a href="#" class="hover:text-pale-green">Facebook</a></li>
                        <li><a href="#" class="hover:text-pale-green">X / Twitter</a></li>
                        <li><a href="#" class="hover:text-pale-green">Instagram</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </footer>
</body>
<script>
document.addEventListener("DOMContentLoaded", () => {
  const userMenuButton = document.getElementById("userMenuButton");
  const userDropdown = document.getElementById("userDropdown");

  userMenuButton.addEventListener("click", (e) => {
    e.stopPropagation(); // prevent immediate close
    userDropdown.classList.toggle("hidden");
  });

  document.addEventListener("click", (e) => {
    if (!userMenuButton.contains(e.target) && !userDropdown.contains(e.target)) {
      userDropdown.classList.add("hidden");
    }
  });
});
</script>


</html>
