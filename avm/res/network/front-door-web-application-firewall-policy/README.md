# Front Door Web Application Firewall (WAF) Policies `[Microsoft.Network/FrontDoorWebApplicationFirewallPolicies]`

This module deploys a Front Door Web Application Firewall (WAF) Policy.

## Navigation

- [Resource Types](#Resource-Types)
- [Usage examples](#Usage-examples)
- [Parameters](#Parameters)
- [Outputs](#Outputs)
- [Cross-referenced modules](#Cross-referenced-modules)
- [Data Collection](#Data-Collection)

## Resource Types

| Resource Type | API Version |
| :-- | :-- |
| `Microsoft.Authorization/locks` | [2020-05-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Authorization/2020-05-01/locks) |
| `Microsoft.Authorization/roleAssignments` | [2022-04-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Authorization/2022-04-01/roleAssignments) |
| `Microsoft.Network/FrontDoorWebApplicationFirewallPolicies` | [2024-02-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Network/2024-02-01/FrontDoorWebApplicationFirewallPolicies) |

## Usage examples

The following section provides usage examples for the module, which were used to validate and deploy the module successfully. For a full reference, please review the module's test folder in its repository.

>**Note**: Each example lists all the required parameters first, followed by the rest - each in alphabetical order.

>**Note**: To reference the module, please use the following syntax `br/public:avm/res/network/front-door-web-application-firewall-policy:<version>`.

- [Using only defaults](#example-1-using-only-defaults)
- [Using large parameter set](#example-2-using-large-parameter-set)
- [WAF-aligned](#example-3-waf-aligned)

### Example 1: _Using only defaults_

This instance deploys the module with the minimum set of required parameters.


<details>

<summary>via Bicep module</summary>

```bicep
module frontDoorWebApplicationFirewallPolicy 'br/public:avm/res/network/front-door-web-application-firewall-policy:<version>' = {
  name: 'frontDoorWebApplicationFirewallPolicyDeployment'
  params: {
    // Required parameters
    name: 'nagwafpmin001'
    // Non-required parameters
    location: '<location>'
  }
}
```

</details>
<p>

<details>

<summary>via JSON parameters file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "name": {
      "value": "nagwafpmin001"
    },
    // Non-required parameters
    "location": {
      "value": "<location>"
    }
  }
}
```

</details>
<p>

<details>

<summary>via Bicep parameters file</summary>

```bicep-params
using 'br/public:avm/res/network/front-door-web-application-firewall-policy:<version>'

// Required parameters
param name = 'nagwafpmin001'
// Non-required parameters
param location = '<location>'
```

</details>
<p>

### Example 2: _Using large parameter set_

This instance deploys the module with most of its features enabled.


<details>

<summary>via Bicep module</summary>

```bicep
module frontDoorWebApplicationFirewallPolicy 'br/public:avm/res/network/front-door-web-application-firewall-policy:<version>' = {
  name: 'frontDoorWebApplicationFirewallPolicyDeployment'
  params: {
    // Required parameters
    name: 'nagwafpmax001'
    // Non-required parameters
    customRules: {
      rules: [
        {
          action: 'Block'
          enabledState: 'Enabled'
          matchConditions: [
            {
              matchValue: [
                'CH'
              ]
              matchVariable: 'RemoteAddr'
              negateCondition: false
              operator: 'GeoMatch'
              selector: '<selector>'
              transforms: []
            }
            {
              matchValue: [
                'windows'
              ]
              matchVariable: 'RequestHeader'
              negateCondition: false
              operator: 'Contains'
              selector: 'UserAgent'
              transforms: []
            }
            {
              matchValue: [
                '?>'
                '<?php'
              ]
              matchVariable: 'QueryString'
              negateCondition: false
              operator: 'Contains'
              transforms: [
                'Lowercase'
                'UrlDecode'
              ]
            }
          ]
          name: 'CustomRule1'
          priority: 2
          rateLimitDurationInMinutes: 1
          rateLimitThreshold: 10
          ruleType: 'MatchRule'
        }
      ]
    }
    location: '<location>'
    lock: {
      kind: 'CanNotDelete'
      name: 'myCustomLockName'
    }
    managedRules: {
      managedRuleSets: [
        {
          ruleSetType: 'Microsoft_BotManagerRuleSet'
          ruleSetVersion: '1.0'
        }
      ]
    }
    policySettings: {
      customBlockResponseBody: 'PGh0bWw+CjxoZWFkZXI+PHRpdGxlPkhlbGxvPC90aXRsZT48L2hlYWRlcj4KPGJvZHk+CkhlbGxvIHdvcmxkCjwvYm9keT4KPC9odG1sPg=='
      customBlockResponseStatusCode: 200
      mode: 'Prevention'
      redirectUrl: 'http://www.bing.com'
    }
    roleAssignments: [
      {
        name: 'bb049c96-2571-4a25-b760-444ab25d86ed'
        principalId: '<principalId>'
        principalType: 'ServicePrincipal'
        roleDefinitionIdOrName: 'Owner'
      }
      {
        name: '<name>'
        principalId: '<principalId>'
        principalType: 'ServicePrincipal'
        roleDefinitionIdOrName: 'b24988ac-6180-42a0-ab88-20f7382dd24c'
      }
      {
        principalId: '<principalId>'
        principalType: 'ServicePrincipal'
        roleDefinitionIdOrName: '<roleDefinitionIdOrName>'
      }
    ]
    sku: 'Premium_AzureFrontDoor'
    tags: {
      Environment: 'Non-Prod'
      'hidden-title': 'This is visible in the resource name'
      Role: 'DeploymentValidation'
    }
  }
}
```

</details>
<p>

<details>

<summary>via JSON parameters file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "name": {
      "value": "nagwafpmax001"
    },
    // Non-required parameters
    "customRules": {
      "value": {
        "rules": [
          {
            "action": "Block",
            "enabledState": "Enabled",
            "matchConditions": [
              {
                "matchValue": [
                  "CH"
                ],
                "matchVariable": "RemoteAddr",
                "negateCondition": false,
                "operator": "GeoMatch",
                "selector": "<selector>",
                "transforms": []
              },
              {
                "matchValue": [
                  "windows"
                ],
                "matchVariable": "RequestHeader",
                "negateCondition": false,
                "operator": "Contains",
                "selector": "UserAgent",
                "transforms": []
              },
              {
                "matchValue": [
                  "?>",
                  "<?php"
                ],
                "matchVariable": "QueryString",
                "negateCondition": false,
                "operator": "Contains",
                "transforms": [
                  "Lowercase",
                  "UrlDecode"
                ]
              }
            ],
            "name": "CustomRule1",
            "priority": 2,
            "rateLimitDurationInMinutes": 1,
            "rateLimitThreshold": 10,
            "ruleType": "MatchRule"
          }
        ]
      }
    },
    "location": {
      "value": "<location>"
    },
    "lock": {
      "value": {
        "kind": "CanNotDelete",
        "name": "myCustomLockName"
      }
    },
    "managedRules": {
      "value": {
        "managedRuleSets": [
          {
            "ruleSetType": "Microsoft_BotManagerRuleSet",
            "ruleSetVersion": "1.0"
          }
        ]
      }
    },
    "policySettings": {
      "value": {
        "customBlockResponseBody": "PGh0bWw+CjxoZWFkZXI+PHRpdGxlPkhlbGxvPC90aXRsZT48L2hlYWRlcj4KPGJvZHk+CkhlbGxvIHdvcmxkCjwvYm9keT4KPC9odG1sPg==",
        "customBlockResponseStatusCode": 200,
        "mode": "Prevention",
        "redirectUrl": "http://www.bing.com"
      }
    },
    "roleAssignments": {
      "value": [
        {
          "name": "bb049c96-2571-4a25-b760-444ab25d86ed",
          "principalId": "<principalId>",
          "principalType": "ServicePrincipal",
          "roleDefinitionIdOrName": "Owner"
        },
        {
          "name": "<name>",
          "principalId": "<principalId>",
          "principalType": "ServicePrincipal",
          "roleDefinitionIdOrName": "b24988ac-6180-42a0-ab88-20f7382dd24c"
        },
        {
          "principalId": "<principalId>",
          "principalType": "ServicePrincipal",
          "roleDefinitionIdOrName": "<roleDefinitionIdOrName>"
        }
      ]
    },
    "sku": {
      "value": "Premium_AzureFrontDoor"
    },
    "tags": {
      "value": {
        "Environment": "Non-Prod",
        "hidden-title": "This is visible in the resource name",
        "Role": "DeploymentValidation"
      }
    }
  }
}
```

</details>
<p>

<details>

<summary>via Bicep parameters file</summary>

```bicep-params
using 'br/public:avm/res/network/front-door-web-application-firewall-policy:<version>'

// Required parameters
param name = 'nagwafpmax001'
// Non-required parameters
param customRules = {
  rules: [
    {
      action: 'Block'
      enabledState: 'Enabled'
      matchConditions: [
        {
          matchValue: [
            'CH'
          ]
          matchVariable: 'RemoteAddr'
          negateCondition: false
          operator: 'GeoMatch'
          selector: '<selector>'
          transforms: []
        }
        {
          matchValue: [
            'windows'
          ]
          matchVariable: 'RequestHeader'
          negateCondition: false
          operator: 'Contains'
          selector: 'UserAgent'
          transforms: []
        }
        {
          matchValue: [
            '?>'
            '<?php'
          ]
          matchVariable: 'QueryString'
          negateCondition: false
          operator: 'Contains'
          transforms: [
            'Lowercase'
            'UrlDecode'
          ]
        }
      ]
      name: 'CustomRule1'
      priority: 2
      rateLimitDurationInMinutes: 1
      rateLimitThreshold: 10
      ruleType: 'MatchRule'
    }
  ]
}
param location = '<location>'
param lock = {
  kind: 'CanNotDelete'
  name: 'myCustomLockName'
}
param managedRules = {
  managedRuleSets: [
    {
      ruleSetType: 'Microsoft_BotManagerRuleSet'
      ruleSetVersion: '1.0'
    }
  ]
}
param policySettings = {
  customBlockResponseBody: 'PGh0bWw+CjxoZWFkZXI+PHRpdGxlPkhlbGxvPC90aXRsZT48L2hlYWRlcj4KPGJvZHk+CkhlbGxvIHdvcmxkCjwvYm9keT4KPC9odG1sPg=='
  customBlockResponseStatusCode: 200
  mode: 'Prevention'
  redirectUrl: 'http://www.bing.com'
}
param roleAssignments = [
  {
    name: 'bb049c96-2571-4a25-b760-444ab25d86ed'
    principalId: '<principalId>'
    principalType: 'ServicePrincipal'
    roleDefinitionIdOrName: 'Owner'
  }
  {
    name: '<name>'
    principalId: '<principalId>'
    principalType: 'ServicePrincipal'
    roleDefinitionIdOrName: 'b24988ac-6180-42a0-ab88-20f7382dd24c'
  }
  {
    principalId: '<principalId>'
    principalType: 'ServicePrincipal'
    roleDefinitionIdOrName: '<roleDefinitionIdOrName>'
  }
]
param sku = 'Premium_AzureFrontDoor'
param tags = {
  Environment: 'Non-Prod'
  'hidden-title': 'This is visible in the resource name'
  Role: 'DeploymentValidation'
}
```

</details>
<p>

### Example 3: _WAF-aligned_

This instance deploys the module in alignment with the best-practices of the Azure Well-Architected Framework.


<details>

<summary>via Bicep module</summary>

```bicep
module frontDoorWebApplicationFirewallPolicy 'br/public:avm/res/network/front-door-web-application-firewall-policy:<version>' = {
  name: 'frontDoorWebApplicationFirewallPolicyDeployment'
  params: {
    // Required parameters
    name: 'nagwafpwaf001'
    // Non-required parameters
    customRules: {
      rules: [
        {
          action: 'Block'
          enabledState: 'Enabled'
          matchConditions: [
            {
              matchValue: [
                'CH'
              ]
              matchVariable: 'RemoteAddr'
              negateCondition: false
              operator: 'GeoMatch'
              selector: '<selector>'
              transforms: []
            }
            {
              matchValue: [
                'windows'
              ]
              matchVariable: 'RequestHeader'
              negateCondition: false
              operator: 'Contains'
              selector: 'UserAgent'
              transforms: []
            }
            {
              matchValue: [
                '?>'
                '<?php'
              ]
              matchVariable: 'QueryString'
              negateCondition: false
              operator: 'Contains'
              transforms: [
                'Lowercase'
                'UrlDecode'
              ]
            }
          ]
          name: 'CustomRule1'
          priority: 2
          rateLimitDurationInMinutes: 1
          rateLimitThreshold: 10
          ruleType: 'MatchRule'
        }
      ]
    }
    location: '<location>'
    managedRules: {
      managedRuleSets: [
        {
          ruleSetType: 'Microsoft_BotManagerRuleSet'
          ruleSetVersion: '1.0'
        }
      ]
    }
    policySettings: {
      customBlockResponseBody: 'PGh0bWw+CjxoZWFkZXI+PHRpdGxlPkhlbGxvPC90aXRsZT48L2hlYWRlcj4KPGJvZHk+CkhlbGxvIHdvcmxkCjwvYm9keT4KPC9odG1sPg=='
      customBlockResponseStatusCode: 200
      mode: 'Prevention'
      redirectUrl: 'http://www.bing.com'
    }
    sku: 'Premium_AzureFrontDoor'
    tags: {
      Environment: 'Non-Prod'
      'hidden-title': 'This is visible in the resource name'
      Role: 'DeploymentValidation'
    }
  }
}
```

</details>
<p>

<details>

<summary>via JSON parameters file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "name": {
      "value": "nagwafpwaf001"
    },
    // Non-required parameters
    "customRules": {
      "value": {
        "rules": [
          {
            "action": "Block",
            "enabledState": "Enabled",
            "matchConditions": [
              {
                "matchValue": [
                  "CH"
                ],
                "matchVariable": "RemoteAddr",
                "negateCondition": false,
                "operator": "GeoMatch",
                "selector": "<selector>",
                "transforms": []
              },
              {
                "matchValue": [
                  "windows"
                ],
                "matchVariable": "RequestHeader",
                "negateCondition": false,
                "operator": "Contains",
                "selector": "UserAgent",
                "transforms": []
              },
              {
                "matchValue": [
                  "?>",
                  "<?php"
                ],
                "matchVariable": "QueryString",
                "negateCondition": false,
                "operator": "Contains",
                "transforms": [
                  "Lowercase",
                  "UrlDecode"
                ]
              }
            ],
            "name": "CustomRule1",
            "priority": 2,
            "rateLimitDurationInMinutes": 1,
            "rateLimitThreshold": 10,
            "ruleType": "MatchRule"
          }
        ]
      }
    },
    "location": {
      "value": "<location>"
    },
    "managedRules": {
      "value": {
        "managedRuleSets": [
          {
            "ruleSetType": "Microsoft_BotManagerRuleSet",
            "ruleSetVersion": "1.0"
          }
        ]
      }
    },
    "policySettings": {
      "value": {
        "customBlockResponseBody": "PGh0bWw+CjxoZWFkZXI+PHRpdGxlPkhlbGxvPC90aXRsZT48L2hlYWRlcj4KPGJvZHk+CkhlbGxvIHdvcmxkCjwvYm9keT4KPC9odG1sPg==",
        "customBlockResponseStatusCode": 200,
        "mode": "Prevention",
        "redirectUrl": "http://www.bing.com"
      }
    },
    "sku": {
      "value": "Premium_AzureFrontDoor"
    },
    "tags": {
      "value": {
        "Environment": "Non-Prod",
        "hidden-title": "This is visible in the resource name",
        "Role": "DeploymentValidation"
      }
    }
  }
}
```

</details>
<p>

<details>

<summary>via Bicep parameters file</summary>

```bicep-params
using 'br/public:avm/res/network/front-door-web-application-firewall-policy:<version>'

// Required parameters
param name = 'nagwafpwaf001'
// Non-required parameters
param customRules = {
  rules: [
    {
      action: 'Block'
      enabledState: 'Enabled'
      matchConditions: [
        {
          matchValue: [
            'CH'
          ]
          matchVariable: 'RemoteAddr'
          negateCondition: false
          operator: 'GeoMatch'
          selector: '<selector>'
          transforms: []
        }
        {
          matchValue: [
            'windows'
          ]
          matchVariable: 'RequestHeader'
          negateCondition: false
          operator: 'Contains'
          selector: 'UserAgent'
          transforms: []
        }
        {
          matchValue: [
            '?>'
            '<?php'
          ]
          matchVariable: 'QueryString'
          negateCondition: false
          operator: 'Contains'
          transforms: [
            'Lowercase'
            'UrlDecode'
          ]
        }
      ]
      name: 'CustomRule1'
      priority: 2
      rateLimitDurationInMinutes: 1
      rateLimitThreshold: 10
      ruleType: 'MatchRule'
    }
  ]
}
param location = '<location>'
param managedRules = {
  managedRuleSets: [
    {
      ruleSetType: 'Microsoft_BotManagerRuleSet'
      ruleSetVersion: '1.0'
    }
  ]
}
param policySettings = {
  customBlockResponseBody: 'PGh0bWw+CjxoZWFkZXI+PHRpdGxlPkhlbGxvPC90aXRsZT48L2hlYWRlcj4KPGJvZHk+CkhlbGxvIHdvcmxkCjwvYm9keT4KPC9odG1sPg=='
  customBlockResponseStatusCode: 200
  mode: 'Prevention'
  redirectUrl: 'http://www.bing.com'
}
param sku = 'Premium_AzureFrontDoor'
param tags = {
  Environment: 'Non-Prod'
  'hidden-title': 'This is visible in the resource name'
  Role: 'DeploymentValidation'
}
```

</details>
<p>

## Parameters

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`name`](#parameter-name) | string | Name of the Front Door WAF policy. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`customRules`](#parameter-customrules) | object | The custom rules inside the policy. |
| [`enableTelemetry`](#parameter-enabletelemetry) | bool | Enable/Disable usage telemetry for module. |
| [`location`](#parameter-location) | string | Location for all resources. |
| [`lock`](#parameter-lock) | object | The lock settings of the service. |
| [`managedRules`](#parameter-managedrules) | object | Describes the managedRules structure. |
| [`policySettings`](#parameter-policysettings) | object | The PolicySettings for policy. |
| [`roleAssignments`](#parameter-roleassignments) | array | Array of role assignments to create. |
| [`sku`](#parameter-sku) | string | The pricing tier of the WAF profile. |
| [`tags`](#parameter-tags) | object | Resource tags. |

### Parameter: `name`

Name of the Front Door WAF policy.

- Required: Yes
- Type: string

### Parameter: `customRules`

The custom rules inside the policy.

- Required: No
- Type: object
- Default:
  ```Bicep
  {
      rules: [
        {
          action: 'Block'
          enabledState: 'Enabled'
          matchConditions: [
            {
              matchValue: [
                'ZZ'
              ]
              matchVariable: 'RemoteAddr'
              negateCondition: true
              operator: 'GeoMatch'
            }
          ]
          name: 'ApplyGeoFilter'
          priority: 100
          ruleType: 'MatchRule'
        }
      ]
  }
  ```

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`rules`](#parameter-customrulesrules) | array | List of rules. |

### Parameter: `customRules.rules`

List of rules.

- Required: No
- Type: array

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`action`](#parameter-customrulesrulesaction) | string | Describes what action to be applied when rule matches. |
| [`enabledState`](#parameter-customrulesrulesenabledstate) | string | Describes if the custom rule is in enabled or disabled state. |
| [`matchConditions`](#parameter-customrulesrulesmatchconditions) | array | List of match conditions. See https://learn.microsoft.com/en-us/azure/templates/microsoft.network/frontdoorwebapplicationfirewallpolicies#matchcondition for details. |
| [`name`](#parameter-customrulesrulesname) | string | Describes the name of the rule. |
| [`priority`](#parameter-customrulesrulespriority) | int | Describes priority of the rule. Rules with a lower value will be evaluated before rules with a higher value. |
| [`ruleType`](#parameter-customrulesrulesruletype) | string | Describes type of rule. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`rateLimitDurationInMinutes`](#parameter-customrulesrulesratelimitdurationinminutes) | int | Time window for resetting the rate limit count. Default is 1 minute. |
| [`rateLimitThreshold`](#parameter-customrulesrulesratelimitthreshold) | int | Number of allowed requests per client within the time window. |

### Parameter: `customRules.rules.action`

Describes what action to be applied when rule matches.

- Required: Yes
- Type: string
- Allowed:
  ```Bicep
  [
    'Allow'
    'Block'
    'Log'
    'Redirect'
  ]
  ```

### Parameter: `customRules.rules.enabledState`

Describes if the custom rule is in enabled or disabled state.

- Required: Yes
- Type: string
- Allowed:
  ```Bicep
  [
    'Disabled'
    'Enabled'
  ]
  ```

### Parameter: `customRules.rules.matchConditions`

List of match conditions. See https://learn.microsoft.com/en-us/azure/templates/microsoft.network/frontdoorwebapplicationfirewallpolicies#matchcondition for details.

- Required: Yes
- Type: array

### Parameter: `customRules.rules.name`

Describes the name of the rule.

- Required: Yes
- Type: string

### Parameter: `customRules.rules.priority`

Describes priority of the rule. Rules with a lower value will be evaluated before rules with a higher value.

- Required: Yes
- Type: int

### Parameter: `customRules.rules.ruleType`

Describes type of rule.

- Required: Yes
- Type: string
- Allowed:
  ```Bicep
  [
    'MatchRule'
    'RateLimitRule'
  ]
  ```

### Parameter: `customRules.rules.rateLimitDurationInMinutes`

Time window for resetting the rate limit count. Default is 1 minute.

- Required: No
- Type: int

### Parameter: `customRules.rules.rateLimitThreshold`

Number of allowed requests per client within the time window.

- Required: No
- Type: int

### Parameter: `enableTelemetry`

Enable/Disable usage telemetry for module.

- Required: No
- Type: bool
- Default: `True`

### Parameter: `location`

Location for all resources.

- Required: No
- Type: string
- Default: `'global'`

### Parameter: `lock`

The lock settings of the service.

- Required: No
- Type: object

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`kind`](#parameter-lockkind) | string | Specify the type of lock. |
| [`name`](#parameter-lockname) | string | Specify the name of lock. |

### Parameter: `lock.kind`

Specify the type of lock.

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'CanNotDelete'
    'None'
    'ReadOnly'
  ]
  ```

### Parameter: `lock.name`

Specify the name of lock.

- Required: No
- Type: string

### Parameter: `managedRules`

Describes the managedRules structure.

- Required: No
- Type: object
- Default:
  ```Bicep
  {
      managedRuleSets: [
        {
          exclusions: []
          ruleGroupOverrides: []
          ruleSetAction: 'Block'
          ruleSetType: 'Microsoft_DefaultRuleSet'
          ruleSetVersion: '2.1'
        }
        {
          exclusions: []
          ruleGroupOverrides: []
          ruleSetType: 'Microsoft_BotManagerRuleSet'
          ruleSetVersion: '1.0'
        }
      ]
  }
  ```

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`managedRuleSets`](#parameter-managedrulesmanagedrulesets) | array | List of rule sets. |

### Parameter: `managedRules.managedRuleSets`

List of rule sets.

- Required: No
- Type: array

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`ruleSetType`](#parameter-managedrulesmanagedrulesetsrulesettype) | string | Defines the rule set type to use. |
| [`ruleSetVersion`](#parameter-managedrulesmanagedrulesetsrulesetversion) | string | Defines the version of the rule set to use. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`exclusions`](#parameter-managedrulesmanagedrulesetsexclusions) | array | Describes the exclusions that are applied to all rules in the set. |
| [`ruleGroupOverrides`](#parameter-managedrulesmanagedrulesetsrulegroupoverrides) | array | Defines the rule group overrides to apply to the rule set. |
| [`ruleSetAction`](#parameter-managedrulesmanagedrulesetsrulesetaction) | string | Defines the rule set action. |

### Parameter: `managedRules.managedRuleSets.ruleSetType`

Defines the rule set type to use.

- Required: Yes
- Type: string

### Parameter: `managedRules.managedRuleSets.ruleSetVersion`

Defines the version of the rule set to use.

- Required: Yes
- Type: string

### Parameter: `managedRules.managedRuleSets.exclusions`

Describes the exclusions that are applied to all rules in the set.

- Required: No
- Type: array

### Parameter: `managedRules.managedRuleSets.ruleGroupOverrides`

Defines the rule group overrides to apply to the rule set.

- Required: No
- Type: array

### Parameter: `managedRules.managedRuleSets.ruleSetAction`

Defines the rule set action.

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'Block'
    'Log'
    'Redirect'
  ]
  ```

### Parameter: `policySettings`

The PolicySettings for policy.

- Required: No
- Type: object
- Default:
  ```Bicep
  {
      enabledState: 'Enabled'
      mode: 'Prevention'
  }
  ```

### Parameter: `roleAssignments`

Array of role assignments to create.

- Required: No
- Type: array
- Roles configurable by name:
  - `'Contributor'`
  - `'Owner'`
  - `'Reader'`
  - `'Role Based Access Control Administrator'`
  - `'User Access Administrator'`

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`principalId`](#parameter-roleassignmentsprincipalid) | string | The principal ID of the principal (user/group/identity) to assign the role to. |
| [`roleDefinitionIdOrName`](#parameter-roleassignmentsroledefinitionidorname) | string | The role to assign. You can provide either the display name of the role definition, the role definition GUID, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`condition`](#parameter-roleassignmentscondition) | string | The conditions on the role assignment. This limits the resources it can be assigned to. e.g.: @Resource[Microsoft.Storage/storageAccounts/blobServices/containers:ContainerName] StringEqualsIgnoreCase "foo_storage_container". |
| [`conditionVersion`](#parameter-roleassignmentsconditionversion) | string | Version of the condition. |
| [`delegatedManagedIdentityResourceId`](#parameter-roleassignmentsdelegatedmanagedidentityresourceid) | string | The Resource Id of the delegated managed identity resource. |
| [`description`](#parameter-roleassignmentsdescription) | string | The description of the role assignment. |
| [`name`](#parameter-roleassignmentsname) | string | The name (as GUID) of the role assignment. If not provided, a GUID will be generated. |
| [`principalType`](#parameter-roleassignmentsprincipaltype) | string | The principal type of the assigned principal ID. |

### Parameter: `roleAssignments.principalId`

The principal ID of the principal (user/group/identity) to assign the role to.

- Required: Yes
- Type: string

### Parameter: `roleAssignments.roleDefinitionIdOrName`

The role to assign. You can provide either the display name of the role definition, the role definition GUID, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'.

- Required: Yes
- Type: string

### Parameter: `roleAssignments.condition`

The conditions on the role assignment. This limits the resources it can be assigned to. e.g.: @Resource[Microsoft.Storage/storageAccounts/blobServices/containers:ContainerName] StringEqualsIgnoreCase "foo_storage_container".

- Required: No
- Type: string

### Parameter: `roleAssignments.conditionVersion`

Version of the condition.

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    '2.0'
  ]
  ```

### Parameter: `roleAssignments.delegatedManagedIdentityResourceId`

The Resource Id of the delegated managed identity resource.

- Required: No
- Type: string

### Parameter: `roleAssignments.description`

The description of the role assignment.

- Required: No
- Type: string

### Parameter: `roleAssignments.name`

The name (as GUID) of the role assignment. If not provided, a GUID will be generated.

- Required: No
- Type: string

### Parameter: `roleAssignments.principalType`

The principal type of the assigned principal ID.

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'Device'
    'ForeignGroup'
    'Group'
    'ServicePrincipal'
    'User'
  ]
  ```

### Parameter: `sku`

The pricing tier of the WAF profile.

- Required: No
- Type: string
- Default: `'Standard_AzureFrontDoor'`
- Allowed:
  ```Bicep
  [
    'Premium_AzureFrontDoor'
    'Standard_AzureFrontDoor'
  ]
  ```

### Parameter: `tags`

Resource tags.

- Required: No
- Type: object

## Outputs

| Output | Type | Description |
| :-- | :-- | :-- |
| `location` | string | The location the resource was deployed into. |
| `name` | string | The name of the Front Door WAF policy. |
| `resourceGroupName` | string | The resource group the Front Door WAF policy was deployed into. |
| `resourceId` | string | The resource ID of the Front Door WAF policy. |

## Cross-referenced modules

This section gives you an overview of all local-referenced module files (i.e., other modules that are referenced in this module) and all remote-referenced files (i.e., Bicep modules that are referenced from a Bicep Registry or Template Specs).

| Reference | Type |
| :-- | :-- |
| `br/public:avm/utl/types/avm-common-types:0.5.1` | Remote reference |

## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the [repository](https://aka.ms/avm/telemetry). There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
