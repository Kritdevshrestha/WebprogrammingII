package com.example.unit.service;

import com.example.dao.UserDAO;
import com.example.model.User;
import com.example.service.AuthService;
import com.example.util.JwtUtil;
import com.example.util.PasswordEncoder;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class AuthServiceUnitTest {

    @Mock
    private UserDAO userDAO;

    @Mock
    private JwtUtil jwtUtil;

    @Mock
    private PasswordEncoder passwordEncoder;

    @InjectMocks
    private AuthService authService;

    private User testUser;

    @BeforeEach
    void setUp() {
        testUser = new User();
        testUser.setId(1);
        testUser.setEmail("test@example.com");
        testUser.setPassword("rawPassword");
        testUser.setFirstName("John");
        testUser.setLastName("Doe");
    }

    @Test
    void testRegisterUser_Success() {
        // Given
        when(userDAO.emailExists("test@example.com")).thenReturn(false);
        when(passwordEncoder.encode("rawPassword")).thenReturn("encodedPassword");
        when(userDAO.saveUser(any(User.class))).thenReturn(1);
        when(jwtUtil.generateToken("test@example.com")).thenReturn("jwt-token");

        // When
        User result = authService.registerUser(testUser);

        // Then
        assertNotNull(result);
        assertEquals(1, result.getId());
        assertEquals("jwt-token", result.getToken());
        assertNull(result.getPassword());
        verify(userDAO).emailExists("test@example.com");
        verify(passwordEncoder).encode("rawPassword");
        verify(userDAO).saveUser(any(User.class));
    }

    @Test
    void testRegisterUser_EmailExists() {
        // Given
        when(userDAO.emailExists("test@example.com")).thenReturn(true);

        // When & Then
        assertThrows(RuntimeException.class, () -> {
            authService.registerUser(testUser);
        });
    }

    @Test
    void testLoginUser_Success() {
        // Given
        User dbUser = new User();
        dbUser.setId(1);
        dbUser.setEmail("test@example.com");
        dbUser.setPassword("encodedPassword");

        when(userDAO.findByEmail("test@example.com")).thenReturn(dbUser);
        when(passwordEncoder.matches("rawPassword", "encodedPassword")).thenReturn(true);
        when(jwtUtil.generateToken("test@example.com")).thenReturn("jwt-token");

        // When
        User result = authService.loginUser("test@example.com", "rawPassword");

        // Then
        assertNotNull(result);
        assertEquals("jwt-token", result.getToken());
        assertNull(result.getPassword());
    }

    @Test
    void testLoginUser_InvalidPassword() {
        // Given
        User dbUser = new User();
        dbUser.setPassword("encodedPassword");

        when(userDAO.findByEmail("test@example.com")).thenReturn(dbUser);
        when(passwordEncoder.matches("wrongPassword", "encodedPassword")).thenReturn(false);

        // When & Then
        assertThrows(RuntimeException.class, () -> {
            authService.loginUser("test@example.com", "wrongPassword");
        });
    }
}