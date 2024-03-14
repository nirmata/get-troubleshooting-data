from kubernetes import client, config

def get_crashloopbackoff_pods():
    config.load_incluster_config()
    api_instance = client.CoreV1Api()

    try:
        namespaces = api_instance.list_namespace().items
        crashloopbackoff_pods = []

        for namespace in namespaces:
            pods = api_instance.list_namespaced_pod(namespace.metadata.name).items
            for pod in pods:
                if pod.status.phase == "Running" and pod.status.container_statuses:
                    for container_status in pod.status.container_statuses:
                        if container_status.state and container_status.state.waiting and container_status.state.waiting.reason == "CrashLoopBackOff":
                            crashloopbackoff_pods.append((pod.metadata.namespace, pod.metadata.name))
                            break  # Exit inner loop once CrashLoopBackOff pod found
        return crashloopbackoff_pods
    except Exception as e:
        print(f"Error: {e}")

def fetch_logs_of_pods(pods):
    api_instance = client.CoreV1Api()
    try:
        for namespace, pod_name in pods:
            logs = api_instance.read_namespaced_pod_log(name=pod_name, namespace=namespace)
            print(f"Logs for pod {pod_name} in namespace {namespace}:\n{logs}\n")
    except Exception as e:
        print(f"Error fetching logs: {e}")

# Get CrashLoopBackOff pods across all namespaces
crashloopbackoff_pods = get_crashloopbackoff_pods()

# Fetch logs for each CrashLoopBackOff pod
fetch_logs_of_pods(crashloopbackoff_pods)

