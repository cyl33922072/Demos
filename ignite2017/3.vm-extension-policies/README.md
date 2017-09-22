# Create a Policy that audits VM extension

AuditIfNotExist Effect allows policy to check related resources, including nested resources and other resources in the subscription. For example, VM extension is a nested resources under Virtual Machines. Therefore you can have a policy audit VM extensions when VM is created/updated. Similaly, you can audit network watcher existence when a virtual network is created. A similar effect for auto remediation is called "DeployIfNotExist", which will create related resources when it does not exist.

This example shows you how to audit anti-malware extension for VM.

## Explain how it works by using Powershell

1. Open the azurepolicy.rules.json file and view the policy

2. Explain the policy is triggered when the resource is a VM. A delayed evaluation will be triggered to look for VM extensions of a specific publisher and type. If it doesn't exist, an audit event will be generated.

2. Run demo.ps1 to create policy and assignment.

3. Go to the portal, create a Windows VM without extension and a VM with the required VM extension.

4. Wait for 10 minutes, and open activity logs and find the audit event. 

5. Since there is 10 mintues wait time, you should do this steps ahead and show user the activity logs for previous experiment. 



