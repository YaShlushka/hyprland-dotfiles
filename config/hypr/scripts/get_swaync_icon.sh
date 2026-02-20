#!/bin/bash

if [ "$(swaync-client -D)" = "true" ]; then
	echo ""
else
	count=$(swaync-client -c)
	if [ "$count" -gt 0 ]; then
		echo ""
	else
		echo ""
	fi
fi
