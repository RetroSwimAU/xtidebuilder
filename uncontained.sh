#!/bin/bash

check_dep() {

	echo -n "Check for '$1'..."
	if hash $1 2>/dev/null; then
		echo "OK"
	else
		echo "not found!"
		exit 1
	fi

}

check_dep make
check_dep nasm
check_dep upx
check_dep svn
check_dep perl
check_dep sed

mkdir -p src
rm -rf src/*

cd resources
./xtide_build.sh rel

