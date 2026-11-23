targetScope = 'subscription'

param location string = 'germanywestcentral'
param resourceGroupName string = 'rg-jausi-app'
param appPrefix string = 'jausi-m026'
@allowed(['F1', 'B1'])
param sku string = 'F1'

resource group 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: location
}

module hosting 'main.bicep' = {
  name: 'jausi-app'
  scope: group
  params: {
    appPrefix: appPrefix
    sku: sku
  }
}

output deployment object = hosting.outputs
