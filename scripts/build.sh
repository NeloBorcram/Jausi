#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
if ! command -v node >/dev/null || ! node -e 'const [major,minor]=process.versions.node.split(".").map(Number); process.exit(major===24 && minor>=12 ? 0 : 1)'; then
  echo 'Node 24 LTS erforderlich: nvm install && nvm use (im Repository). Siehe docs/implementation.md.' >&2
  exit 1
fi
(cd frontend && npm ci && npm run format:check && npm test && npm run build)
(cd backend && bash mvnw clean)
mkdir -p backend/target/classes/static
cp -r frontend/dist/. backend/target/classes/static/
(cd backend && bash mvnw verify -B)
