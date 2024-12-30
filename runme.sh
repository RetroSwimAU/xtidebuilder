#!/bin/sh

echo "Create output directory, if not already here, empty it if it is"
mkdir -p src
rm -rf src/*

echo "Check for nonroot docker"
groups | grep -i docker
if [ $? -ne 0 ]; then
	echo "WARN: Couldn't see docker group membership. If the docker command fails with permission denied, try sudoing this script."
fi

docker build -t xtide_builder .

# This is an easy way of ensuring the resulting files are owned by the user running this script.

docker run -it --rm --user $(id -u):$(id -g) -v $(pwd)/src:/src xtide_builder

if [ $? -eq 0 ]; then
	mkdir -p bin
	rm -rf bin/*
	mkdir bin/rom
	mkdir bin/tool
	cp src/trunk/XTIDE_Universal_BIOS/Build/* bin/rom/
	cp src/trunk/XTIDE_Universal_BIOS_Configurator_v2/Build/* bin/tool/
	echo "Binaries copied to ./bin. Enjoy!"
fi
