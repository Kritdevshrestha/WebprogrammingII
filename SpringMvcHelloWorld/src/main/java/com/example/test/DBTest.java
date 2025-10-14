package com.example.test;

import org.springframework.jdbc.datasource.DriverManagerDataSource;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class DBTest {
    public static void main(String[] args) {
        try {
            // Test database connection
            DataSource dataSource = new DriverManagerDataSource();
            ((DriverManagerDataSource) dataSource).setDriverClassName("com.mysql.cj.jdbc.Driver");
            ((DriverManagerDataSource) dataSource).setUrl("jdbc:mysql://localhost:3306/harvest_hub?useSSL=false&serverTimezone=UTC");
            ((DriverManagerDataSource) dataSource).setUsername("root");
            ((DriverManagerDataSource) dataSource).setPassword("yourpassword");

            Connection conn = dataSource.getConnection();
            System.out.println("✅ Database connection successful!");

            // Test if table exists
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SHOW TABLES LIKE 'users'");
            if (rs.next()) {
                System.out.println("✅ Users table exists!");
            } else {
                System.out.println("❌ Users table does not exist!");
            }

            // Test insert
            int result = stmt.executeUpdate("INSERT INTO users (first_name, last_name, email, password, user_type) VALUES ('Test', 'User', 'test@test.com', 'password', 'customer')");
            System.out.println("✅ Insert test: " + result + " rows affected");

            conn.close();
        } catch (Exception e) {
            System.out.println("❌ Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}