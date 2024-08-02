#!/usr/bin/bash

GO_EXE=$(which go)
if [ $GO_EXE = "" ]; then
	echo "ERROR: No go binary installed on system"
	exit 1
fi

function check_version() {
	GO_VERSION_STRING=$(go version)
	SUB_VERSION_STRING=${GO_VERSION_STRING%\.*}
	SUB_VERSION_STRING=${SUB_VERSION_STRING:15}
	GO_VERSION_NUMBER=$((SUB_VERSION_STRING))

	if [ $GO_VERSION_NUMBER -lt 20 ]; then
		echo "ERROR: Found supported go version: 1.$GO_VERSION_NUMBER. Please upgrade to at least version 1.20"
	fi
	
	echo "STATUS: Found go version: 1.$GO_VERSION_NUMBER"
}

check_version

if [ ! -d "build" ]; then
	mkdir build
fi

SOURCES_LIST=$(find src -type f -iname "*.go")
PLATFORM=$(uname -i) # x86_64, x32, etc

$GO_EXE build -o build/$PLATFORM/bin/yugi_deck_router $SOURCES_LIST
