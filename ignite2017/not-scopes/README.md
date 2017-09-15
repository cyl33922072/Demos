# Exception Scope

There're two scenarios:
- You have a few resource groups hosting shared network infrastructure and you want to set a policy to govern business applications. You set the policy on subscription and exclude the network resource groups.
- You have a few apps that can't be compliant for sometime and the apps team want to apply an exception.

## Explain how it works by using Powershell

1. Go to http://aka.ms/getpolicy

2. Assign a policy using builtin Not Allowed resource type policy. Type Microsoft.Network/virtualNetworks as Not Allowed Resource Types. 

3. select a RG as exceluded Scope

4. Verify the policy blcoks vNet creation in a resource Group. 

5. Change the resource group to the excluded one and verify the vNet can be created. 

