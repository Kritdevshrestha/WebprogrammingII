package com.example.service;

import com.example.dao.UserDAO;
import com.example.model.User;
import com.example.util.JwtUtil;
import com.example.util.PasswordEncoder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AuthService {

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public User registerUser(User user) {
        // Check if email already exists
        if (userDAO.emailExists(user.getEmail())) {
            throw new RuntimeException("Email already registered");
        }

        // Encode password
        String encodedPassword = passwordEncoder.encode(user.getPassword());
        user.setPassword(encodedPassword);

        // Save user
        int userId = userDAO.saveUser(user);
        if (userId > 0) {
            user.setId(userId);

            // Generate JWT token
            String token = jwtUtil.generateToken(user.getEmail());
            user.setToken(token);
            user.setPassword(null); // Remove password from response

            return user;
        }

        throw new RuntimeException("Failed to create user");
    }

    public User loginUser(String email, String password) {
        User user = userDAO.findByEmail(email);
        if (user != null && passwordEncoder.matches(password, user.getPassword())) {
            // Generate JWT token
            String token = jwtUtil.generateToken(user.getEmail());
            user.setToken(token);
            user.setPassword(null); // Remove password from response
            return user;
        }
        throw new RuntimeException("Invalid email or password");
    }

    public boolean validateToken(String token) {
        return jwtUtil.validateToken(token);
    }

    public String getEmailFromToken(String token) {
        return jwtUtil.getEmailFromToken(token);
    }

    // Add this method to your AuthService class

    public boolean verifyPassword(String rawPassword, String encodedPassword) {
        return passwordEncoder.matches(rawPassword, encodedPassword);
    }
}