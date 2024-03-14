import requests

# Jira API endpoint for creating issues
url = "https://nirmata.atlassian.net/jira/servicedesk/projects/CS/queues/custom/54"

# Authentication headers
headers = {
    "Authorization": "ATATT3xFfGF0FEzz1fe3pUzI4paXepps1moBNaIioB_pz-PDSL2-VMj4jiHR3NFgijdgzc0o23jzln1fCViiaJvYbN3GTDNeARZwz_FreSFnBNca1ni2rR-veGcBmX2b7fZFajIiWy7k8B9lXL3MwbVg6z_q0bNvYo18Dx7IKRZhPvYTWVN3bOU=DD63D306",
    "Content-Type": "application/json"
}

# Issue payload
payload = {
    "fields": {
        "project": {"key": "CS"},
        "summary": "Testing",
        "description": "Testing",
        "issuetype": {"name": "Bug"}
    }
}

# Send POST request to create issue
response = requests.post(url, json=payload, headers=headers)

# Handle response
if response.status_code == 201:
    print("Issue created successfully!")
    print("Issue Key:", response.json()["key"])
else:
    print("Failed to create issue:", response.text)

