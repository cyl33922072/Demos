Login-AzureRmAccount
Get-AzureRmSubscription

$definition = New-AzureRmPolicyDefinition -Name denyHybridUseBenefit -ManagementGroup "0c2218db-0895-47c1-be58-513ee036f674" -DisplayName "Deny hybrid use benefit" -Policy 'https://raw.githubusercontent.com/Azure/azure-policy-samples/master/samples/Compute/deny-hybrid-use-benefit/azurepolicy.rules.json'
$definition
$assignment = New-AzureRmPolicyAssignment -Name denyHybridUseBenefit -PolicyDefinition $definition -Scope "/providers/Microsoft.Management/managementGroups/0c2218db-0895-47c1-be58-513ee036f674"
$assignment

#go to portal to verify