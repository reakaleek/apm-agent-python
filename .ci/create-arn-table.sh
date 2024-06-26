#!/usr/bin/env bash
set -o pipefail

#
# Create the AWS ARN table given the below environment variables:
#
#  AWS_FOLDER - that's the location of the publish-layer-version output for each region

AWS_FOLDER=${AWS_FOLDER?:No aws folder provided}
ARN_FILE=".arn-file.md"

{
	echo "<details>"
	echo "<summary>Elastic APM Python agent layer ARNs</summary>"
	echo ''
	echo '|Region|ARN|'
	echo '|------|---|'
} > "${ARN_FILE}"

for f in $(ls "${AWS_FOLDER}"); do
	LAYER_VERSION_ARN=$(grep '"LayerVersionArn"' "$AWS_FOLDER/${f}" | cut -d":" -f2- | sed 's/ //g' | sed 's/"//g' | cut -d"," -f1)
	echo "INFO: create-arn-table ARN(${LAYER_VERSION_ARN}):region(${f})"
	echo "|${f}|${LAYER_VERSION_ARN}|" >> "${ARN_FILE}"
done

{
	echo ''
	echo '</details>'
	echo ''
} >> "${ARN_FILE}"
