#!/bin/sh
# sudo sed -r '/network/ { N; /Hogwarts Great Hall Wifi/ { N; N; s/network=\{\n\s+ssid="Hogwarts Great Hall Wifi"\n\s+psk.+\n\}// }}' /etc/wpa_supplicant/wpa_supplicant.conf

echo $1
echo "/network/ { N; /$1/ { N; N; s/network=.\n\s+ssid=\"$1\"\n\s+psk.+\n.// }}"
sudo sed -r '/network/ { N; /$1/ { N; N; s/network=\{\n\s+ssid="$1"\n\s+psk.+\n\}// }}' /etc/wpa_supplicant/wpa_supplicant.conf