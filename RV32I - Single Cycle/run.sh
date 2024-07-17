#!/bin/bash

while getopts 'v:' flag; do
	case $flag in 
		v) test=$OPTARG;;
	esac
done

if [$test=="help"]; then
	echo "Hello World!"