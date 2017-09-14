#create a policy set for two billing tags
Login-AzureRmAccount
$policydefinitions = "https://raw.githubusercontent.com/cyl33922072/Demos/master/ignite2017/create-a-policy-set/PolicySet/multiple-billing-tags/azurepolicyset.definitions.json"
$policysetparameters = "https://raw.githubusercontent.com/cyl33922072/Demos/master/ignite2017/create-a-policy-set/PolicySet/multiple-billing-tags/azurepolicyset.parameters.json"

$policyset= New-AzureRmPolicySetDefinition -Name BillingTags -PolicyDefinition $policydefinitions -Parameter $policysetparameters -Description "Specify cost Center tag and product name tag" -DisplayName "Billing Tags Policy"
 
New-AzureRmPolicyAssignment -PolicySetDefinition $policyset -DisplayName "Ensure All Billing Tags" -Name "all-billing-tags" -costCenterValue "00001" -productNameValue "contoso.com" -Scope "/subscriptions/a48a924d-6007-4c39-a3c0-5466b9012f42"  -Sku @{"Name"="A1";"Tier"="Standard"}
