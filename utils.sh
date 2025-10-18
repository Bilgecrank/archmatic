#!/usr/bin/env bash

logfile="${HOME}/archmatic.log"

logprint() {
	printf "archmatic[$(basename "$0")]: %s\n" "$1"
}
