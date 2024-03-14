
This repository consists of files that can be used for getting the logs of pods that are in crashloopback state. The `fetch-logs.py` script is used to fetch the logs of all the pods that are in crashloopback state. This script runs inside of a container deployed as part of the job. Before deploying the job.yaml ensure that the default serviceaccount in default namespace has permissions to fetch logs from all the pods in the cluster. The readpods-cr-crb.yaml creates the necessary RBAC needed for the serviceaccount.

### Usage: 

```
sagar@DESKTOP-VS85098:/tmp/get-troubleshooting-data$kubectl apply -f job.yaml

sagar@DESKTOP-VS85098:/tmp/get-troubleshooting-data$ kubectl get pods
NAME           READY   STATUS      RESTARTS   AGE
my-job-mljql   0/1     Completed   0          166m
sagar@DESKTOP-VS85098:/tmp/get-troubleshooting-data$ kubectl logs my-job-mljql
Logs for pod nginx-pod in namespace abc:
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: can not modify /etc/nginx/conf.d/default.conf (read-only file system?)
/docker-entrypoint.sh: Sourcing /docker-entrypoint.d/15-local-resolvers.envsh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2024/03/14 13:38:46 [emerg] 1#1: mkdir() "/var/cache/nginx/client_temp" failed (30: Read-only file system)
nginx: [emerg] mkdir() "/var/cache/nginx/client_temp" failed (30: Read-only file system)

```


