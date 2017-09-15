# Create a NSG policy for NIC

A common scenario for network is to enforce specific NSGs on all the network interfaces and subnets.This example shows you how to do this by Azure Policy. 

## Explain how it works by using Powershell

1. Explian new constraint Microsoft.Network/networkInterfaces/networkSecurityGroup.id can be used to enforce NSG on nic. 

2. Open the azurepolicy.rules.json file and view the policy

3. Run demo.ps1 to create policy and assignment. It also creates a NSG and use it in the assignment.

4. Go to the portal, create a network interface without using the NSG in West Central US where the NSG is created. Verify it will be blocked. This is ususally one of the steps in VM creation.

5. Go to the portal, create a network interface with the NSG. Verify it will be allowed.

