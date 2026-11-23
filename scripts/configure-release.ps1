param(
    [Parameter(Mandatory)][string]$DeploymentName,
    [Parameter(Mandatory)][long[]]$ReviewerIds,
    [string]$Repository = 'NeloBorcram/Jausi'
)
$ErrorActionPreference = 'Stop'
if ($ReviewerIds.Count -lt 1) { throw 'Mindestens einen Produktionsreviewer angeben.' }
$raw = az deployment group show -g rg-jausi-app -n $DeploymentName --query properties.outputs -o json
if ($LASTEXITCODE -ne 0) { throw 'Deployment-Ausgaben nicht lesbar.' }
$output = $raw | ConvertFrom-Json
foreach ($app in $output.apps.value) {
    $environment = $app.environment
    $body = @{
        deployment_branch_policy = @{ protected_branches = $false; custom_branch_policies = $true }
        prevent_self_review = $environment -eq 'production'
        can_admins_bypass = $false
    }
    if ($environment -eq 'production') {
        $body.reviewers = @($ReviewerIds | ForEach-Object { @{ type = 'User'; id = $_ } })
    }
    $body | ConvertTo-Json -Depth 5 -Compress | gh api --method PUT "repos/$Repository/environments/$environment" --input -
    if ($LASTEXITCODE -ne 0) { throw "Environment $environment fehlgeschlagen" }
    $policies = gh api "repos/$Repository/environments/$environment/deployment-branch-policies" | ConvertFrom-Json
    if (-not ($policies.branch_policies | Where-Object name -eq 'main')) {
        '{"name":"main","type":"branch"}' | gh api --method POST "repos/$Repository/environments/$environment/deployment-branch-policies" --input -
        if ($LASTEXITCODE -ne 0) { throw 'Branch-Regel fehlgeschlagen' }
    }
    $variables = @{
        AZURE_CLIENT_ID = $app.clientId
        AZURE_TENANT_ID = $output.tenantId.value
        AZURE_SUBSCRIPTION_ID = $output.subscriptionId.value
        AZURE_RESOURCE_GROUP = 'rg-jausi-app'
        AZURE_APP_NAME = $app.name
        APP_URL = $app.url
    }
    foreach ($entry in $variables.GetEnumerator()) {
        gh variable set $entry.Key --body $entry.Value --env $environment --repo $Repository
        if ($LASTEXITCODE -ne 0) { throw "Variable $($entry.Key) fehlgeschlagen" }
    }
}
Write-Output 'Vor APP_RELEASE_ENABLED=true Branch-Regeln und Reviewer auf GitHub prüfen.'
