# Exception Scope

There're two scenarios:
- You have a few resource groups hosting shared network infrastructure and you want to set a policy to govern business applications. You set the policy on subscription and exclude the network resource groups.
- You have a few apps that can't be compliant for sometime and the apps team want to apply an exception.

## Explain how it works by using Powershell

1. Go to http://aka.ms/getpolicy

2. Assign a policy using builtin Not Allowed resource type policy

3. select a RG as exceluded Scope

4. Verify the policy doesn't work on the excluded Scope

5. Verify the policy works elsewhere. 

