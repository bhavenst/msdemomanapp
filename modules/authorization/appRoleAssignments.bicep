param userName string
param sub string
param appName string
param appResourceGroupName string
param userId string
param crossTenantRoleAssignment bool = false
param appRoleDefinitionId string
param principalId string
param principalType string = 'ServicePrincipal'

var _delegatedManagedIdentityResourceId = crossTenantRoleAssignment ? userId: ''
var _roleDefinitionId = resourceId('Microsoft.Authorization/roleDefinitions', appRoleDefinitionId)
var _name = guid(resourceGroup().id, userName, appRoleDefinitionId)

resource managedApp 'Microsoft.Solutions/applications@2021-07-01' existing = {
  name: appName
  scope: resourceGroup(sub, appResourceGroupName)
}

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2020-10-01-preview' = {
  name: _name
  scope: managedApp
  properties: {
    delegatedManagedIdentityResourceId: _delegatedManagedIdentityResourceId
    roleDefinitionId: _roleDefinitionId
    principalId: principalId
    principalType: principalType
  }
}
