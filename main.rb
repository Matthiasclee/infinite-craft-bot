require "json"

items = JSON.parse(File.read("items.json"))

def check_pair(item_1, item_2)
  url = "https://neal.fun/api/infinite-craft/pair?first=#{item_1}&second=#{item_2}"
  curl_command = "curl -s -H 'Referer: https://neal.fun/infinite-craft/' '#{url}'"
  response = `#{curl_command}`
  item_info = JSON.parse response 
  return item_info
end

def print_item(item)
  "#{item[0]}"
end

items.each do |item|
  items.each do |item_1|
    result = check_pair(item[0], item_1[0])
    result = [result["result"], result["emoji"]]
    unless items.include?(result)
      items << result 
    end
    puts "#{print_item item} + #{print_item item_1} = #{print_item result}"
    sleep(0.5) # no ratelimit
  end

  puts "Sleeping for 10 seconds to prevent ratelimit"
  sleep(10) # no ratelimit
end
