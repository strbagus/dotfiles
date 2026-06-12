#!/bin/bash

loader() {
		echo "Connecting..."
		conn=false
		while [ !$conn ]; do
				status=$(warp-cli status | grep "Status update" | awk '{print $3}')
				if [ "$status" = "Connected" ]; then
						conn=true
						echo "Connected"
						break
				else
						sleep 1
				fi
		done	
}
# set visudo nopasswd for dnsmasq
status=$(warp-cli status | grep "Status update" | awk '{print $3}')
if [ "$status" = "Disconnected" ]; then
  	sudo systemctl stop dnsmasq
		warp-cli connect > /dev/null
		loader
else
    warp-cli disconnect > /dev/null
		sudo systemctl start dnsmasq
		echo "Disconnected"
fi
