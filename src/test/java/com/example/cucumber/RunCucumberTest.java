package com.example.cucumber;

import org.junit.runner.RunWith;
import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;

@RunWith(Cucumber.class)
@CucumberOptions(
        features = "src/test/resources/features/auth.feature",
        glue = {"com.example"},
        plugin = {
                "pretty",
                "html:target/cucumber-reports.html"
        },
        monochrome = true
)
public class RunCucumberTest {
}