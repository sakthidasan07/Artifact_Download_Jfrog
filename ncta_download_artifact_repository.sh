#!/bin/bash
#Description: This script will connect to jfrog artifactory and download artifact to jenkins workspace and move it to different folder
#Input Parameter: ArtifactID
#Author: Sakthidasan Viswanathan
#Date: 10/28/2020
now=$(date)
url_part1="https://nctajenkinstestserver.jfrog.io/artifactory/example-repo-local/scripts/"
Url_part2=$ArtifactID
echo "--------------------------------------"
if [ ! -z "$ArtifactID" -a "$ArtifactID" != " " ]; then
final_url="${url_part1}${Url_part2}"
echo "$now: artifact id presented is, $ArtifactID"
echo "$now: finalurl is, $final_url"
echo "$now: connecting to repo"
curl_responsecode=$(curl -sSL -usviswanathan1@ncdot.gov:APB4xJGPNqKzsM7cDQc7oRziL8n -w '%{http_code}' -O "$final_url")
echo "$now: the curl command responsecode: $curl_responsecode"
else
echo "$now: invalide parameter value"
echo "$now: job failed"
echo "--------------------------------------"
exit 1
fi
if [ "${curl_responsecode}" != "200" ]; then
echo "$now: the curl command failed with: $curl_responsecode"
echo "requested resource could not be found."
exit 1
elif [ "${curl_responsecode}" == "200" ]; then
echo "$now: downloading from repo"
curl -Sf -usviswanathan1@ncdot.gov:APB4xJGPNqKzsM7cDQc7oRziL8n -O "$final_url"
echo "$now: download completed"
echo "$now: job completed"
echo "$now: moving file to destination folder"
sudo mv "/var/lib/jenkins/workspace/NCTA-PullArtifact-FromJfrog/script_sample_jenkinstest.sh" "/var/lib/jenkins/workspace/output_folder/"
echo "$now: move completed"
echo "--------------------------------------"
exit 0
fi