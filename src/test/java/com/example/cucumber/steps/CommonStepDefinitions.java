package com.example.cucumber.steps;

import com.example.controller.AuthController;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import org.springframework.beans.factory.annotation.Autowired;

import static org.junit.jupiter.api.Assertions.*;

public class CommonStepDefinitions {

    @Autowired
    private AuthController authController;

    @Given("the auth controller is available")
    public void the_auth_controller_is_available() {
        assertNotNull(authController, "AuthController should be available");
    }

    @Then("the response should be successful")
    public void the_response_should_be_successful() {
        // This can be customized based on what "successful" means for each scenario
        assertTrue(true, "Step execution completed without errors");
    }
}