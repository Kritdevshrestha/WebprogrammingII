package com.example.cucumber.steps;

import com.example.controller.AuthController;
import com.example.cucumber.TestModel;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.When;
import io.cucumber.java.en.Then;
import org.springframework.mock.web.MockHttpServletRequest;

import static org.junit.Assert.*;

public class AuthStepDefinitions {

    private AuthController authController;
    private MockHttpServletRequest request;
    private TestModel model;
    private String resultView;

    @Given("the application is ready")
    public void the_application_is_ready() {
        authController = new AuthController();
        request = new MockHttpServletRequest();
        model = new TestModel();
    }

    @When("I go to the login page")
    public void i_go_to_the_login_page() {
        resultView = authController.showLogin(model);
    }

    @When("I go to the signup page")
    public void i_go_to_the_signup_page() {
        resultView = authController.showSignup(model);
    }

    @When("I try to login with email {string} and password {string}")
    public void i_try_to_login_with_email_and_password(String email, String password) {
        resultView = authController.login(email, password, request, model);
    }

    @When("I try to register with:")
    public void i_try_to_register_with(io.cucumber.datatable.DataTable dataTable) {
        var data = dataTable.asMap();

        String firstName = data.get("firstName");
        String lastName = data.get("lastName");
        String email = data.get("email");
        String password = data.get("password");
        String confirmPassword = data.get("confirmPassword");
        String userType = data.get("userType");

        resultView = authController.signup(
                firstName, lastName, email, password,
                confirmPassword, userType, model
        );
    }

    @Then("I should see the login page")
    public void i_should_see_the_login_page() {
        assertEquals("login", resultView);
    }

    @Then("I should see the signup page")
    public void i_should_see_the_signup_page() {
        assertEquals("signup", resultView);
    }

    @Then("I should see error {string}")
    public void i_should_see_error(String expectedError) {
        String actualError = (String) model.getAttribute("error");
        assertEquals(expectedError, actualError);
    }

    @Then("I should see success {string}")
    public void i_should_see_success(String expectedMessage) {
        String actualMessage = (String) model.getAttribute("msg");
        assertEquals(expectedMessage, actualMessage);
    }
}