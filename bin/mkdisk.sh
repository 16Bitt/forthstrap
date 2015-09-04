#!/bin/sh

set -e

if [ -e raw_img.bin ]; then
	rm raw_img.bin
fi

for i in src/* ; do
	echo Loading $i into forth image
	dd if=$i of=raw_img.bin conv=sync,notrunc bs=512 oflag=append &> /dev/null
done
