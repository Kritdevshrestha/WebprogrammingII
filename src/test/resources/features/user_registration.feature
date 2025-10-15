Feature: User Registration
  As a new user
  I want to create an account
  So that I can use the application

  Background:
    Given the application is running
    And no user with email "newuser@example.com" exists

  Scenario: Successful user registration
    When I navigate to the signup page
    And I enter registration details:
      | first_name | John                 |
      | last_name  | Doe                  |
      | email      | newuser@example.com  |
      | password   | password123          |
      | confirm_password | password123      |
      | user_type  | user                 |
    And I click the signup button
    Then I should see success message "Account created successfully! Please login."
    And I should be redirected to the login page

  Scenario: Registration with existing email
    Given a user with email "existing@example.com" exists
    When I navigate to the signup page
    And I enter registration details:
      | first_name | Jane                 |
      | last_name  | Smith                |
      | email      | existing@example.com |
      | password   | password123          |
      | confirm_password | password123      |
      | user_type  | user                 |
    And I click the signup button
    Then I should see error message "Email already registered!"
    And I should remain on the signup page

  Scenario: Registration with password mismatch
    When I navigate to the signup page
    And I enter registration details:
      | first_name | Bob                  |
      | last_name  | Brown                |
      | email      | bob@example.com      |
      | password   | password123          |
      | confirm_password | differentpass   |
      | user_type  | user                 |
    And I click the signup button
    Then I should see error message "Passwords do not match!"
    And I should remain on the signup page

  Scenario: Registration with weak password
    When I navigate to the signup page
    And I enter registration details:
      | first_name | Alice                |
      | last_name  | Johnson              |
      | email      | alice@example.com    |
      | password   | weak                 |
      | confirm_password | weak           |
      | user_type  | user                 |
    And I click the signup button
    Then I should see error message "Password must be at least 6 characters long!"