#!/bin/bash

time="1d"
root="S3/eictest/EPIC/RECO/"

# ~firehose
webhook="https://eic.cloud.mattermost.com/hooks/${HOOK_SECRET}"

text="`~/bin/mc find --newer-than $time $root | grep -v '/CI/' | grep -v '/TEST/' | sed 's|S3/eictest/EPIC/\(.*\)/[^/]*/[^/]*|\1|' | sort | uniq --count`"
if [ -n "$text" ] ; then
  data="{\"text\":\"Over the past $time, files have been added to S3 (number of files, location):\n\`\`\`$text\`\`\`\"}"
  curl -X POST -H 'Content-type: application/json' --data "$data" $webhook
fi
