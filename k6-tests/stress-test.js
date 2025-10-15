import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  vus: 10,
  duration: '30s',
};

const BASE_URL = 'http://localhost:8080/SpringMvcHelloWorld';

export default function () {
  const payload = JSON.stringify({
    email: 'nischal1@example.com',
    password: '123456'
  });

  const res = http.post(`${BASE_URL}/api/auth/login`, payload, {
    headers: { 'Content-Type': 'application/json' },
  });

  check(res, {
    'status is 200': (r) => r.status === 200,
    'response time < 500ms': (r) => r.timings.duration < 500,
    'login successful': (r) => {
      try {
        const body = JSON.parse(r.body);
        return body.success === true;
      } catch (e) {
        return false;
      }
    },
    'has token in response': (r) => {
      try {
        const body = JSON.parse(r.body);
        return body.data && body.data.token !== null;
      } catch (e) {
        return false;
      }
    }
  });

  sleep(1);
}