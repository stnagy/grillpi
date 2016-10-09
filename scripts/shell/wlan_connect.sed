#!/bin/sh
# use sed script because ruby is bad at substituting arguments

# find lines in wpa_supplicant.conf that start with network
sudo sed -r -i '/^network/ { 
  # add the next line to originally found line
  N; 
  # check whether second line includes the $1 argument (ssid). if not, skip
  /'"$1"'/ { 
    # add the next two lines to the oringally found two lines (total four lines)
    N; N; 
    # perform the find and replace (delete) on all four lines
    s/network=\{\n\s+ssid=.'"$1"'.\n\s+psk.+\n\}// 
  }
}' /etc/wpa_supplicant/wpa_supplicant.conf