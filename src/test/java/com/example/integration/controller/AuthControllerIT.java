package com.example.integration.controller;

import com.example.controller.AuthController;
import com.example.dao.UserDAO;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.ui.Model;
import org.springframework.test.jdbc.JdbcTestUtils;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import javax.sql.DataSource;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = "classpath:test-config.xml")
@WebAppConfiguration
class AuthControllerIT {

    @Autowired
    private AuthController authController;

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private DataSource dataSource;

    private JdbcTemplate jdbcTemplate;

    @BeforeEach
    void setUp() {
        jdbcTemplate = new JdbcTemplate(dataSource);

        // Initialize database schema
        jdbcTemplate.execute("DROP TABLE IF EXISTS users");
        jdbcTemplate.execute("CREATE TABLE users (" +
                "id INT AUTO_INCREMENT PRIMARY KEY, " +
                "first_name VARCHAR(100) NOT NULL, " +
                "last_name VARCHAR(100) NOT NULL, " +
                "email VARCHAR(100) UNIQUE NOT NULL, " +
                "password VARCHAR(100) NOT NULL, " +
                "user_type VARCHAR(20) NOT NULL)");
    }

    @Test
    void testUserRegistrationAndLogin_Integration() {
        // Setup mocks
        Model model = mock(Model.class);
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpSession session = mock(HttpSession.class);

        when(request.getSession()).thenReturn(session);

        // Test 1: Successful Registration
        String signupResult = authController.signup(
                "John", "Doe", "john@example.com",
                "password123", "password123", "user",
                model
        );

        assertEquals("login", signupResult);

        // Test 2: Successful Login with registered user
        String loginResult = authController.login(
                "john@example.com", "password123", request, model
        );

        assertEquals("redirect:/home", loginResult);
    }

    @Test
    void testEmailValidation() {
        // Test valid emails
        assertTrue(authController.isValidEmail("2002nischal@gmail.com"));
        assertTrue(authController.isValidEmail("krit123@gmail.com"));

        // Test invalid emails
        assertFalse(authController.isValidEmail("invalid-email"));
        assertFalse(authController.isValidEmail("missing@domain"));
        assertFalse(authController.isValidEmail("@domain.com"));
    }

    @Test
    void testDuplicateEmailRegistration() {
        // Setup
        Model model = mock(Model.class);

        // Register first user
        authController.signup(
                "John", "Doe", "duplicate@example.com",
                "password123", "password123", "user",
                model
        );

        // Try to register with same email again
        String result = authController.signup(
                "Jane", "Smith", "duplicate@example.com",
                "password456", "password456", "user",
                model
        );

        assertEquals("signup", result);
        verify(model).addAttribute("error", "Email already registered!");
    }
}