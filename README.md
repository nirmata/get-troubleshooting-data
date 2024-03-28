Kyverno Policy Testing Repository
This repository houses essential resources for testing a Kyverno policy designed to initiate a job. This job gathers troubleshooting data (including logs, kubectl describe output, and events from the namespace) from pods that have restarted three times and subsequently creates a Jira ticket.

Usage
Building the Image
This process involves building a custom image containing a Python script for extracting pod details.

bash
Copy code
# Clone this repository
# Build the custom image with Docker
docker build -t sagarkundral/my-python-app:${tag} -f Dockerfile-new .

# Push the image to your repository
docker push sagarkundral/my-python-app:${tag}
RBAC Configuration
For the Kyverno generate policy to function correctly, it requires permissions to generate jobs, and the associated service accounts require permissions to retrieve describe outputs, events, and logs of pods across all namespaces. Deploy cr-generate.yaml and readpods-cr-crb.yaml for this purpose.

Deploying the Kyverno Policy
Customize the get-debug-data-policy to include appropriate details like the image, Jira server, project key, and issue type. Prior to deploying this policy, create a secret with your Jira API token, which will be mounted inside the pod as a volume for Jira server authentication.

bash
Copy code
kubectl -n abc create secret generic api-token-secret --from-literal=apiToken=xxxxxx
Testing
Deploy a sample deployment using depl-readonlyrootfs.yaml to simulate a crashing pod scenario. After three restarts, the Kyverno policy will trigger a job to collect troubleshooting data from the crashing pod and create a Jira ticket.

Enhancements
Implement a cleanup policy to remove all jobs created by this Kyverno policy at scheduled intervals.
Automatically scale down deployments to 0 replicas for deployments that have experienced more than five restarts.
