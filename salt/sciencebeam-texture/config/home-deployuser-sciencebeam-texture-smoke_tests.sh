#!/bin/bash
. /opt/smoke.sh/smoke.sh

echo "Healthchecks"
docker-wait-healthy sciencebeamtexture_texture_1

echo "Texture container"
smoke_url_ok localhost:4000/
echo "Sciencebeam container"
smoke_url_ok localhost:8075/api/
echo "GROBID container"
smoke_url_ok localhost:8070/
echo "Texture nginx"
smoke_url_ok localhost/
echo "Sciencebeam nginx"
smoke_url_ok localhost/api/
echo "GROBID nginx"
smoke_url_ok localhost/grobid/

smoke_report
