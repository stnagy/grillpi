#!/usr/bin/env ruby

# script to output wireless access point information as json
# requires iwlist utility
# works on rpi 3 as of Sept. 30, 2016


# optionally input wireless interface adapter
def main(wlan = "wlan0")
  # create empty array for results
  return_array = []
  
  # use linux wifi utility to scan wifi access points
  wifi_output = `sudo iwlist #{wlan} scan`  
  wifi_output_array = wifi_output.split(/Cell \d\d/)
  
  wifi_output_array.each_with_index do |r, i|
    next if i == 0 # we don't care about first match, it has no info
    access_info = {} # initialize empty hash for information
    access_info[:ssid] = r.match(/ESSID:.+?\n/).to_s.strip
    access_info[:quality] = r.match(/Quality=\S+?\s/).to_s.strip
    access_info[:signal] = r.match(/Signal level=.+?\n/).to_s.strip
    access_info[:mac] = r.match(/Address: \S+?\n/).to_s.strip
    access_info[:channel] = r.match(/Channel:\d{1,2}/).to_s.strip
    access_info[:frequency] = r.match(/Frequency:\S+? GHz/).to_s.strip
    return_array << access_info
  end
  
  return return_array.inspect
end

# by default, puts the return value from main()
puts main()