#!/usr/bin/env ruby

# script to output wireless access point information as json
# requires iwlist utility
# works on rpi 3 as of Sept. 30, 2016


# optionally input wireless interface adapter
def main(wlan = "wlan0")
  wifi_output = `sudo iwlist #{wlan} scan`
  
  wifi_output_array = wifi_output.split(/Cell \n\n/)
  return wifi_output_array.inspect
end

# by default, puts the return value from main()
puts main()