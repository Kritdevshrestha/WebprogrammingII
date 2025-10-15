import http from 'k6/http';
import { check, group, sleep } from 'k6';
import { Rate, Trend } from 'k6/metrics';

// Custom Metrics
const errorRate = new Rate('errors');
const loginDuration = new Trend('login_duration');
const registerDuration = new Trend('register_duration');

// Test Configuration
export const options = {
  stages: [
    { duration: '30s', target: 10 },  // Warm up
    { duration: '1m', target: 20 },   // Normal load
    { duration: '30s', target: 50 },  // Peak load
    { duration: '30s', target: 0 },   // Cool down
  ],
  thresholds: {
    http_req_duration: ['p(95)<1000'],
    http_req_failed: ['rate<0.1'],
    errors: ['rate<0.1'],
  },
};

const BASE_URL = 'http://localhost:8080/SpringMvcHelloWorld';

// Helper function to generate unique email
function generateEmail() {
  return `k6test${Date.now()}${Math.random().toString(36).substr(2, 5)}@example.com`;
}

export default function () {
  let token = null;

  // Test Group 1: User Registration
  group('User Registration', () => {
    const payload = JSON.stringify({
      firstName: 'K6',
      lastName: 'Test',
      email: generateEmail(),
      password: 'password123',
      userType: 'customer'
    });

    const res = http.post(`${BASE_URL}/api/users/register`, payload, {
      headers: { 'Content-Type': 'application/json' },
    });

    registerDuration.add(res.timings.duration);

    const success = check(res, {
      'register: status 200': (r) => r.status === 200,
      'register: success true': (r) => {
        try {
          return JSON.parse(r.body).success === true;
        } catch {
          return false;
        }
      }
    });

    if (!success) {
      console.log('Registration failed. Response:', res.body);
      errorRate.add(1);
    }
  });

  sleep(1);

  // Test Group 2: User Login - FIXED CREDENTIALS
  group('User Login', () => {
    const payload = JSON.stringify({
      email: 'nischal1@example.com',  // CHANGED FROM admin@example.com
      password: '123456'              // CHANGED FROM admin123
    });

    const res = http.post(`${BASE_URL}/api/auth/login`, payload, {
      headers: { 'Content-Type': 'application/json' },
    });

    loginDuration.add(res.timings.duration);

    const success = check(res, {
      'login: status 200': (r) => r.status === 200,
      'login: success true': (r) => {
        try {
          const body = JSON.parse(r.body);
          token = body.data.token;
          return body.success === true;
        } catch {
          return false;
        }
      },
      'login: has token': (r) => {
        try {
          const body = JSON.parse(r.body);
          return body.data.token !== null;
        } catch {
          return false;
        }
      }
    });

    if (!success) {
      console.log('Login failed. Status:', res.status, 'Response:', res.body);
      errorRate.add(1);
    }
  });

  if (!token) {
    console.log('Login failed, skipping authenticated tests');
    return;
  }

  sleep(1);

  // Test Group 3: Get User Profile
  group('Get User Profile', () => {
    const res = http.get(`${BASE_URL}/api/users/profile`, {
      headers: {
        'Authorization': `Bearer ${token}`,
        'Content-Type': 'application/json',
      },
    });

    const success = check(res, {
      'profile: status 200': (r) => r.status === 200,
      'profile: success true': (r) => {
        try {
          return JSON.parse(r.body).success === true;
        } catch {
          return false;
        }
      },
      'profile: has user data': (r) => {
        try {
          return JSON.parse(r.body).data !== undefined;
        } catch {
          return false;
        }
      }
    });

    if (!success) {
      console.log('Profile fetch failed. Status:', res.status, 'Response:', res.body);
      errorRate.add(1);
    }
  });

  sleep(1);

  // Test Group 4: Verify Token
  group('Verify Token', () => {
    const res = http.post(`${BASE_URL}/api/auth/verify`, JSON.stringify({}), {
      headers: {
        'Authorization': `Bearer ${token}`,
        'Content-Type': 'application/json',
      },
    });

    const success = check(res, {
      'verify: status 200': (r) => r.status === 200,
      'verify: valid token': (r) => {
        try {
          const body = JSON.parse(r.body);
          return body.valid === true || body.success === true;
        } catch {
          return false;
        }
      }
    });

    if (!success) {
      console.log('Token verification failed. Status:', res.status, 'Response:', res.body);
      errorRate.add(1);
    }
  });

  sleep(1);
}

// Setup function (runs once before test)
export function setup() {
  console.log('Starting K6 load test...');
  console.log(`Target URL: ${BASE_URL}`);
  return { timestamp: Date.now() };
}

// Teardown function (runs once after test)
export function teardown(data) {
  console.log('Load test completed!');
  console.log(`Duration: ${(Date.now() - data.timestamp) / 1000}s`);
}