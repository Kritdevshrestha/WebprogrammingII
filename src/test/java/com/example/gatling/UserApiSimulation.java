package com.example.gatling;

import io.gatling.javaapi.core.*;
import io.gatling.javaapi.http.*;
import static io.gatling.javaapi.core.CoreDsl.*;
import static io.gatling.javaapi.http.HttpDsl.*;
import java.time.Duration;

public class UserApiSimulation extends Simulation {

    // Configuration
    String baseUrl = "http://localhost:8080/SpringMvcHelloWorld";

    HttpProtocolBuilder httpProtocol = http
            .baseUrl(baseUrl)
            .acceptHeader("application/json")
            .contentTypeHeader("application/json")
            .userAgentHeader("Gatling Performance Test");

    // Feeder for unique user data
    FeederBuilder<String> userFeeder = csv("users.csv").random();

    // Correct login check based on your API response
    CheckBuilder loginCheck = jsonPath("$.data.token").saveAs("token");

    // Scenario 1: Register User
    ScenarioBuilder registerUser = scenario("Register User")
            .feed(userFeeder)
            .exec(http("Register")
                    .post("/api/users/register")
                    .body(StringBody("""
                        {
                            "firstName": "#{firstName}",
                            "lastName": "#{lastName}",
                            "email": "#{email}",
                            "password": "#{password}",
                            "userType": "customer"
                        }
                    """))
                    .check(status().in(200, 201, 409)) // Allow 409 for duplicate users
                    .check(status().saveAs("registerStatus"))
            )
            .exec(session -> {
                String status = session.getString("registerStatus");
                if ("200".equals(status) || "201".equals(status)) {
                    System.out.println("User registered successfully");
                } else if ("409".equals(status)) {
                    System.out.println("User already exists (expected for some runs)");
                }
                return session;
            });

    // Scenario 2: Login
    ScenarioBuilder loginUser = scenario("Login User")
            .exec(http("Login")
                    .post("/api/auth/login")
                    .body(StringBody("""
                        {
                            "email": "nischal1@example.com",
                            "password": "123456"
                        }
                    """))
                    .check(status().is(200))
                    .check(loginCheck)
                    .check(jsonPath("$.success").is("true"))
                    .check(jsonPath("$.message").is("Login successful"))
            )
            .exec(session -> {
                String token = session.getString("token");
                if (token != null) {
                    System.out.println("Login successful - Token received, length: " + token.length());
                    System.out.println("Token preview: " + token.substring(0, Math.min(20, token.length())) + "...");
                } else {
                    System.out.println("Login failed - no token received");
                }
                return session;
            });

    // Scenario 3: Get Profile
    ScenarioBuilder getProfile = scenario("Get Profile")
            .exec(http("Login for Profile")
                    .post("/api/auth/login")
                    .body(StringBody("""
                        {
                            "email": "nischal1@example.com",
                            "password": "123456"
                        }
                    """))
                    .check(status().is(200))
                    .check(loginCheck)
                    .check(jsonPath("$.success").is("true"))
            )
            .exec(session -> {
                String token = session.getString("token");
                if (token != null) {
                    System.out.println("Profile - Token length: " + token.length());
                }
                return session;
            })
            .exec(http("Get Profile")
                    .get("/api/users/profile")
                    .header("Authorization", "Bearer #{token}")
                    .check(status().is(200))
            );

    // Scenario 4: Mixed Operations
    ScenarioBuilder mixedOperations = scenario("Mixed Operations")
            .exec(http("Login for Mixed Ops")
                    .post("/api/auth/login")
                    .body(StringBody("""
                        {
                            "email": "nischal1@example.com",
                            "password": "123456"
                        }
                    """))
                    .check(status().is(200))
                    .check(loginCheck)
                    .check(jsonPath("$.success").is("true"))
            )
            .pause(1)
            .exec(http("Get Profile in Mixed")
                    .get("/api/users/profile")
                    .header("Authorization", "Bearer #{token}")
                    .check(status().is(200))
            )
            .pause(1)
            .exec(http("Verify Token")
                    .post("/api/auth/verify")
                    .header("Authorization", "Bearer #{token}")
                    .check(status().is(200))
            );

    // Load Test Configuration
    {
        setUp(
                registerUser.injectOpen(
                        rampUsers(5).during(Duration.ofSeconds(10))
                ),
                loginUser.injectOpen(
                        rampUsers(10).during(Duration.ofSeconds(15))
                ),
                getProfile.injectOpen(
                        rampUsers(8).during(Duration.ofSeconds(10))
                ),
                mixedOperations.injectOpen(
                        constantUsersPerSec(2).during(Duration.ofSeconds(20))
                )
        ).protocols(httpProtocol)
                .assertions(
                        global().responseTime().max().lt(3000),
                        global().successfulRequests().percent().gt(95.0)
                );
    }
}