param aapName string = 'aap${uniqueString(utcNow())}'

@description('Enable cross tenant support for role assignments')
param crossTenantRoleAssignment bool


@description('Location for resource deployment')
param location string = resourceGroup().location

module identityDeploy 'modules/identity.bicep' = {
  name: 'identityAAPDeploy'
  params: {
    name: aapName
    location: location
    crossTenantRoleAssignment: crossTenantRoleAssignment
  }
}

