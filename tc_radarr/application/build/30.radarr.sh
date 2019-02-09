#!/bin/bash
## application/build/30.sonarr.sh

# Copyright (C) 2015-* Phillip R. Jaenke <talecaster@rootwrym.com>
#
# NO COMMERCIAL REDISTRIBUTION IN ANY FORM IS PERMITTED WITHOUT
# EXPRESS WRITTEN CONSENT.

######################################################################
## Function Import and Setup
######################################################################

. /opt/talecaster/lib/deploy.lib.sh

buildname="radarr_install"

## Build
vbpkg=""
vbpkg_content=""
## Runtime
vrpkg="vp_NzbDrone"
vrpkg_content="nodejs libgcc"

## TODO: mono test
## TODO: libmediainfo and mediainfo tests

radarr_version="0.2.0.1293"

curl_cmd="/usr/bin/curl --tlsv1.2 --progress-bar -L"

echo "[BUILD] Installing prerequisites..."
# XXX: Work around weird apk bug..
/sbin/apk info > /dev/null
/sbin/apk update > /dev/null
/sbin/apk add --no-cache --virtual $vrpkg $vrpkg_content

echo "[BUILD] Retrieving Radarr..."
cd /opt/talecaster
$curl_cmd https://github.com/Radarr/Radarr/releases/download/v$radarr_version/Radarr.develop.$radarr_version.linux.tar.gz | tar xz
check_error $? radarr_retrieve

## Results in ./NzbDrone
if [ ! -d /opt/talecaster/Radarr ]; then
	echo "[BUILD] Radarr retrieval failed!"
	exit 1
fi
cd /opt/talecaster/Radarr

echo "[BUILD] Radarr installed."
exit 0
