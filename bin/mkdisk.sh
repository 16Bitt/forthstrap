#!/bin/sh

echo > raw_img.bin

for i in src/*; do
	echo Loading $i into forth image
	dd if=$i of=raw_img.bin conv=sync,notrunc bs=512
done
