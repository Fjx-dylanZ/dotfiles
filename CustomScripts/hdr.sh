#!/bin/bash

if [ "$(betterdisplaycli get --name=32M2V --refreshrate)" = "144Hz" ]
then
	betterdisplaycli set --name=32M2V --refreshrate=60Hz
	sleep 4
	betterdisplaycli set --name=32M2V --hdr=on	
else
	betterdisplaycli set --name=32M2V --refreshrate=144Hz
fi
