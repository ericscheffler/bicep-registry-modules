targetScope = 'subscription'

metadata name = 'Using large parameter set'
metadata description = 'This instance deploys the module with a large parameter set.'

// ========== //
// Parameters //
// ========== //

@description('Optional. The name of the resource group to deploy for testing purposes.')
@maxLength(90)
param resourceGroupName string = 'dep-${namePrefix}-network.virtual-wan-${serviceShort}-rg'

@description('Optional. The location to deploy resources to.')
param resourceLocation string = deployment().location

@description('Optional. A short identifier for the kind of deployment. Should be kept short to not run into resource-name length-constraints.')
param serviceShort string = 'nvwanmax'

@description('Optional. A token to inject into the name of each resource. This value can be automatically injected by the CI.')
//param namePrefix string = '#_namePrefix_#'
param namePrefix string = 'maxTest'

// ============ //
// Dependencies //
// ============ //

// General resources
// =================
resource resourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: resourceLocation
}

// ============== //
// Test Execution //
// ============== //

module nestedDependencies 'dependencies.bicep' = {
  scope: resourceGroup
  name: '${uniqueString(deployment().name, resourceLocation)}-nestedDependencies'
  params: {
    azureFirewallPolicyName: 'dep-${namePrefix}-fwp-${serviceShort}'
    virtualNetwork1Name: 'dep-${namePrefix}-vnet1-${serviceShort}'
    virtualNetwork1Location: 'eastus'
    virtualNetwork2Name: 'dep-${namePrefix}-vnet2-${serviceShort}'
    virtualNetwork2Location: 'westus2'
    publicIPPrefixName: 'dep-${namePrefix}-pip-prefix-${serviceShort}'
    managedIdentityName: 'dep-${namePrefix}-mi-${serviceShort}'
  }
}

@batchSize(1)
module testDeployment '../../../main.bicep' = [
  for iteration in ['init', 'idem']: {
    scope: resourceGroup
    name: '${uniqueString(deployment().name, resourceLocation)}-test-${serviceShort}-${iteration}'
    params: {
      virtualWanParameters: {
        virtualWanName: 'dep-${namePrefix}-vwan-${serviceShort}'
        location: resourceLocation
        allowBranchToBranchTraffic: true
        type: 'Standard'
        p2sVpnParameters: {
          createP2sVpnServerConfiguration: true
          p2sVpnServerConfigurationName: 'dep-${namePrefix}-p2s-${serviceShort}'
          vpnAuthenticationTypes: ['AAD']
          aadTenant: '${environment().authentication.loginEndpoint}11111111-1111-1111-1111-111111111111'
          aadAudience: '11111111-1234-4321-1234-111111111111'
          aadIssuer: 'https://sts.windows.net/11111111-1111-1111-1111-111111111111/'
        }
        tags: {
          Environment: 'Test'
          CostCenter: 'IT'
        }
      }
      virtualHubParameters: [
        {
          hubAddressPrefix: '10.0.0.0/24'
          hubLocation: resourceLocation
          hubName: 'dep-${namePrefix}-hub-${resourceLocation}-${serviceShort}'
          allowBranchToBranchTraffic: true
          hubRoutingPreference: 'VpnGateway'
          p2sVpnParameters: {
            deployP2SVpnGateway: true
            vpnGatewayName: 'dep-${namePrefix}-p2s-gw-${serviceShort}'
            connectionConfigurationsName: 'default'
            vpnClientAddressPoolAddressPrefixes: ['192.168.1.0/24']
            vpnGatewayScaleUnit: 1
            vpnGatewayAssociatedRouteTable: 'defaultRouteTable'
          }
          s2sVpnParameters: {
            deployS2SVpnGateway: true
            vpnGatewayName: 'dep-${namePrefix}-s2s-gw-${serviceShort}'
            vpnGatewayScaleUnit: 1
          }
          expressRouteParameters: {
            deployExpressRouteGateway: false
            expressRouteGatewayName: 'unused'
          }
          secureHubParameters: {
            deploySecureHub: true
            azureFirewallName: 'dep-${namePrefix}-fw-${serviceShort}'
            azureFirewallSku: 'Premium'
            azureFirewallPublicIPCount: 2
            firewallPolicyResourceId: nestedDependencies.outputs.azureFirewallPolicyResourceId
            publicIPAddressObject: {
              name: 'dep-${namePrefix}-fw-pip-${serviceShort}'
              publicIPAllocationMethod: 'Static'
              publicIPPrefixResourceId: nestedDependencies.outputs.publicIPPrefixResourceId
              skuName: 'Standard'
              skuTier: 'Regional'
            }
            availabilityZones: [1, 2, 3]
            threatIntelMode: 'Alert'
            autoscaleMinCapacity: 2
            autoscaleMaxCapacity: 10
            diagnosticSettings: [
              {
                name: 'diag-fw-${serviceShort}'
                logCategoriesAndGroups: [
                  {
                    categoryGroup: 'allLogs'
                    enabled: true
                  }
                ]
                metricCategories: [
                  {
                    category: 'AllMetrics'
                    enabled: true
                  }
                ]
              }
            ]
            roleAssignments: [
              {
                name: guid('Custom seed ${namePrefix}${serviceShort}')
                roleDefinitionIdOrName: 'Reader'
                principalId: nestedDependencies.outputs.managedIdentityPrincipalId
                principalType: 'ServicePrincipal'
              }
            ]
            routingIntent: {
              internetToFirewall: true
              privateToFirewall: true
            }
          }
          hubVirtualNetworkConnections: [
            {
              name: nestedDependencies.outputs.virtualNetwork1Name
              remoteVirtualNetworkResourceId: nestedDependencies.outputs.virtualNetwork1ResourceId
              enableInternetSecurity: true
            }
            {
              name: nestedDependencies.outputs.virtualNetwork2Name
              remoteVirtualNetworkResourceId: nestedDependencies.outputs.virtualNetwork2ResourceId
              enableInternetSecurity: true
            }
          ]
          tags: {
            HubType: 'Secure'
            FirewallEnabled: 'true'
          }
        }
      ]
      tags: {
        'hidden-title': 'This is visible in the resource name'
        Environment: 'Non-Prod'
        Role: 'DeploymentValidation'
      }
    }
  }
]
