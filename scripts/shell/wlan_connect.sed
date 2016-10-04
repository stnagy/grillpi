#!/bin/sh
# use sed script because ruby is bad at substituting arguments

# find lines in wpa_supplicant.conf that start with network
sudo sed -r -i '/^network/ { 
  # add the next line
  N; 
  # find lines that include the $1 argument (ssid)
  /'"$1"'/ { 
    # add the next two lines
    N; N; 
    # perform the find and replace (delete)
    s/network=\{\n\s+ssid=.'"$1"'.\n\s+psk.+\n\}// 
  }
}' /etc/wpa_supplicant/wpa_supplicant.conf