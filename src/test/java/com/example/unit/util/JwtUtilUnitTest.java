package com.example.unit.util;

import com.example.util.JwtUtil;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class JwtUtilUnitTest {

    private JwtUtil jwtUtil;

    @BeforeEach
    void setUp() {
        jwtUtil = new JwtUtil();
    }

    @Test
    void testGenerateAndValidateToken() {
        // Given
        String email = "test@example.com";

        // When
        String token = jwtUtil.generateToken(email);
        boolean isValid = jwtUtil.validateToken(token);
        String extractedEmail = jwtUtil.getEmailFromToken(token);

        // Then
        assertNotNull(token);
        assertTrue(isValid);
        assertEquals(email, extractedEmail);
    }

    @Test
    void testValidateToken_Invalid() {
        // When
        boolean isValid = jwtUtil.validateToken("invalid-token");

        // Then
        assertFalse(isValid);
    }
}