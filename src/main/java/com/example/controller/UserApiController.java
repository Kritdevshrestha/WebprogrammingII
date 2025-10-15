package com.example.controller;

import com.example.model.User;
import com.example.service.AuthService;
import com.example.dao.UserDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class UserApiController {

    @Autowired
    private AuthService authService;

    @Autowired
    private UserDAO userDAO;

    // Register new user
    @PostMapping("/users/register")
    public ResponseEntity<?> register(@RequestBody User user) {
        try {
            User registeredUser = authService.registerUser(user);
            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("message", "User registered successfully");
            response.put("data", registeredUser);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> error = new HashMap<>();
            error.put("success", false);
            error.put("error", e.getMessage());
            return ResponseEntity.badRequest().body(error);
        }
    }

    // User login
    @PostMapping("/auth/login")
    public ResponseEntity<?> login(@RequestBody Map<String, String> credentials) {
        try {
            String email = credentials.get("email");
            String password = credentials.get("password");

            if (email == null || email.trim().isEmpty()) {
                throw new RuntimeException("Email is required");
            }
            if (password == null || password.trim().isEmpty()) {
                throw new RuntimeException("Password is required");
            }

            User user = authService.loginUser(email, password);
            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("message", "Login successful");
            response.put("data", user);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> error = new HashMap<>();
            error.put("success", false);
            error.put("error", e.getMessage());
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(error);
        }
    }

    // Get all users (Admin only)
    @GetMapping("/users")
    public ResponseEntity<?> getAllUsers(@RequestHeader("Authorization") String token) {
        try {
            // Verify token
            if (token == null || !token.startsWith("Bearer ")) {
                return createErrorResponse("Invalid authorization header", HttpStatus.UNAUTHORIZED);
            }

            String cleanToken = token.replace("Bearer ", "");
            if (!authService.validateToken(cleanToken)) {
                return createErrorResponse("Invalid token", HttpStatus.UNAUTHORIZED);
            }

            // Verify admin privileges
            String email = authService.getEmailFromToken(cleanToken);
            User currentUser = userDAO.findByEmail(email);

            if (currentUser == null) {
                return createErrorResponse("User not found", HttpStatus.NOT_FOUND);
            }

            if (!"admin".equals(currentUser.getUserType())) {
                return createErrorResponse("Access denied. Admin privileges required.", HttpStatus.FORBIDDEN);
            }

            // Get all users
            List<User> users = userDAO.findAllUsers();

            // Remove passwords from response for security
            for (User user : users) {
                user.setPassword(null);
            }

            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("data", users);
            response.put("count", users.size());
            return ResponseEntity.ok(response);

        } catch (Exception e) {
            return createErrorResponse("Server error: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Get user by ID
    @GetMapping("/users/{id}")
    public ResponseEntity<?> getUserById(@PathVariable int id,
                                         @RequestHeader("Authorization") String token) {
        try {
            // Verify token
            if (token == null || !token.startsWith("Bearer ")) {
                return createErrorResponse("Invalid authorization header", HttpStatus.UNAUTHORIZED);
            }

            String cleanToken = token.replace("Bearer ", "");
            if (!authService.validateToken(cleanToken)) {
                return createErrorResponse("Invalid token", HttpStatus.UNAUTHORIZED);
            }

            String email = authService.getEmailFromToken(cleanToken);
            User currentUser = userDAO.findByEmail(email);

            if (currentUser == null) {
                return createErrorResponse("User not found", HttpStatus.NOT_FOUND);
            }

            // Users can only access their own data unless they're admin
            if (currentUser.getId() != id && !"admin".equals(currentUser.getUserType())) {
                return createErrorResponse("Access denied", HttpStatus.FORBIDDEN);
            }

            User user = userDAO.findById(id);
            if (user != null) {
                user.setPassword(null);
                return createSuccessResponse("User found", user);
            }

            return createErrorResponse("User not found", HttpStatus.NOT_FOUND);

        } catch (Exception e) {
            return createErrorResponse("Server error: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Get user profile (current logged-in user)
    @GetMapping("/users/profile")
    public ResponseEntity<?> getProfile(@RequestHeader("Authorization") String token) {
        try {
            if (token == null || !token.startsWith("Bearer ")) {
                return createErrorResponse("Invalid authorization header", HttpStatus.UNAUTHORIZED);
            }

            String cleanToken = token.replace("Bearer ", "");
            if (!authService.validateToken(cleanToken)) {
                return createErrorResponse("Invalid token", HttpStatus.UNAUTHORIZED);
            }

            String email = authService.getEmailFromToken(cleanToken);
            User user = userDAO.findByEmail(email);

            if (user != null) {
                user.setPassword(null);
                return createSuccessResponse("Profile retrieved successfully", user);
            }

            return createErrorResponse("User not found", HttpStatus.NOT_FOUND);

        } catch (Exception e) {
            return createErrorResponse("Server error: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Update user
    @PutMapping("/users/{id}")
    public ResponseEntity<?> updateUser(@PathVariable int id,
                                        @RequestBody User userDetails,
                                        @RequestHeader("Authorization") String token) {
        try {
            // Verify token
            if (token == null || !token.startsWith("Bearer ")) {
                return createErrorResponse("Invalid authorization header", HttpStatus.UNAUTHORIZED);
            }

            String cleanToken = token.replace("Bearer ", "");
            if (!authService.validateToken(cleanToken)) {
                return createErrorResponse("Invalid token", HttpStatus.UNAUTHORIZED);
            }

            String email = authService.getEmailFromToken(cleanToken);
            User currentUser = userDAO.findByEmail(email);

            if (currentUser == null) {
                return createErrorResponse("User not found", HttpStatus.NOT_FOUND);
            }

            // Users can only update their own data unless they're admin
            if (currentUser.getId() != id && !"admin".equals(currentUser.getUserType())) {
                return createErrorResponse("Access denied. You can only update your own profile.", HttpStatus.FORBIDDEN);
            }

            User user = userDAO.findById(id);
            if (user != null) {
                // Update allowed fields
                if (userDetails.getFirstName() != null) {
                    user.setFirstName(userDetails.getFirstName());
                }
                if (userDetails.getLastName() != null) {
                    user.setLastName(userDetails.getLastName());
                }

                // Only admin can change userType
                if ("admin".equals(currentUser.getUserType()) && userDetails.getUserType() != null) {
                    user.setUserType(userDetails.getUserType());
                }

                if (userDAO.updateUser(user)) {
                    user.setPassword(null);
                    return createSuccessResponse("User updated successfully", user);
                }

                return createErrorResponse("Failed to update user", HttpStatus.INTERNAL_SERVER_ERROR);
            }

            return createErrorResponse("User not found", HttpStatus.NOT_FOUND);

        } catch (Exception e) {
            return createErrorResponse("Server error: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Update user password
    @PutMapping("/users/{id}/password")
    public ResponseEntity<?> updatePassword(@PathVariable int id,
                                            @RequestBody Map<String, String> passwordData,
                                            @RequestHeader("Authorization") String token) {
        try {
            // Verify token
            if (token == null || !token.startsWith("Bearer ")) {
                return createErrorResponse("Invalid authorization header", HttpStatus.UNAUTHORIZED);
            }

            String cleanToken = token.replace("Bearer ", "");
            if (!authService.validateToken(cleanToken)) {
                return createErrorResponse("Invalid token", HttpStatus.UNAUTHORIZED);
            }

            String email = authService.getEmailFromToken(cleanToken);
            User currentUser = userDAO.findByEmail(email);

            if (currentUser == null) {
                return createErrorResponse("User not found", HttpStatus.NOT_FOUND);
            }

            // Users can only update their own password unless they're admin
            if (currentUser.getId() != id && !"admin".equals(currentUser.getUserType())) {
                return createErrorResponse("Access denied. You can only update your own password.", HttpStatus.FORBIDDEN);
            }

            String newPassword = passwordData.get("newPassword");

            if (newPassword == null || newPassword.length() < 6) {
                return createErrorResponse("New password must be at least 6 characters long", HttpStatus.BAD_REQUEST);
            }

            User user = userDAO.findById(id);
            if (user != null) {
                if (userDAO.updatePassword(id, newPassword)) {
                    return createSuccessResponse("Password updated successfully", null);
                }
                return createErrorResponse("Failed to update password", HttpStatus.INTERNAL_SERVER_ERROR);
            }

            return createErrorResponse("User not found", HttpStatus.NOT_FOUND);

        } catch (Exception e) {
            return createErrorResponse("Server error: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Delete user (Admin only)
    @DeleteMapping("/users/{id}")
    public ResponseEntity<?> deleteUser(@PathVariable int id,
                                        @RequestHeader("Authorization") String token) {
        try {
            // Verify token
            if (token == null || !token.startsWith("Bearer ")) {
                return createErrorResponse("Invalid authorization header", HttpStatus.UNAUTHORIZED);
            }

            String cleanToken = token.replace("Bearer ", "");
            if (!authService.validateToken(cleanToken)) {
                return createErrorResponse("Invalid token", HttpStatus.UNAUTHORIZED);
            }

            // Verify admin privileges
            String email = authService.getEmailFromToken(cleanToken);
            User currentUser = userDAO.findByEmail(email);

            if (currentUser == null) {
                return createErrorResponse("User not found", HttpStatus.NOT_FOUND);
            }

            if (!"admin".equals(currentUser.getUserType())) {
                return createErrorResponse("Access denied. Admin privileges required.", HttpStatus.FORBIDDEN);
            }

            // Prevent admin from deleting themselves
            if (currentUser.getId() == id) {
                return createErrorResponse("Cannot delete your own account", HttpStatus.BAD_REQUEST);
            }

            User userToDelete = userDAO.findById(id);
            if (userToDelete == null) {
                return createErrorResponse("User not found", HttpStatus.NOT_FOUND);
            }

            if (userDAO.deleteUser(id)) {
                Map<String, Object> deletedUserInfo = new HashMap<>();
                deletedUserInfo.put("id", userToDelete.getId());
                deletedUserInfo.put("email", userToDelete.getEmail());
                deletedUserInfo.put("name", userToDelete.getFirstName() + " " + userToDelete.getLastName());

                Map<String, Object> response = new HashMap<>();
                response.put("success", true);
                response.put("message", "User deleted successfully");
                response.put("deletedUser", deletedUserInfo);
                return ResponseEntity.ok(response);
            }

            return createErrorResponse("Failed to delete user", HttpStatus.INTERNAL_SERVER_ERROR);

        } catch (Exception e) {
            return createErrorResponse("Server error: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Verify token endpoint
    @PostMapping("/auth/verify")
    public ResponseEntity<?> verifyToken(@RequestHeader("Authorization") String token) {
        try {
            if (token == null || !token.startsWith("Bearer ")) {
                return createErrorResponse("Invalid authorization header", HttpStatus.UNAUTHORIZED);
            }

            String cleanToken = token.replace("Bearer ", "");
            if (!authService.validateToken(cleanToken)) {
                Map<String, Object> response = new HashMap<>();
                response.put("success", false);
                response.put("valid", false);
                response.put("error", "Invalid token");
                return ResponseEntity.ok(response);
            }

            String email = authService.getEmailFromToken(cleanToken);
            User user = userDAO.findByEmail(email);

            if (user != null) {
                Map<String, Object> userInfo = new HashMap<>();
                userInfo.put("id", user.getId());
                userInfo.put("email", user.getEmail());
                userInfo.put("firstName", user.getFirstName());
                userInfo.put("lastName", user.getLastName());
                userInfo.put("userType", user.getUserType());

                Map<String, Object> response = new HashMap<>();
                response.put("success", true);
                response.put("valid", true);
                response.put("user", userInfo);
                return ResponseEntity.ok(response);
            }

            return createErrorResponse("User not found", HttpStatus.NOT_FOUND);

        } catch (Exception e) {
            return createErrorResponse("Server error: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Helper methods for consistent responses
    private ResponseEntity<Map<String, Object>> createSuccessResponse(String message, Object data) {
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("message", message);
        if (data != null) {
            response.put("data", data);
        }
        return ResponseEntity.ok(response);
    }

    private ResponseEntity<Map<String, Object>> createErrorResponse(String error, HttpStatus status) {
        Map<String, Object> response = new HashMap<>();
        response.put("success", false);
        response.put("error", error);
        return ResponseEntity.status(status).body(response);
    }
}