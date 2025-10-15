Feature: Simple User Login
  As a user
  I want to login to the application
  So that I can access protected pages

  Scenario: Successful login with valid credentials
    Given the application is running
    And a user with email "test@example.com" and password "password123" exists
    When I login with email "test@example.com" and password "password123"
    Then login should be successful

  Scenario: Failed login with wrong password
    Given the application is running
    And a user with email "test@example.com" and password "password123" exists
    When I login with email "test@example.com" and password "wrongpassword"
    Then login should fail
    And I should see error message "Invalid email or password!"

  Scenario: Failed login with non-existent email
    Given the application is running
    When I login with email "nonexistent@example.com" and password "password123"
    Then login should fail
    And I should see error message "Invalid email or password!"