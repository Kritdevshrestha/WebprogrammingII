package com.example.unit.controller;

import com.example.controller.UserApiController;
import com.example.model.User;
import com.example.service.AuthService;
import com.example.dao.UserDAO;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class UserCrudTest {

    @Mock
    private AuthService authService;

    @Mock
    private UserDAO userDAO;

    @InjectMocks
    private UserApiController userApiController;

    private User testUser;
    private User adminUser;
    private String validToken;
    private String adminToken;

    @BeforeEach
    void setUp() {
        // Regular user
        testUser = new User();
        testUser.setId(1);
        testUser.setFirstName("John");
        testUser.setLastName("Doe");
        testUser.setEmail("user@example.com");
        testUser.setPassword("password123");
        testUser.setUserType("user");

        // Admin user
        adminUser = new User();
        adminUser.setId(2);
        adminUser.setFirstName("Admin");
        adminUser.setLastName("User");
        adminUser.setEmail("admin@example.com");
        adminUser.setPassword("admin123");
        adminUser.setUserType("admin");

        validToken = "user-token-123";
        adminToken = "admin-token-456";
    }

    // ===== CREATE OPERATIONS =====

    @Test
    void testCreateUser_Registration_Success() {
        // Given
        User newUser = new User();
        newUser.setFirstName("New");
        newUser.setLastName("User");
        newUser.setEmail("new@example.com");
        newUser.setPassword("password123");
        newUser.setUserType("user");

        User registeredUser = new User();
        registeredUser.setId(3);
        registeredUser.setFirstName("New");
        registeredUser.setLastName("User");
        registeredUser.setEmail("new@example.com");
        registeredUser.setUserType("user");
        registeredUser.setToken("new-token");

        when(authService.registerUser(any(User.class))).thenReturn(registeredUser);

        // When
        ResponseEntity<?> response = userApiController.register(newUser);

        // Then
        assertEquals(HttpStatus.OK, response.getStatusCode());

        Map<String, Object> responseBody = (Map<String, Object>) response.getBody();
        assertTrue((Boolean) responseBody.get("success"));
        assertEquals("User registered successfully", responseBody.get("message"));

        User responseUser = (User) responseBody.get("data");
        assertEquals("new@example.com", responseUser.getEmail());
        assertNotNull(responseUser.getToken());
        assertNull(responseUser.getPassword()); // Password should be cleared

        verify(authService).registerUser(any(User.class));
    }

    @Test
    void testCreateUser_Registration_EmailExists() {
        // Given
        User existingUser = new User();
        existingUser.setEmail("existing@example.com");

        when(authService.registerUser(any(User.class)))
                .thenThrow(new RuntimeException("Email already registered"));

        // When
        ResponseEntity<?> response = userApiController.register(existingUser);

        // Then
        assertEquals(HttpStatus.BAD_REQUEST, response.getStatusCode());

        Map<String, Object> responseBody = (Map<String, Object>) response.getBody();
        assertFalse((Boolean) responseBody.get("success"));
        assertTrue(responseBody.get("error").toString().contains("already registered"));

        verify(authService).registerUser(any(User.class));
    }

    // ===== READ OPERATIONS =====

    @Test
    void testReadUser_GetProfile_Success() {
        // Given
        String authHeader = "Bearer " + validToken;

        when(authService.validateToken(validToken)).thenReturn(true);
        when(authService.getEmailFromToken(validToken)).thenReturn("user@example.com");
        when(userDAO.findByEmail("user@example.com")).thenReturn(testUser);

        // When
        ResponseEntity<?> response = userApiController.getProfile(authHeader);

        // Then
        assertEquals(HttpStatus.OK, response.getStatusCode());

        Map<String, Object> responseBody = (Map<String, Object>) response.getBody();
        assertTrue((Boolean) responseBody.get("success"));

        User responseUser = (User) responseBody.get("data");
        assertEquals("user@example.com", responseUser.getEmail());
        assertNull(responseUser.getPassword()); // Password should be cleared

        verify(authService).validateToken(validToken);
        verify(userDAO).findByEmail("user@example.com");
    }

    @Test
    void testReadUser_GetProfile_InvalidToken() {
        // Given
        String authHeader = "Bearer invalid-token";

        when(authService.validateToken("invalid-token")).thenReturn(false);

        // When
        ResponseEntity<?> response = userApiController.getProfile(authHeader);

        // Then
        assertEquals(HttpStatus.UNAUTHORIZED, response.getStatusCode());

        Map<String, Object> responseBody = (Map<String, Object>) response.getBody();
        assertFalse((Boolean) responseBody.get("success"));
        assertEquals("Invalid token", responseBody.get("error"));

        verify(authService).validateToken("invalid-token");
    }

    @Test
    void testReadUser_GetUserById_Success() {
        // Given
        String authHeader = "Bearer " + validToken;
        int userId = 1;

        when(authService.validateToken(validToken)).thenReturn(true);
        when(authService.getEmailFromToken(validToken)).thenReturn("user@example.com");
        when(userDAO.findByEmail("user@example.com")).thenReturn(testUser);
        when(userDAO.findById(userId)).thenReturn(testUser);

        // When
        ResponseEntity<?> response = userApiController.getUserById(userId, authHeader);

        // Then
        assertEquals(HttpStatus.OK, response.getStatusCode());

        Map<String, Object> responseBody = (Map<String, Object>) response.getBody();
        assertTrue((Boolean) responseBody.get("success"));

        User responseUser = (User) responseBody.get("data");
        assertEquals(userId, responseUser.getId());
        assertNull(responseUser.getPassword()); // Password should be cleared

        verify(userDAO).findById(userId);
    }


    @Test
    void testReadUser_GetAllUsers_AdminSuccess() {
        // Given
        String authHeader = "Bearer " + adminToken;
        List<User> users = Arrays.asList(testUser, adminUser);

        when(authService.validateToken(adminToken)).thenReturn(true);
        when(authService.getEmailFromToken(adminToken)).thenReturn("admin@example.com");
        when(userDAO.findByEmail("admin@example.com")).thenReturn(adminUser);
        when(userDAO.findAllUsers()).thenReturn(users);

        // When
        ResponseEntity<?> response = userApiController.getAllUsers(authHeader);

        // Then
        assertEquals(HttpStatus.OK, response.getStatusCode());

        Map<String, Object> responseBody = (Map<String, Object>) response.getBody();
        assertTrue((Boolean) responseBody.get("success"));

        List<User> responseUsers = (List<User>) responseBody.get("data");
        assertEquals(2, responseUsers.size());

        // Verify passwords are cleared
        for (User user : responseUsers) {
            assertNull(user.getPassword());
        }

        verify(userDAO).findAllUsers();
    }

    @Test
    void testReadUser_GetAllUsers_NonAdminForbidden() {
        // Given
        String authHeader = "Bearer " + validToken;

        when(authService.validateToken(validToken)).thenReturn(true);
        when(authService.getEmailFromToken(validToken)).thenReturn("user@example.com");
        when(userDAO.findByEmail("user@example.com")).thenReturn(testUser);

        // When
        ResponseEntity<?> response = userApiController.getAllUsers(authHeader);

        // Then
        assertEquals(HttpStatus.FORBIDDEN, response.getStatusCode());

        Map<String, Object> responseBody = (Map<String, Object>) response.getBody();
        assertFalse((Boolean) responseBody.get("success"));
        assertTrue(responseBody.get("error").toString().contains("Admin privileges"));

        verify(userDAO, never()).findAllUsers();
    }

    // ===== UPDATE OPERATIONS =====

    @Test
    void testUpdateUser_UpdateProfile_Success() {
        // Given
        String authHeader = "Bearer " + validToken;
        int userId = 1;

        User updatedDetails = new User();
        updatedDetails.setFirstName("JohnUpdated");
        updatedDetails.setLastName("DoeUpdated");

        User existingUser = new User();
        existingUser.setId(userId);
        existingUser.setFirstName("John");
        existingUser.setLastName("Doe");
        existingUser.setEmail("user@example.com");
        existingUser.setUserType("user");

        when(authService.validateToken(validToken)).thenReturn(true);
        when(authService.getEmailFromToken(validToken)).thenReturn("user@example.com");
        when(userDAO.findByEmail("user@example.com")).thenReturn(existingUser);
        when(userDAO.findById(userId)).thenReturn(existingUser);
        when(userDAO.updateUser(any(User.class))).thenReturn(true);

        // When
        ResponseEntity<?> response = userApiController.updateUser(userId, updatedDetails, authHeader);

        // Then
        assertEquals(HttpStatus.OK, response.getStatusCode());

        Map<String, Object> responseBody = (Map<String, Object>) response.getBody();
        assertTrue((Boolean) responseBody.get("success"));
        assertEquals("User updated successfully", responseBody.get("message"));

        User responseUser = (User) responseBody.get("data");
        assertEquals("JohnUpdated", responseUser.getFirstName());
        assertEquals("DoeUpdated", responseUser.getLastName());

        verify(userDAO).updateUser(any(User.class));
    }

    @Test
    void testUpdateUser_UpdateOtherUser_Forbidden() {
        // Given
        String authHeader = "Bearer " + validToken;
        int otherUserId = 999; // Different user ID

        User updatedDetails = new User();
        updatedDetails.setFirstName("Hacked");

        when(authService.validateToken(validToken)).thenReturn(true);
        when(authService.getEmailFromToken(validToken)).thenReturn("user@example.com");
        when(userDAO.findByEmail("user@example.com")).thenReturn(testUser);

        // When
        ResponseEntity<?> response = userApiController.updateUser(otherUserId, updatedDetails, authHeader);

        // Then
        assertEquals(HttpStatus.FORBIDDEN, response.getStatusCode());

        Map<String, Object> responseBody = (Map<String, Object>) response.getBody();
        assertFalse((Boolean) responseBody.get("success"));
        assertTrue(responseBody.get("error").toString().contains("Access denied"));

        verify(userDAO, never()).updateUser(any(User.class));
    }

    @Test
    void testUpdateUser_UpdatePassword_Success() {
        // Given
        String authHeader = "Bearer " + validToken;
        int userId = 1;

        Map<String, String> passwordData = new HashMap<>();
        passwordData.put("newPassword", "newPassword123");

        when(authService.validateToken(validToken)).thenReturn(true);
        when(authService.getEmailFromToken(validToken)).thenReturn("user@example.com");
        when(userDAO.findByEmail("user@example.com")).thenReturn(testUser);
        when(userDAO.findById(userId)).thenReturn(testUser);
        when(userDAO.updatePassword(userId, "newPassword123")).thenReturn(true);

        // When
        ResponseEntity<?> response = userApiController.updatePassword(userId, passwordData, authHeader);

        // Then
        assertEquals(HttpStatus.OK, response.getStatusCode());

        Map<String, Object> responseBody = (Map<String, Object>) response.getBody();
        assertTrue((Boolean) responseBody.get("success"));
        assertEquals("Password updated successfully", responseBody.get("message"));

        verify(userDAO).updatePassword(userId, "newPassword123");
    }

    @Test
    void testUpdateUser_UpdatePassword_WeakPassword() {
        // Given
        String authHeader = "Bearer " + validToken;
        int userId = 1;

        Map<String, String> passwordData = new HashMap<>();
        passwordData.put("newPassword", "weak"); // Too short

        when(authService.validateToken(validToken)).thenReturn(true);
        when(authService.getEmailFromToken(validToken)).thenReturn("user@example.com");
        when(userDAO.findByEmail("user@example.com")).thenReturn(testUser);

        // When
        ResponseEntity<?> response = userApiController.updatePassword(userId, passwordData, authHeader);

        // Then
        assertEquals(HttpStatus.BAD_REQUEST, response.getStatusCode());

        Map<String, Object> responseBody = (Map<String, Object>) response.getBody();
        assertFalse((Boolean) responseBody.get("success"));
        assertTrue(responseBody.get("error").toString().contains("at least 6 characters"));

        verify(userDAO, never()).updatePassword(anyInt(), anyString());
    }

    // ===== DELETE OPERATIONS =====

    @Test
    void testDeleteUser_AdminSuccess() {
        // Given
        String authHeader = "Bearer " + adminToken;
        int userIdToDelete = 1;

        User userToDelete = new User();
        userToDelete.setId(userIdToDelete);
        userToDelete.setFirstName("ToDelete");
        userToDelete.setLastName("User");
        userToDelete.setEmail("delete@example.com");

        when(authService.validateToken(adminToken)).thenReturn(true);
        when(authService.getEmailFromToken(adminToken)).thenReturn("admin@example.com");
        when(userDAO.findByEmail("admin@example.com")).thenReturn(adminUser);
        when(userDAO.findById(userIdToDelete)).thenReturn(userToDelete);
        when(userDAO.deleteUser(userIdToDelete)).thenReturn(true);

        // When
        ResponseEntity<?> response = userApiController.deleteUser(userIdToDelete, authHeader);

        // Then
        assertEquals(HttpStatus.OK, response.getStatusCode());

        Map<String, Object> responseBody = (Map<String, Object>) response.getBody();
        assertTrue((Boolean) responseBody.get("success"));
        assertEquals("User deleted successfully", responseBody.get("message"));

        verify(userDAO).deleteUser(userIdToDelete);
    }

    @Test
    void testDeleteUser_NonAdminForbidden() {
        // Given
        String authHeader = "Bearer " + validToken;
        int userIdToDelete = 2;

        when(authService.validateToken(validToken)).thenReturn(true);
        when(authService.getEmailFromToken(validToken)).thenReturn("user@example.com");
        when(userDAO.findByEmail("user@example.com")).thenReturn(testUser);

        // When
        ResponseEntity<?> response = userApiController.deleteUser(userIdToDelete, authHeader);

        // Then
        assertEquals(HttpStatus.FORBIDDEN, response.getStatusCode());

        Map<String, Object> responseBody = (Map<String, Object>) response.getBody();
        assertFalse((Boolean) responseBody.get("success"));
        assertTrue(responseBody.get("error").toString().contains("Admin privileges"));

        verify(userDAO, never()).deleteUser(anyInt());
    }

    @Test
    void testDeleteUser_AdminSelfDeletionPrevented() {
        // Given
        String authHeader = "Bearer " + adminToken;
        int adminUserId = 2; // Same as admin user's ID

        when(authService.validateToken(adminToken)).thenReturn(true);
        when(authService.getEmailFromToken(adminToken)).thenReturn("admin@example.com");
        when(userDAO.findByEmail("admin@example.com")).thenReturn(adminUser);

        // When
        ResponseEntity<?> response = userApiController.deleteUser(adminUserId, authHeader);

        // Then
        assertEquals(HttpStatus.BAD_REQUEST, response.getStatusCode());

        Map<String, Object> responseBody = (Map<String, Object>) response.getBody();
        assertFalse((Boolean) responseBody.get("success"));
        assertTrue(responseBody.get("error").toString().contains("Cannot delete your own account"));

        verify(userDAO, never()).deleteUser(anyInt());
    }

    @Test
    void testDeleteUser_UserNotFound() {
        // Given
        String authHeader = "Bearer " + adminToken;
        int nonExistentUserId = 999;

        when(authService.validateToken(adminToken)).thenReturn(true);
        when(authService.getEmailFromToken(adminToken)).thenReturn("admin@example.com");
        when(userDAO.findByEmail("admin@example.com")).thenReturn(adminUser);
        when(userDAO.findById(nonExistentUserId)).thenReturn(null);

        // When
        ResponseEntity<?> response = userApiController.deleteUser(nonExistentUserId, authHeader);

        // Then
        assertEquals(HttpStatus.NOT_FOUND, response.getStatusCode());

        Map<String, Object> responseBody = (Map<String, Object>) response.getBody();
        assertFalse((Boolean) responseBody.get("success"));
        assertEquals("User not found", responseBody.get("error"));

        verify(userDAO, never()).deleteUser(anyInt());
    }

    // ===== AUTHENTICATION OPERATIONS =====

    @Test
    void testAuthentication_Login_Success() {
        // Given
        Map<String, String> credentials = new HashMap<>();
        credentials.put("email", "user@example.com");
        credentials.put("password", "password123");

        User loggedInUser = new User();
        loggedInUser.setId(1);
        loggedInUser.setEmail("user@example.com");
        loggedInUser.setFirstName("John");
        loggedInUser.setLastName("Doe");
        loggedInUser.setToken("login-token");

        when(authService.loginUser("user@example.com", "password123")).thenReturn(loggedInUser);

        // When
        ResponseEntity<?> response = userApiController.login(credentials);

        // Then
        assertEquals(HttpStatus.OK, response.getStatusCode());

        Map<String, Object> responseBody = (Map<String, Object>) response.getBody();
        assertTrue((Boolean) responseBody.get("success"));
        assertEquals("Login successful", responseBody.get("message"));

        User responseUser = (User) responseBody.get("data");
        assertEquals("user@example.com", responseUser.getEmail());
        assertNotNull(responseUser.getToken());
        assertNull(responseUser.getPassword());

        verify(authService).loginUser("user@example.com", "password123");
    }

    @Test
    void testAuthentication_Login_InvalidCredentials() {
        // Given
        Map<String, String> credentials = new HashMap<>();
        credentials.put("email", "user@example.com");
        credentials.put("password", "wrongpassword");

        when(authService.loginUser("user@example.com", "wrongpassword"))
                .thenThrow(new RuntimeException("Invalid email or password"));

        // When
        ResponseEntity<?> response = userApiController.login(credentials);

        // Then
        assertEquals(HttpStatus.UNAUTHORIZED, response.getStatusCode());

        Map<String, Object> responseBody = (Map<String, Object>) response.getBody();
        assertFalse((Boolean) responseBody.get("success"));
        assertTrue(responseBody.get("error").toString().contains("Invalid email or password"));

        verify(authService).loginUser("user@example.com", "wrongpassword");
    }

    @Test
    void testAuthentication_VerifyToken_Valid() {
        // Given
        String authHeader = "Bearer " + validToken;

        when(authService.validateToken(validToken)).thenReturn(true);
        when(authService.getEmailFromToken(validToken)).thenReturn("user@example.com");
        when(userDAO.findByEmail("user@example.com")).thenReturn(testUser);

        // When
        ResponseEntity<?> response = userApiController.verifyToken(authHeader);

        // Then
        assertEquals(HttpStatus.OK, response.getStatusCode());

        Map<String, Object> responseBody = (Map<String, Object>) response.getBody();
        assertTrue((Boolean) responseBody.get("success"));
        assertTrue((Boolean) responseBody.get("valid"));

        Map<String, Object> userInfo = (Map<String, Object>) responseBody.get("user");
        assertNotNull(userInfo);
        assertEquals("user@example.com", userInfo.get("email"));

        verify(authService).validateToken(validToken);
    }

    @Test
    void testAuthentication_VerifyToken_Invalid() {
        // Given
        String authHeader = "Bearer invalid-token";

        when(authService.validateToken("invalid-token")).thenReturn(false);

        // When
        ResponseEntity<?> response = userApiController.verifyToken(authHeader);

        // Then
        assertEquals(HttpStatus.OK, response.getStatusCode()); // Note: returns 200 even for invalid tokens

        Map<String, Object> responseBody = (Map<String, Object>) response.getBody();
        assertFalse((Boolean) responseBody.get("success"));
        assertFalse((Boolean) responseBody.get("valid"));

        verify(authService).validateToken("invalid-token");
    }
}