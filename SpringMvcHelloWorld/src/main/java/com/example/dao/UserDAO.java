package com.example.dao;

import com.example.model.User;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;

import java.sql.*;
import java.util.logging.Logger;

public class UserDAO {
    private static final Logger logger = Logger.getLogger(UserDAO.class.getName());
    private JdbcTemplate jdbcTemplate;

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    // Save new user (signup)
    public int saveUser(User u) {
        try {
            logger.info("Attempting to save user: " + u.getEmail());

            String sql = "INSERT INTO users(first_name, last_name, email, password, user_type) VALUES(?,?,?,?,?)";

            KeyHolder keyHolder = new GeneratedKeyHolder();

            int result = jdbcTemplate.update(connection -> {
                PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, u.getFirstName());
                ps.setString(2, u.getLastName());
                ps.setString(3, u.getEmail());
                ps.setString(4, u.getPassword());
                ps.setString(5, u.getUserType());
                return ps;
            }, keyHolder);

            if (result > 0) {
                Number key = keyHolder.getKey();
                if (key != null) {
                    logger.info("User saved successfully with ID: " + key.intValue());
                    return key.intValue();
                }
                logger.info("User saved successfully");
                return result;
            } else {
                logger.warning("Failed to save user: No rows affected");
                return 0;
            }
        } catch (Exception e) {
            logger.severe("Error saving user: " + e.getMessage());
            e.printStackTrace();
            return 0;
        }
    }

    // Check user by email & password (login)
    public User validateUser(String email, String password) {
        try {
            logger.info("Validating user: " + email);
            String sql = "SELECT * FROM users WHERE email=? AND password=?";
            return jdbcTemplate.queryForObject(sql, new Object[]{email, password}, new UserRowMapper());
        } catch (EmptyResultDataAccessException e) {
            logger.warning("User not found: " + email);
            return null;
        } catch (Exception e) {
            logger.severe("Error validating user: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    // Check if email already exists (for signup validation)
    public boolean emailExists(String email) {
        try {
            logger.info("Checking if email exists: " + email);
            String sql = "SELECT COUNT(*) FROM users WHERE email=?";
            Integer count = jdbcTemplate.queryForObject(sql, new Object[]{email}, Integer.class);
            boolean exists = count != null && count > 0;
            logger.info("Email exists: " + exists);
            return exists;
        } catch (Exception e) {
            logger.severe("Error checking email existence: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // RowMapper implementation
    private static class UserRowMapper implements RowMapper<User> {
        @Override
        public User mapRow(ResultSet rs, int rowNum) throws SQLException {
            User user = new User();
            user.setId(rs.getInt("id"));
            user.setFirstName(rs.getString("first_name"));
            user.setLastName(rs.getString("last_name"));
            user.setEmail(rs.getString("email"));
            user.setPassword(rs.getString("password"));
            user.setUserType(rs.getString("user_type"));
            return user;
        }
    }
}