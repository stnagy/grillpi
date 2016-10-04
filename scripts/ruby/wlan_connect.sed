#!/bin/sh
# use sed script because ruby is bad at substituting arguments
sudo sed -r '/^network/ { # look for lines starting with network
  N; # add the next line into the query 
  /'"$1"'/ # look for lines having the $1 argument (ssid passed from ruby) { 
    N; # add the next line 
    N; # add the next line 
    s/network=\{\n\s+ssid=.'"$1"'.\n\s+psk.+\n\}// # perform the find and replace
  }
}' /etc/wpa_supplicant/wpa_supplicant.conf