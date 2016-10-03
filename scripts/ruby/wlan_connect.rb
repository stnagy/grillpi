#!/usr/bin/env ruby

# script to connect to a different wifi hotspot
# requires iwconfig utility
# works on rpi 3 as of October 1, 2016

def wifi_connect(essid, key)

  # check wpa_supplicant file and save information for autoconnect
  wpa_supplicant = `sudo cat /etc/wpa_supplicant/wpa_supplicant.conf`
  wifi_configuration = "\n\nnetwork={\n  ssid=\"#{essid}\"\n  psk=\"#{key}\"\n}"
  
  if wpa_supplicant.match(essid)
    positions_lengths = wpa_supplicant.enum_for(:scan, /network=.+ssid=..#{essid}\W\W.+psk.+}/i).map { [ Regexp.last_match.begin(0), Regexp.last_match.to_s.length ] }
    puts positions_lengths
  
  else
    `sudo echo '#{wifi_configuration}' >> /etc/wpa_supplicant/wpa_supplicant.conf`
    `sudo ifdown wlan0`
    `sudo ifup wlan0` 
  end
  
  return true

end
