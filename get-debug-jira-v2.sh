#!/bin/bash

server="$1"
token="$(cat /tmp/api-token/apiToken)"
key="$2"
issuetype="$3"
podname="$5"
namespace="$4"
summary="Pod $podname restarting in $namespace namespace"
descriptiontext="Please find attached pod details for pod $podname in $namespace namespace"


python fetch-crashloopback-data.py $namespace $podname 

echo "=========================================================================="
echo "Below logs under  /tmp/${podname}_*" will be attached to the jira ticket. 
echo "=========================================================================="
echo 

ls -lrth /tmp/${podname}_*/*.txt

# echo "server: $server"
# echo "key: $key"
# echo "issuetype: $issuetype"
# echo "podname: $podname"
# echo "namespace: $namespace"
# echo "summary: $summary"
# echo "descriptiontext: $descriptiontext"
# echo "token: $token"

# echo "Printing the contents of the token volume"
# cat /tmp/api-token/apiToken

curl -s --location -X POST "${server}/rest/api/3/issue/" \
--header 'Content-Type: application/json' \
--header "Authorization: Basic $token" \
--data '{
    "fields": {
       "project":
       {
          "key": "'"$key"'"
       },
       "summary": "'"$summary"'",
       "description": {
          "type": "doc",
          "version": 1,
          "content": [
            {
              "type": "paragraph",
              "content": [
                {
                  "type": "text",
                  "text": "'"$descriptiontext"'"
                }
              ]
            }
          ]
        },
       "issuetype": {
          "name": "'"$issuetype"'"
       }
   }
}' > issuefile.txt

jq --version

jiraissueid=$(cat issuefile.txt | jq -r .id)

echo "jiraissueid: $jiraissueid"

for filename in $(ls -1 /tmp/${podname}_*/*.txt)
do

    curl  -s -i -X POST \
        -H "Authorization:Basic $token" \
        -H "X-Atlassian-Token: no-check" \
        -F "file=@$filename" \
        "$server/rest/api/3/issue/$jiraissueid/attachments"

done        
