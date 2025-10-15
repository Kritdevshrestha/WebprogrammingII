package com.example.integration.controller;

import com.example.controller.UserApiController;
import com.example.model.User;
import com.example.service.AuthService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.web.WebAppConfiguration;

import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = "classpath:test-config.xml")
@WebAppConfiguration
class UserApiControllerIT {

    @Autowired
    private UserApiController userApiController;

    @Autowired
    private AuthService authService;

    private String authToken;

    @BeforeEach
    void setUp() {
        // Register a test user and get token
        User testUser = new User();
        testUser.setFirstName("Test");
        testUser.setLastName("User");
        testUser.setEmail("test@example.com");
        testUser.setPassword("password123");
        testUser.setUserType("user");

        try {
            // Clean up if user exists
            try {
                User existing = authService.loginUser("test@example.com", "password123");
                authToken = existing.getToken();
                return; // User already exists, use existing token
            } catch (Exception e) {
                // User doesn't exist, create new one
            }

            User registeredUser = authService.registerUser(testUser);
            authToken = registeredUser.getToken();
        } catch (Exception e) {
            // If registration fails, try login
            try {
                User loggedInUser = authService.loginUser("test@example.com", "password123");
                authToken = loggedInUser.getToken();
            } catch (Exception ex) {
                fail("Failed to setup test user: " + ex.getMessage());
            }
        }
    }

    @Test
    void testUserProfile_Integration() {
        // Given
        String authorizationHeader = "Bearer " + authToken;

        // When
        ResponseEntity<?> response = userApiController.getProfile(authorizationHeader);

        // Then
        assertNotNull(response);
        assertEquals(200, response.getStatusCodeValue());

        // FIX: Properly handle the response body casting
        Map<String, Object> responseBody = (Map<String, Object>) response.getBody();
        assertNotNull(responseBody);
        assertTrue((Boolean) responseBody.get("success"));

        // The "data" field contains a User object, not a Map
        Object data = responseBody.get("data");
        assertNotNull(data);
        assertTrue(data instanceof User, "Data should be a User object");

        User user = (User) data;
        assertEquals("test@example.com", user.getEmail());
        assertEquals("Test", user.getFirstName());
        assertEquals("User", user.getLastName());
    }

    @Test
    void testVerifyToken_Integration() {
        // Given
        String authorizationHeader = "Bearer " + authToken;

        // When
        ResponseEntity<?> response = userApiController.verifyToken(authorizationHeader);

        // Then
        assertNotNull(response);
        assertEquals(200, response.getStatusCodeValue());

        Map<String, Object> responseBody = (Map<String, Object>) response.getBody();
        assertNotNull(responseBody);
        assertTrue((Boolean) responseBody.get("success"));
        assertTrue((Boolean) responseBody.get("valid"));

        // Check user info in response
        Map<String, Object> userInfo = (Map<String, Object>) responseBody.get("user");
        assertNotNull(userInfo);
        assertEquals("test@example.com", userInfo.get("email"));
    }

    @Test
    void testLogin_Integration() {
        // Given
        String requestBody = """
            {
                "email": "test@example.com",
                "password": "password123"
            }
            """;

        // When
        // This requires a different approach since we need to send JSON
        // For now, let's test through the service directly
        try {
            User user = authService.loginUser("test@example.com", "password123");

            // Then
            assertNotNull(user);
            assertNotNull(user.getToken());
            assertEquals("test@example.com", user.getEmail());
            assertNull(user.getPassword()); // Password should be cleared
        } catch (Exception e) {
            fail("Login should work: " + e.getMessage());
        }
    }

    @Test
    void testRegister_Integration() {
        // Given - create a new unique user
        String uniqueEmail = "newuser_" + System.currentTimeMillis() + "@example.com";
        User newUser = new User();
        newUser.setFirstName("New");
        newUser.setLastName("User");
        newUser.setEmail(uniqueEmail);
        newUser.setPassword("password123");
        newUser.setUserType("user");

        // When
        try {
            User registeredUser = authService.registerUser(newUser);

            // Then
            assertNotNull(registeredUser);
            assertNotNull(registeredUser.getId());
            assertEquals(uniqueEmail, registeredUser.getEmail());
            assertNotNull(registeredUser.getToken());
            assertNull(registeredUser.getPassword()); // Password should be cleared
        } catch (Exception e) {
            fail("Registration should work: " + e.getMessage());
        }
    }
}