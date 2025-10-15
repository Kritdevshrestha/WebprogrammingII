package com.example.unit.controller;

import com.example.controller.AuthController;
import com.example.dao.UserDAO;
import com.example.model.User;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.ui.Model;
import org.springframework.dao.EmptyResultDataAccessException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class AuthControllerUnitTest {

    @Mock
    private UserDAO userDAO;

    @Mock
    private Model model;

    @Mock
    private HttpServletRequest request;

    @Mock
    private HttpSession session;

    @InjectMocks
    private AuthController authController;

    private User testUser;

    @BeforeEach
    void setUp() {
        testUser = new User();
        testUser.setId(1);
        testUser.setEmail("test@example.com");
        testUser.setPassword("password123");
        testUser.setFirstName("John");
        testUser.setLastName("Doe");
    }

    @Test
    void testShowLogin() {
        // When
        String viewName = authController.showLogin(model);

        // Then
        assertEquals("login", viewName);
        verify(model).addAttribute("error", "");
        verify(model).addAttribute("msg", "");
    }

    @Test
    void testShowSignup() {
        // When
        String viewName = authController.showSignup(model);

        // Then
        assertEquals("signup", viewName);
        verify(model).addAttribute("error", "");
    }

    @Test
    void testLogin_Success() {
        // Given
        when(userDAO.validateUser("test@example.com", "password123"))
                .thenReturn(testUser);
        when(request.getSession()).thenReturn(session);

        // When
        String viewName = authController.login("test@example.com", "password123", request, model);

        // Then
        assertEquals("redirect:/home", viewName);
        verify(session).setAttribute("user", testUser);
    }

    @Test
    void testLogin_InvalidCredentials() {
        // Given
        when(userDAO.validateUser("wrong@example.com", "wrongpass"))
                .thenThrow(EmptyResultDataAccessException.class);

        // When
        String viewName = authController.login("wrong@example.com", "wrongpass", request, model);

        // Then
        assertEquals("login", viewName);
        verify(model).addAttribute("error", "Invalid email or password!");
    }

    @Test
    void testLogin_EmptyEmail() {
        // When
        String viewName = authController.login("", "password123", request, model);

        // Then
        assertEquals("login", viewName);
        verify(model).addAttribute("error", "Email is required!");
    }

    @Test
    void testLogin_EmptyPassword() {
        // When
        String viewName = authController.login("test@example.com", "", request, model);

        // Then
        assertEquals("login", viewName);
        verify(model).addAttribute("error", "Password is required!");
    }

    @Test
    void testLogin_InvalidEmailFormat() {
        // When - testing with invalid email format
        String viewName = authController.login("invalid-email", "password123", request, model);

        // Then
        assertEquals("login", viewName);
        verify(model).addAttribute("error", "Please enter a valid email address!");
    }

    @Test
    void testLogin_ValidEmailFormat() {
        // Given - valid email should pass validation and proceed to check credentials
        when(userDAO.validateUser("valid@example.com", "password123"))
                .thenThrow(EmptyResultDataAccessException.class); // Simulate invalid credentials

        // When
        String viewName = authController.login("valid@example.com", "password123", request, model);

        // Then - should reach the credential validation stage
        assertEquals("login", viewName);
        verify(model).addAttribute("error", "Invalid email or password!");
    }

    @Test
    void testSignup_Success() {
        // Given
        when(userDAO.emailExists("newuser@example.com")).thenReturn(false);
        when(userDAO.saveUser(any(User.class))).thenReturn(1);

        // When
        String viewName = authController.signup(
                "John", "Doe", "newuser@example.com",
                "password123", "password123", "user", model
        );

        // Then
        assertEquals("login", viewName);
        verify(model).addAttribute("msg", "Account created successfully! Please login.");
    }

    @Test
    void testSignup_EmailAlreadyExists() {
        // Given
        when(userDAO.emailExists("existing@example.com")).thenReturn(true);

        // When
        String viewName = authController.signup(
                "John", "Doe", "existing@example.com",
                "password123", "password123", "user", model
        );

        // Then
        assertEquals("signup", viewName);
        verify(model).addAttribute("error", "Email already registered!");
    }

    @Test
    void testSignup_InvalidEmailFormat() {
        // When - testing signup with invalid email
        String viewName = authController.signup(
                "John", "Doe", "invalid-email",
                "password123", "password123", "user", model
        );

        // Then
        assertEquals("signup", viewName);
        verify(model).addAttribute("error", "Please enter a valid email address!");
    }

    @Test
    void testSignup_PasswordMismatch() {
        // When
        String viewName = authController.signup(
                "John", "Doe", "test@example.com",
                "password123", "differentpassword", "user", model
        );

        // Then
        assertEquals("signup", viewName);
        verify(model).addAttribute("error", "Passwords do not match!");
    }

    @Test
    void testSignup_WeakPassword() {
        // When
        String viewName = authController.signup(
                "John", "Doe", "test@example.com",
                "weak", "weak", "user", model
        );

        // Then
        assertEquals("signup", viewName);
        verify(model).addAttribute("error", "Password must be at least 6 characters long!");
    }

    @Test
    void testSignup_MissingFirstName() {
        // When
        String viewName = authController.signup(
                "", "Doe", "test@example.com",
                "password123", "password123", "user", model
        );

        // Then
        assertEquals("signup", viewName);
        verify(model).addAttribute("error", "First name is required!");
    }

    @Test
    void testSignup_MissingLastName() {
        // When
        String viewName = authController.signup(
                "John", "", "test@example.com",
                "password123", "password123", "user", model
        );

        // Then
        assertEquals("signup", viewName);
        verify(model).addAttribute("error", "Last name is required!");
    }

    @Test
    void testSignup_MissingUserType() {
        // When
        String viewName = authController.signup(
                "John", "Doe", "test@example.com",
                "password123", "password123", "", model
        );

        // Then
        assertEquals("signup", viewName);
        verify(model).addAttribute("error", "Please select a user type!");
    }

    @Test
    void testLogout_Post() {
        // Given
        when(request.getSession(false)).thenReturn(session);

        // When
        String viewName = authController.logout(request, model);

        // Then
        assertEquals("redirect:/index", viewName);
        verify(session).invalidate();
        verify(model).addAttribute("msg", "You have been logged out successfully.");
    }

    @Test
    void testLogout_Get() {
        // Given
        when(request.getSession(false)).thenReturn(session);

        // When
        String viewName = authController.showLogout(request);

        // Then
        assertEquals("redirect:/index", viewName);
        verify(session).invalidate();
    }

    @Test
    void testIsValidEmail_ValidEmails() {
        assertTrue(authController.isValidEmail("test@example.com"));
        assertTrue(authController.isValidEmail("user.name@domain.co.uk"));
        assertTrue(authController.isValidEmail("user+tag@example.com"));
    }

    @Test
    void testIsValidEmail_InvalidEmails() {
        assertFalse(authController.isValidEmail("invalid-email"));
        assertFalse(authController.isValidEmail("missing@domain"));
        assertFalse(authController.isValidEmail("@domain.com"));
        assertFalse(authController.isValidEmail(""));
        assertFalse(authController.isValidEmail(null));
    }
}