#!/bin/bash
. /opt/smoke.sh/smoke.sh

smoke_url_ok localhost/
#smoke_url_ok localhost/sciencebeam
smoke_report
