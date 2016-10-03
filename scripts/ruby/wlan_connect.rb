#!/usr/bin/env ruby

# script to connect to a different wifi hotspot
# requires iwconfig utility
# works on rpi 3 as of October 1, 2016

def wifi_connect(essid, key)

  # check wpa_supplicant file and save information for autoconnect
  wpa_supplicant = `sudo cat /etc/wpa_supplicant/wpa_supplicant.conf`
  wifi_configuration = "\n\nnetwork={\n  ssid=\"#{essid}\"\n  psk=\"#{key}\"\n}"
  
  if wpa_supplicant.match(essid)
    `sudo sed -i 's/network={\s+ssid="#{essid}"\s+psk.+\s}//g /etc/wpa_supplicant/wpa_supplicant.conf`
    `sudo cat /etc/wpa_supplicant/wpa_supplicant.conf`
  
  else
    `sudo echo '#{wifi_configuration}' >> /etc/wpa_supplicant/wpa_supplicant.conf`
    `sudo ifdown wlan0`
    `sudo ifup wlan0` 
  end
  
  return true

end
