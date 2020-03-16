#!/bin/bash


while true; do
	default_dev=$(ip route get 8.8.8.8 | grep dev | cut -f5 -d" ")
	mac=$(ip link show $default_dev | grep link/ether | sed 's@^[^0-9]*\([0-9a-f:]*\).*$@\1@' | tr -d ':')
	pw=$(echo $mac|md5sum|cut -f1 -d" ")

	ngrok1 -subdomain=$mac -httpauth "$mac:$pw" -proto https -log=stdout 6080 || ngrok -subdomain=$mac -httpauth "$mac:$pw" -proto https -log=stdout 6080

	sleep 10
done

