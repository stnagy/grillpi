#!/bin/sh
sudo sed -r '/network/ { N; /$1/ { N; N; s/network=.\n\s+ssid="$1"\n\s+psk.+\n.// }}' /etc/wpa_supplicant/wpa_supplicant.conf