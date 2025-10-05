#!/usr/bin/env bash

logfile="${HOME}/archmatic.log"

logprint() {
	printf "archmatic[$(basename "$0")]: %s\n" "$1"
	printf "$(date +"%Y-%m-%d %H:%M:%S") archmatic[$(basename "$0")]: %s\n" "$1" >> "$logfile"
}
