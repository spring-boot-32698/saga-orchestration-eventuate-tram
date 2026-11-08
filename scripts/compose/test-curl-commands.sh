#! /bin/bash -e

# Runs the curl commands shown on the application home page
# (end-to-end-tests/src/endToEndTest/resources/templates/index.html)
# against the API Gateway of the docker-compose stack.
#
#   scripts/compose/test-curl-commands.sh                 # uses localhost:8083
#   API_GATEWAY=localhost:18083 scripts/compose/test-curl-commands.sh

set -o pipefail

cd "$(dirname "$0")/../.."

API_GATEWAY=${API_GATEWAY:-localhost:8083}

FILE_PATH="end-to-end-tests/src/endToEndTest/resources/templates/index.html"

awk '
  /<pre><code>/ {flag=1; next}
  /<\/code><\/pre>/ {flag=0; if (full_cmd != "") {print full_cmd; full_cmd=""}}
  flag {full_cmd = (full_cmd ? full_cmd " " : "") $0}
' "$FILE_PATH" | sed -e "s/\[\[\${apiGatewayUrl}\]\]/$API_GATEWAY/" | while read -r cmd; do
    echo "Executing: $cmd"
    eval "$cmd"
    echo
done
