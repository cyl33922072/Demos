Lgoin-AzureRMAccount

#create policy that audits antimalware extention

$policyparameters = "https://raw.githubusercontent.com/cyl33922072/Demos/master/ignite2017/vm-extension-policies/audit-vm-extension/azurepolicy.parameters.json"
$policyrules = "https://raw.githubusercontent.com/cyl33922072/Demos/master/ignite2017/vm-extension-policies/audit-vm-extension/azurepolicy.rules.json"

$policy = New-AzureRmPolicyDefinition -Name audit-vm-extension -DisplayName "Audit required VM Extensions" -Policy $policyrules -Parameter $policyparameters

New-AzureRmPolicyAssignment -PolicyDefinition $policy -Scope "/subscriptions/a48a924d-6007-4c39-a3c0-5466b9012f42" -Name "audit-antimalware-extension" -DisplayName "Audit-Antimalware-Policy" -publisher "Microsoft.Azure.Security" -type "IaaSAntimalware" -Sku @{"Name"="A1";"Tier"="Standard"}

#create a VM with no extension from portal, wait for 10 minutes, you should see a audit event from activity log



