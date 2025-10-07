@description('Required. The name of the Azure Firewall Policy.')
param azureFirewallPolicyName string

@description('Required. The name of the first virtual network.')
param virtualNetwork1Name string

@description('Required. The location of the first virtual network.')
param virtualNetwork1Location string

@description('Required. The name of the second virtual network.')
param virtualNetwork2Name string

@description('Required. The location of the second virtual network.')
param virtualNetwork2Location string

@description('Required. The name of the public IP prefix for Azure Firewall.')
param publicIPPrefixName string

@description('Required. The name of the managed identity.')
param managedIdentityName string

resource azureFirewallPolicy 'Microsoft.Network/firewallPolicies@2024-07-01' = {
  name: azureFirewallPolicyName
  location: resourceGroup().location
  properties: {
    sku: {
      tier: 'Premium'
    }
    threatIntelMode: 'Alert'
    threatIntelWhitelist: {
      fqdns: []
      ipAddresses: []
    }
    dnsSettings: {
      servers: []
      enableProxy: true
    }
  }
}

resource publicIPPrefix 'Microsoft.Network/publicIPPrefixes@2024-07-01' = {
  name: publicIPPrefixName
  location: resourceGroup().location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    prefixLength: 28
    publicIPAddressVersion: 'IPv4'
  }
}

resource vnet1 'Microsoft.Network/virtualNetworks@2024-07-01' = {
  name: virtualNetwork1Name
  location: virtualNetwork1Location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/24'
      ]
    }
  }
}

resource vnet2 'Microsoft.Network/virtualNetworks@2024-07-01' = {
  name: virtualNetwork2Name
  location: virtualNetwork2Location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.2.0.0/24'
      ]
    }
  }
}

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2024-11-30' = {
  name: managedIdentityName
  location: resourceGroup().location
}

@description('The ID of the Azure Firewall Policy.')
output azureFirewallPolicyResourceId string = azureFirewallPolicy.id

@description('The resource ID of the public IP prefix.')
output publicIPPrefixResourceId string = publicIPPrefix.id

@description('The resource ID of the first virtual network.')
output virtualNetwork1ResourceId string = vnet1.id

@description('The name of the first virtual network.')
output virtualNetwork1Name string = vnet1.name

@description('The location of the first virtual network.')
output virtualNetwork1Location string = vnet1.location

@description('The location of the first virtual hub; for testing purposes set as same region of the spoke virtual network.')
output virtualHub1Location string = vnet1.location

@description('The resource ID of the second virtual network.')
output virtualNetwork2ResourceId string = vnet2.id

@description('The name of the second virtual network.')
output virtualNetwork2Name string = vnet2.name

@description('The location of the second virtual network.')
output virtualNetwork2Location string = vnet2.location

@description('The location of the second virtual hub; for testing purposes set as same region of the spoke virtual network.')
output virtualHub2Location string = vnet2.location

@description('The resource ID of the managed identity.')
output managedIdentityPrincipalId string = managedIdentity.properties.principalId
