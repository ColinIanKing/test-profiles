#!/bin/sh
rm -rf ffmpeg-7.0
tar -xf ffmpeg-7.0.tar.xz
cd ffmpeg-7.0
./configure --disable-zlib --disable-doc  > /dev/null
if [ $OS_TYPE = "BSD" ]
then
	gmake clean
else
	make clean
fi
