#!/bin/sh
# use sed script because ruby is bad at substituting arguments
sudo sed -r -i '/^network/ { 
  # find lines in wpa_supplicant.conf that start with network
  N; /'"$1"'/ { N; N; s/network=\{\n\s+ssid=.'"$1"'.\n\s+psk.+\n\}// }}' /etc/wpa_supplicant/wpa_supplicant.conf