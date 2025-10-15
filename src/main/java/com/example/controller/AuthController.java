package com.example.controller;

import com.example.dao.UserDAO;
import com.example.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.util.regex.Pattern;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
public class AuthController {

    @Autowired
    private UserDAO userDAO;

    private static final String EMAIL_REGEX = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";
    private static final Pattern EMAIL_PATTERN = Pattern.compile(EMAIL_REGEX);
    private static final Logger logger = LoggerFactory.getLogger(AuthController.class);

    // Show login page (GET request)
    @GetMapping("/login")
    public String showLogin(Model model) {
        model.addAttribute("error", "");
        model.addAttribute("msg", "");
        return "login";
    }

    // Show signup page (GET request)
    @GetMapping("/signup")
    public String showSignup(Model model) {
        model.addAttribute("error", "");
        return "signup";
    }

    // Handle login form submission (POST request)
    @PostMapping("/login")
    public String login(@RequestParam("email") String email,
                        @RequestParam("password") String password,
                        HttpServletRequest request,
                        Model model) {

        // Trim inputs
        email = email != null ? email.trim() : "";
        password = password != null ? password.trim() : "";

        // Basic validation
        if (email.isEmpty()) {
            model.addAttribute("error", "Email is required!");
            return "login";
        }

        if (password.isEmpty()) {
            model.addAttribute("error", "Password is required!");
            return "login";
        }

        if (!isValidEmail(email)) {
            model.addAttribute("error", "Please enter a valid email address!");
            return "login";
        }

        try {
            User user = userDAO.validateUser(email, password);
            if (user != null) {
                // Store user in session
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                return "redirect:/home"; // Redirect to home page after successful login
            } else {
                model.addAttribute("error", "Invalid email or password!");
                return "login";
            }
        } catch (EmptyResultDataAccessException e) {
            model.addAttribute("error", "Invalid email or password!");
            return "login";
        } catch (Exception e) {
            model.addAttribute("error", "An error occurred during login. Please try again.");
            return "login";
        }
    }

    // Handle signup form submission (POST request)
    @PostMapping("/signup")
    public String signup(@RequestParam("firstName") String firstName,
                         @RequestParam("lastName") String lastName,
                         @RequestParam("email") String email,
                         @RequestParam("password") String password,
                         @RequestParam("confirmPassword") String confirmPassword,
                         @RequestParam("userType") String userType,
                         Model model) {

        // Trim inputs
        firstName = firstName != null ? firstName.trim() : "";
        lastName = lastName != null ? lastName.trim() : "";
        email = email != null ? email.trim() : "";
        password = password != null ? password.trim() : "";
        confirmPassword = confirmPassword != null ? confirmPassword.trim() : "";
        userType = userType != null ? userType.trim() : "";

        // Validation
        if (firstName.isEmpty()) {
            model.addAttribute("error", "First name is required!");
            return "signup";
        }

        if (lastName.isEmpty()) {
            model.addAttribute("error", "Last name is required!");
            return "signup";
        }

        if (email.isEmpty()) {
            model.addAttribute("error", "Email is required!");
            return "signup";
        }

        if (!isValidEmail(email)) {
            model.addAttribute("error", "Please enter a valid email address!");
            return "signup";
        }

        if (password.isEmpty()) {
            model.addAttribute("error", "Password is required!");
            return "signup";
        }

        if (password.length() < 6) {
            model.addAttribute("error", "Password must be at least 6 characters long!");
            return "signup";
        }

        if (!password.equals(confirmPassword)) {
            model.addAttribute("error", "Passwords do not match!");
            return "signup";
        }

        if (userType.isEmpty()) {
            model.addAttribute("error", "Please select a user type!");
            return "signup";
        }

        // Check if email already exists
        if (userDAO.emailExists(email)) {
            model.addAttribute("error", "Email already registered!");
            return "signup";
        }

        try {
            User user = new User();
            user.setFirstName(firstName);
            user.setLastName(lastName);
            user.setEmail(email.toLowerCase());
            user.setPassword(password); // ⚠ In production, use BCrypt encryption
            user.setUserType(userType);

            int result = userDAO.saveUser(user);

            if (result > 0) {
                model.addAttribute("msg", "Account created successfully! Please login.");
                return "login";
            } else {
                model.addAttribute("error", "Failed to create account. Please try again.");
                return "signup";
            }
        } catch (Exception e) {
            model.addAttribute("error", "An error occurred during registration. Please try again.");
            return "signup";
        }
    }

    // Handle logout - POST request
    @PostMapping("/logout")
    public String logout(HttpServletRequest request, Model model) {
        logger.info("Logout endpoint called");

        // Invalidate the session
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // Add logout success message
        model.addAttribute("msg", "You have been logged out successfully.");

        // Redirect to index page
        return "redirect:/index";
    }

    // Optional: Handle GET logout requests (direct URL access)
    @GetMapping("/logout")
    public String showLogout(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/index";
    }

    // Email validation helper method
    public  boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        return EMAIL_PATTERN.matcher(email).matches();
    }

    // Add this method to AuthController for testing purposes
    //public void setUserDAO(UserDAO userDAO) {
    //    this.userDAO = userDAO;
    //}

    public void setUserDAO(com.example.dao.UserDAO userDAO) {
        this.userDAO = userDAO;
    }
}