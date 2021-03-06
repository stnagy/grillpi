#!/usr/bin/env ruby

# script to connect to a different wifi hotspot
# requires iwconfig utility
# works on rpi 3 as of October 1, 2016

def wifi_connect(essid, key)

  # check wpa_supplicant file and save information for autoconnect
  wpa_supplicant = `sudo cat /etc/wpa_supplicant/wpa_supplicant.conf`
  wifi_configuration = "\nnetwork={\n  ssid=\"#{essid}\"\n  psk=\"#{key}\"\n}"
  
  if wpa_supplicant.match(essid)
    # if the wpa_supplicant file already has configuration information for this essid,
    # use sed script to remove old essid configuration from file
    # sed tutorial: http://www.grymoire.com/Unix/Sed.html
    `sudo /home/pi/grillpi/scripts/shell/wlan_connect.sed "#{essid}"`
    
    # clean up double newlines
    `sudo sed -r -i '/^\s*$/ { N; /^\s*$/ { D; D }}' /etc/wpa_supplicant/wpa_supplicant.conf` 
  end
  
  # add new configuration information into wpa_supplicant file
  `sudo echo '#{wifi_configuration}' >> /etc/wpa_supplicant/wpa_supplicant.conf`
  # clean up double newlines
  `sudo sed -r -i '/^\s*$/ { N; /^\s*$/ { D; D }}' /etc/wpa_supplicant/wpa_supplicant.conf` 
  `sudo sed -r -i '/^\s*$/ { N; /^\s*$/ { D; D }}' /etc/wpa_supplicant/wpa_supplicant.conf` 
  
  # cycle wireless interface to autoconnect
  `sudo ifdown wlan0`
  `sudo ifup wlan0` 
  
  return true

end
