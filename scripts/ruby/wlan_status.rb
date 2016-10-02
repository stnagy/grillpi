#!/usr/bin/env ruby

# script to get current connection status of wifi
# requires iwconfig utility
# works on rpi 3 as of October 1, 2016

def wifi_status

  # initialize return hash
  return_hash = {}
  
  # run iwconfig utility
  wifi_status = `iwconfig`
  
  # check current wifi ssid
  return_hash[:current_ssid] = wifi_status.match(/ESSID:.+?\n/).to_s[6..-1].strip.gsub('"', '') # remove quotes
  
  # return false if no connection
  return false if return_hash[:current_ssid] == "off/any"
  
  # get remaining params
  return_hash[:frequency] = wifi_status.match(/Frequency:\S+? GHz/).to_s[10..-1].strip
  return_hash[:mac] = wifi_status.match(/Access Point: \S{2}(:\S{2}){5}/).to_s[12..-1].strip
  return_hash[:quality] = wifi_status.match(/Quality=\S+?\s/).to_s[8..-1].strip
  return_hash[:signal] = wifi_status.match(/Signal level=.+?\n/).to_s[13..-1].strip
  
  return return_hash
end

puts wifi_status()