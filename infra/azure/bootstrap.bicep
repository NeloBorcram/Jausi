targetScope = 'subscription'

param location string
param stateResourceGroup string
param stateAccountName string
@description('Object ID of the operator or group that runs Terraform.')
param operatorObjectId string
@allowed(['User', 'Group', 'ServicePrincipal'])
param operatorType string = 'User'

resource group 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: stateResourceGroup
  location: location
}

module storage 'state.bicep' = {
  name: 'jausi-tfstate'
  scope: group
  params: {
    location: location
    accountName: stateAccountName
    operatorObjectId: operatorObjectId
    operatorType: operatorType
  }
}
