package com.example.cucumber;

import io.cucumber.spring.CucumberContextConfiguration;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.web.WebAppConfiguration;

@CucumberContextConfiguration
@ContextConfiguration(locations = {
        "classpath:test-database.xml"
})
@WebAppConfiguration
public class CucumberSpringConfig {
    // This class provides Spring configuration for Cucumber tests
}