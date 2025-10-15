Feature: Simple User Registration
  As a new user
  I want to create an account
  So that I can use the application

  Scenario: Successful registration
    Given the application is running
    When I register with firstName "John" lastName "Doe" email "newuser@example.com" password "password123" confirmPassword "password123" userType "user"
    Then I should be on login page
    And I should see success message "Account created successfully! Please login."

  Scenario: Registration with existing email
    Given the application is running
    And a user with email "existing@example.com" and password "password123" exists
    When I register with firstName "Jane" lastName "Smith" email "existing@example.com" password "password123" confirmPassword "password123" userType "user"
    Then I should be on signup page
    And I should see error message "Email already registered!"