$ErrorActionPreference = 'Stop'
Push-Location (Join-Path $PSScriptRoot '..')
try {
    if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
        throw 'Node fehlt. Anleitung: docs/implementation.md. Mit nvm die Version aus .nvmrc installieren und aktivieren.'
    }
    $version = node -p 'process.versions.node'
    if ($LASTEXITCODE -ne 0 -or [version]$version -lt [version]'24.12.0' -or [version]$version -ge [version]'25.0.0') {
        throw "Node 24 LTS erforderlich, gefunden: $version. Mit nvm install und nvm use die Version aus .nvmrc aktivieren; siehe docs/implementation.md."
    }
    Push-Location backend
    try {
        ./mvnw.cmd clean
        if ($LASTEXITCODE -ne 0) { throw 'Backend clean failed' }
    } finally { Pop-Location }
    Push-Location frontend
    try {
        npm.cmd ci
        if ($LASTEXITCODE -ne 0) { throw 'npm ci failed' }
        npm.cmd run format:check
        if ($LASTEXITCODE -ne 0) { throw 'Frontend formatting failed' }
        npm.cmd test
        if ($LASTEXITCODE -ne 0) { throw 'Frontend tests failed' }
        npm.cmd run build
        if ($LASTEXITCODE -ne 0) { throw 'Frontend build failed' }
    } finally { Pop-Location }
    $static = 'backend/target/classes/static'
    New-Item -ItemType Directory -Force -Path $static | Out-Null
    Copy-Item frontend/dist/* $static -Recurse -Force
    Push-Location backend
    try {
        ./mvnw.cmd verify
        if ($LASTEXITCODE -ne 0) { throw 'Backend verification failed' }
    } finally { Pop-Location }
} finally { Pop-Location }
