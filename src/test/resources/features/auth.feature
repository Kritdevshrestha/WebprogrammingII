Feature: User Authentication
  Simple authentication tests without complex setup

  Scenario: View login page
    Given the application is ready
    When I go to the login page
    Then I should see the login page

  Scenario: View signup page
    Given the application is ready
    When I go to the signup page
    Then I should see the signup page

  Scenario: Login with empty email
    Given the application is ready
    When I try to login with email "" and password "test123"
    Then I should see error "Email is required!"

  Scenario: Login with invalid email format
    Given the application is ready
    When I try to login with email "invalid-email" and password "test123"
    Then I should see error "Please enter a valid email address!"

  Scenario: Login with empty password
    Given the application is ready
    When I try to login with email "test@example.com" and password ""
    Then I should see error "Password is required!"

  Scenario: Registration with password mismatch
    Given the application is ready
    When I try to register with:
      | firstName | John |
      | lastName  | Doe  |
      | email     | john@example.com |
      | password  | password123 |
      | confirmPassword | different |
      | userType  | user |
    Then I should see error "Passwords do not match!"

  Scenario: Registration with weak password
    Given the application is ready
    When I try to register with:
      | firstName | Alice |
      | lastName  | Smith |
      | email     | alice@example.com |
      | password  | weak |
      | confirmPassword | weak |
      | userType  | user |
    Then I should see error "Password must be at least 6 characters long!"