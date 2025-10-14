package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.example.model.User;

@Controller
public class HelloController {

    private static final Logger logger = LoggerFactory.getLogger(HelloController.class);

    // Root -> index.jsp
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String root(Model model) {
        logger.info("Root endpoint called");
        return "index"; // resolves to /WEB-INF/views/index.jsp
    }

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index() {
        logger.info("Index page called");
        return "index";
    }

    // about.jsp
    @RequestMapping(value = "/about", method = RequestMethod.GET)
    public String about() {
        logger.info("About page called");
        return "about";
    }

    // blogs.jsp
    @RequestMapping(value = "/blogs", method = RequestMethod.GET)
    public String blogs() {
        logger.info("Blogs page called");
        return "blogs";
    }

    // cart.jsp
    @RequestMapping(value = "/cart", method = RequestMethod.GET)
    public String cart() {
        logger.info("Cart page called");
        return "cart";
    }

    // contact.jsp
    @RequestMapping(value = "/contact", method = RequestMethod.GET)
    public String contact() {
        logger.info("Contact page called");
        return "contact";
    }

    // error.jsp
    @RequestMapping(value = "/error", method = RequestMethod.GET)
    public String error() {
        logger.info("Error page called");
        return "error";
    }

    // hello.jsp
    @RequestMapping(value = "/hello", method = RequestMethod.GET)
    public String hello(Model model) {
        logger.info("Hello endpoint called");
        model.addAttribute("message", "Hello World from Spring MVC!");
        return "hello";
    }

    // products.jsp
    @RequestMapping(value = "/products", method = RequestMethod.GET)
    public String products() {
        logger.info("Products page called");
        return "products";
    }

    // home.jsp
    @RequestMapping(value = "/home", method = RequestMethod.GET)
    public String home(Model model, HttpServletRequest request) {
        logger.info("Home page called");

        // Check if user is in session
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            model.addAttribute("user", user);
        }

        return "home";
    }

}

