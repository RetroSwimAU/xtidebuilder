#!/bin/bash

makefile_fixer()
{
	echo "Linux-ifying makefile"
	sed -i 's;MAKE = mingw32-make.exe;MAKE = make;g' makefile
	sed -i 's;AS = nasm.exe;AS = nasm;g' makefile
	sed -i 's;RM = -del /Q;RM = -rm -rf;g' makefile
	sed -i 's;@$(RM) $(BUILD_DIR)\\*.*;@$(RM) $(BUILD_DIR)/*;g' makefile
	sed -i 's;\\;/;g' makefile
}

source options

if [ "$BUILD" == "" ]; then
	echo "WARN: Empty BUILD variable, is the options file missing, empty of malformed? Proceed with 'checksum' build"
	BUILD=checksum
fi

echo "Build target: $BUILD"

if [ "$BUILD" == "custom" ]; then
	echo "Parameters for custom build:"
	echo "Size: $CUSTOM_SIZE"
	echo "Defines: $CUSTOM_DEFINES"
fi

if [ "$1" == "rel" ]; then
	cd ../src
else
	cd /src
fi

echo "Checking out XTIDE from SVN"

svn co https://www.xtideuniversalbios.org/svn/xtideuniversalbios/trunk/

cd trunk/XTIDE_Universal_BIOS

makefile_fixer

if [ "$BUILD" == "custom" ]; then
	echo "Add custom build parameters:"
	sed -i "s/DEFINES_CUSTOM = ?/DEFINES_CUSTOM = $CUSTOM_DEFINES/g" makefile
	sed -i "s/BIOS_SIZE_CUSTOM = ?/BIOS_SIZE_CUSTOM = $CUSTOM_SIZE/g" makefile
fi

echo "Fix trailing whitespate on revision file"

sed -i 's/[ \t\0\r\n]*$//g' Inc/Revision.inc

make $BUILD

cd ..

cd XTIDE_Universal_BIOS_Configurator_v2

makefile_fixer

make release
