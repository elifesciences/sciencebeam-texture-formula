#!/bin/bash
. /opt/smoke.sh/smoke.sh

echo "Texture container"
smoke_url_ok localhost:4000/
echo "Sciencebeam container"
smoke_url_ok localhost:8075/api/
echo "GROBID container"
smoke_url_ok localhost:8070/
echo "Texture nginx"
smoke_url_ok localhost/
echo "Sciencebeam nginx"
smoke_url_ok localhost/sciencebeam/api/
smoke_report
