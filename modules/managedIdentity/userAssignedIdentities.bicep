param location string = resourceGroup().location
param name string

var identity = 'id-${name}-${location}'

resource userAssignedIdentities 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: identity
  location: location
}

output id string  = userAssignedIdentities.id
output name string = userAssignedIdentities.name
output principalId string = userAssignedIdentities.properties.principalId
output tenantId string = userAssignedIdentities.properties.tenantId
