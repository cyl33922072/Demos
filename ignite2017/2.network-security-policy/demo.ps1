Lgoin-AzureRMAccount

#create a NSG from portal, the scripts ensures every NIC is configured with NSG

$policyparameters = "https://raw.githubusercontent.com/cyl33922072/Demos/master/ignite2017/network-security-policy/policies/enforce-nsg-on-nic/azurepolicy.parameters.json"
$policyrules = "https://raw.githubusercontent.com/cyl33922072/Demos/master/ignite2017/network-security-policy/policies/enforce-nsg-on-nic/azurepolicy.rules.json"

$policy = New-AzureRmPolicyDefinition -Name Nsg-on-nic -DisplayName "Enforece Specific NSG on all NICs" -Policy $policyrules -Parameter $policyparameters

#create a NSG for nics
$resourceGroup = new-AzureRMResourceGroup -Name "NSGs" -Location "westcentralus" -Force
$nsg = New-AzureRmNetworkSecurityGroup -Name nic-nsg -ResourceGroupName "NSGs"-Location "westcentralus"
$nsg.Id

New-AzureRmPolicyAssignment -PolicyDefinition $policy -Scope "/subscriptions/a48a924d-6007-4c39-a3c0-5466b9012f42" -Name "nic-nsg" -DisplayName "Use nic-nsg on all NICs" -NSGId $nsg.Id -Sku @{"Name"="A1";"Tier"="Standard"}
