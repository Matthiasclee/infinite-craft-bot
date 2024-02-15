require "json"

def check_pair(item_1, item_2)
  url = "https://neal.fun/api/infinite-craft/pair?first=#{item_1}&second=#{item_2}"
  curl_command = "curl -H 'Referer: https://neal.fun/infinite-craft/' '#{url}'"
  item_info = JSON.parse `#{curl_command}`
  return item_info
end

puts check_pair("Water", "Earth").to_s
