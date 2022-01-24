param name string
param crossTenantRoleAssignment bool = false
param location string = resourceGroup().location

var appRoleDefinitionId = 'acdd72a7-3385-48ef-bd42-f606fba81ae7'  // Reader

// 'managedBy': '/subscriptions/<subscription_id>/resourceGroups/<outer_resource_group>/providers/Microsoft.Solutions/applications/<app_name>'
var _managedBy = split(resourceGroup().managedBy, '/')
var _appResourceGroupName = _managedBy[4]
var _appName = _managedBy[8]
var _subscription = _managedBy[2]

module userAssignedIdentity 'managedIdentity/userAssignedIdentities.bicep' = {
  name: 'userAssignedIdentityDeploy'
  params: {
    name: name
    location: location
  }
}

module appRoleAssignment 'authorization/appRoleAssignments.bicep' = {
  name: 'appRoleAssignment'
  scope: resourceGroup(_subscription, _appResourceGroupName)
  params: {
    sub: _subscription
    userId: userAssignedIdentity.outputs.id
    userName: userAssignedIdentity.outputs.name
    appName: _appName
    appResourceGroupName: _appResourceGroupName
    crossTenantRoleAssignment: crossTenantRoleAssignment
    principalId: userAssignedIdentity.outputs.principalId
    appRoleDefinitionId: appRoleDefinitionId
  }
}
