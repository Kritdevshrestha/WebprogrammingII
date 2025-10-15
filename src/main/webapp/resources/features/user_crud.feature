Feature: User CRUD Operations
  As a user of the system
  I want to perform CRUD operations on user accounts
  So that I can manage user data effectively

  Background:
    Given the application is running
    And the database is clean

  Scenario: Create a new user account successfully
    Given I have valid user registration data
      | firstName | lastName | email              | password    | userType |
      | John      | Doe      | john@example.com   | password123 | customer |
    When I submit the registration form
    Then the user should be created successfully
    And I should see a success message "Account created successfully"
    And the user should exist in the database

  Scenario: Fail to create user with existing email
    Given a user already exists with email "existing@example.com"
    And I have user registration data with email "existing@example.com"
    When I submit the registration form
    Then the registration should fail
    And I should see an error message "Email already registered"

  Scenario: Fail to create user with invalid email
    Given I have user registration data with invalid email "invalid-email"
    When I submit the registration form
    Then the registration should fail
    And I should see an error message "Please enter a valid email address"

  Scenario: Fail to create user with short password
    Given I have user registration data with password "12345"
    When I submit the registration form
    Then the registration should fail
    And I should see an error message "Password must be at least 6 characters long"

  Scenario: Fail to create user with mismatched passwords
    Given I have user registration data
      | firstName | lastName | email            | password    | confirmPassword |
      | John      | Doe      | john@example.com | password123 | password456     |
    When I submit the registration form
    Then the registration should fail
    And I should see an error message "Passwords do not match"

  Scenario: Login with valid credentials
    Given a user exists with credentials
      | email            | password    |
      | john@example.com | password123 |
    When I login with email "john@example.com" and password "password123"
    Then I should be logged in successfully
    And I should be redirected to the home page
    And my session should contain user data

  Scenario: Fail to login with invalid credentials
    Given a user exists with email "john@example.com"
    When I login with email "john@example.com" and password "wrongpassword"
    Then the login should fail
    And I should see an error message "Invalid email or password"

  Scenario: Read user details by ID
    Given a user exists with ID 1
    And I am logged in as an admin
    When I request user details for ID 1
    Then I should receive the user details
    And the response should contain user information

  Scenario: Read all users as admin
    Given the following users exist
      | firstName | lastName | email              | userType |
      | John      | Doe      | john@example.com   | customer |
      | Jane      | Smith    | jane@example.com   | customer |
      | Admin     | User     | admin@example.com  | admin    |
    And I am logged in as an admin
    When I request all users
    Then I should receive a list of 3 users
    And the response should contain all user details

  Scenario: Non-admin cannot access all users
    Given I am logged in as a customer
    When I request all users
    Then the request should be denied
    And I should see an error message "Admin privileges required"

  Scenario: Update own user profile
    Given I am logged in with ID 1
    When I update my profile with
      | firstName | lastName |
      | John      | Updated  |
    Then my profile should be updated successfully
    And my name should be "John Updated"

  Scenario: Update user password
    Given I am logged in with ID 1
    When I update my password to "newPassword123"
    Then my password should be updated successfully
    And I should be able to login with the new password

  Scenario: Admin can update any user
    Given a user exists with ID 5
    And I am logged in as an admin
    When I update user 5 profile with
      | firstName | userType |
      | Updated   | admin    |
    Then the user profile should be updated successfully

  Scenario: User cannot update another user's profile
    Given a user exists with ID 5
    And I am logged in with ID 1
    When I try to update user 5 profile
    Then the request should be denied
    And I should see an error message "Access denied"

  Scenario: Delete user as admin
    Given a user exists with ID 5
    And I am logged in as an admin with ID 2
    When I delete user with ID 5
    Then the user should be deleted successfully
    And the user should not exist in the database

  Scenario: Admin cannot delete themselves
    Given I am logged in as an admin with ID 1
    When I try to delete user with ID 1
    Then the request should be denied
    And I should see an error message "Cannot delete your own account"

  Scenario: Non-admin cannot delete users
    Given a user exists with ID 5
    And I am logged in as a customer
    When I try to delete user with ID 5
    Then the request should be denied
    And I should see an error message "Admin privileges required"

  Scenario: Logout successfully
    Given I am logged in as a customer
    When I logout
    Then my session should be invalidated
    And I should be redirected to the index page