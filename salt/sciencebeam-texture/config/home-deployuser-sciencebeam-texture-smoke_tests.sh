#!/bin/bash
#set -e # don't do this, this script handles exit code itself in `smoke_report`

. /opt/smoke.sh/smoke.sh

echo "Healthchecks"
docker-wait-healthy sciencebeam-texture_texture_1

echo "Texture container"
smoke_url_ok localhost:4000/
echo "Sciencebeam container"
smoke_url_ok localhost:8075/api/
echo "Texture nginx"
smoke_url_ok localhost/
echo "Sciencebeam nginx"
smoke_url_ok localhost/api/

smoke_report
