# get-troubleshooting-data

This repository consists of files that can be used for getting the logs of pods that are in crashloopback state. The `fetch-logs.py` script is used to fetch the logs of all the pods that are in crashloopback state. This run inside of a container deployed as part of the job. Before deploying the job.yaml ensure that the default serviceaccount in default namespace has permissions to fetch logs from all the pods in the cluster. 
