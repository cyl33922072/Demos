Lgoin-AzureRMAccount
 Select-AzureRmSubscription -SubscriptionId  5d2e9369-0db7-49ce-a0b8-5e50769c141f
#create policy that audits antimalware extention

$definition = New-AzureRmPolicyDefinition -Name auditVmExtensions -DisplayName "Audit VM extensions" -Policy 'https://raw.githubusercontent.com/Azure/azure-policy-samples/master/samples/Compute/audit-vm-extension/azurepolicy.rules.json' -Parameter 'https://raw.githubusercontent.com/Azure/azure-policy-samples/master/samples/Compute/audit-vm-extension/azurepolicy.parameters.json'

New-AzureRmPolicyAssignment -PolicyDefinition $definition -Scope "/subscriptions/5d2e9369-0db7-49ce-a0b8-5e50769c141f/resourceGroups/auditifnotexist" -Name "audit-antimalware-extension" -DisplayName "Audit-Antimalware-Policy" -publisher "Microsoft.Azure.Security" -type "IaaSAntimalware" -Sku @{"Name"="A1";"Tier"="Standard"}

#create a VM with no extension from portal, wait for 10 minutes, you should see a audit event from activity log



