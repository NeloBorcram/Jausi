import { createServer } from 'node:http';
import { readFileSync } from 'node:fs';

const version = readFileSync(new URL('./version.txt', import.meta.url), 'utf8').trim();
const welcome = readFileSync(new URL('./index.html', import.meta.url));
const assets = new Map([
  ['/jausi-icon.svg', ['image/svg+xml', readFileSync(new URL('./jausi-icon.svg', import.meta.url))]],
  ['/jausi-mascot.png', ['image/png', readFileSync(new URL('./jausi-mascot.png', import.meta.url))]],
]);
const port = Number(process.env.PORT || 8080);

createServer((request, response) => {
  const path = new URL(request.url, 'http://localhost').pathname;
  response.setHeader('Cache-Control', 'no-store');
  if (assets.has(path)) {
    const [contentType, body] = assets.get(path);
    response.setHeader('Content-Type', contentType);
    response.end(body);
    return;
  }
  if (path === '/') {
    response.setHeader('Content-Type', 'text/html; charset=utf-8');
    response.end(welcome);
    return;
  }
  response.setHeader('Content-Type', 'text/plain; charset=utf-8');
  if (path === '/healthz') response.end('ok');
  else if (path === '/version') response.end(version);
  else {
    response.statusCode = 404;
    response.end('Not found');
  }
}).listen(port, '0.0.0.0');
