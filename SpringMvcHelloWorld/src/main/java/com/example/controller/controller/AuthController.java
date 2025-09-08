package com.example.controller.cotroller;

import com.example.controller.model.User;
import com.example.controller.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    // Show signup page
    @GetMapping("/signup")
    public String showSignupForm(Model model) {
        model.addAttribute("user", new User());
        return "signup";
    }

    // Handle signup form submit
    @PostMapping("/signup")
    public String processSignup(@ModelAttribute("user") User user, Model model) {
        userService.registerUser(user);  // store user in memory
        model.addAttribute("message", "Signup successful!");
        model.addAttribute("username", user.getName());
        return "welcome";  // forwards to welcome.jsp
    }

    // Show login page
    @GetMapping("/login")
    public String showLoginForm(Model model) {
        model.addAttribute("user", new User());
        return "login";
    }

    // Handle login form submit
    @PostMapping("/login")
    public String processLogin(@ModelAttribute("user") User user, Model model) {
        User loggedInUser = userService.login(user.getName(), user.getPassword());
        if (loggedInUser != null) {
            model.addAttribute("message", "Login successful!");
            model.addAttribute("username", loggedInUser.getName());
            return "welcome";
        } else {
            model.addAttribute("error", "Invalid username or password");
            return "login";
        }
    }
}
