targetScope = 'resourceGroup'

param location string = resourceGroup().location
param appPrefix string
param repository string = 'NeloBorcram/Jausi'
@allowed(['F1', 'B1'])
param sku string = 'F1'

resource plan 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: '${appPrefix}-plan'
  location: location
  kind: 'linux'
  sku: { name: sku, tier: sku == 'F1' ? 'Free' : 'Basic', capacity: 1 }
  properties: { reserved: true }
}

var environments = ['staging', 'production']

resource identity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = [for env in environments: {
  name: '${appPrefix}-${env}-release'
  location: location
}]

resource federation 'Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials@2023-01-31' = [for (env, i) in environments: {
  name: 'github'
  parent: identity[i]
  properties: {
    issuer: 'https://token.actions.githubusercontent.com'
    subject: 'repo:${repository}:environment:${env}'
    audiences: ['api://AzureADTokenExchange']
  }
}]

resource app 'Microsoft.Web/sites@2024-04-01' = [for env in environments: {
  name: '${appPrefix}-${env}'
  location: location
  kind: 'app,linux'
  properties: {
    serverFarmId: plan.id
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: 'JAVA|21-java21'
      alwaysOn: sku != 'F1'
      ftpsState: 'Disabled'
      minTlsVersion: '1.2'
      healthCheckPath: '/actuator/health'
      appCommandLine: 'java -XX:MaxRAMPercentage=60 -jar /home/site/wwwroot/app.jar'
      appSettings: [
        { name: 'SCM_DO_BUILD_DURING_DEPLOYMENT', value: 'false' }
        { name: 'SPRING_PROFILES_ACTIVE', value: 'azure' }
        { name: 'SERVER_SERVLET_SESSION_COOKIE_SECURE', value: 'true' }
      ]
    }
  }
}]

resource publishing 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2024-04-01' = [for (env, i) in environments: {
  parent: app[i]
  name: 'scm'
  properties: { allow: false }
}]

resource deployRole 'Microsoft.Authorization/roleAssignments@2022-04-01' = [for (env, i) in environments: {
  name: guid(app[i].id, identity[i].id, 'website-contributor')
  scope: app[i]
  properties: {
    principalId: identity[i].properties.principalId
    principalType: 'ServicePrincipal'
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'de139f84-1756-47ae-9be6-808fbbe84772')
  }
}]

output apps array = [for (env, i) in environments: {
  environment: env
  name: app[i].name
  url: 'https://${app[i].properties.defaultHostName}'
  clientId: identity[i].properties.clientId
}]
output tenantId string = tenant().tenantId
output subscriptionId string = subscription().subscriptionId
