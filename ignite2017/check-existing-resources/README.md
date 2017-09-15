# Check Compliance Status

How do we get a comprehensive view of the compliance status of all the resources. Not only Policy can govern new resources, it can also genearte a compliance state for existing resources.

## Explain how it works by using Powershell

1. Prerequisite : register your subscripitons and get it approved with AzureGovernance team, since this is a private preview. Or choose Azure Governance INT subscription, which is a test subscription we have. 

2. Create some resources that violate the policy, such as a few storage accounts without tags. ( not needed for Azure Governance INT)

3. Assign new policies in previous demos ( not needed for Azure Governance INT)

4. Wait for a few minutes to a few hours. Go to http://aka.ms/getpolicy and check compliance view. Look at Initiatives that has Non-Compliant resources. For Azure Governance INT, choose Enable Monitoring in Azure Security Center, and find the blob encryption policy is uncompliant. Click it to drill into the uncompliant resources. Click view Resources and check for encryption settings. 

5. This demo should be prepared a few days before the demo day. 

