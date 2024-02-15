require "json"

items = JSON.parse(File.read("items.json"))

def check_pair(item_1, item_2)
  url = "https://neal.fun/api/infinite-craft/pair?first=#{item_1}&second=#{item_2}"
  curl_command = "curl -s -H 'Referer: https://neal.fun/infinite-craft/' '#{url}'"
  response = `#{curl_command}`
  return false if response.include?("error code: 1015")
  begin
    item_info = JSON.parse response 
  rescue
    return false
  end
  return item_info
end

def print_item(item)
  "#{item[0]}"
end

begin
  items.each do |item|
    items.each do |item_1|
      result_1 = nil
      loop do
        result_1 = check_pair(item[0], item_1[0])
        break if result_1
        puts "Something went wrong, you are most likely being ratelimited. Trying again in 20 minutes..."
        1200.times do |x|
          print "\r#{x}/1200 seconds"
          sleep 1
        end
        puts
      end
      result = [result_1["result"], result_1["emoji"]]
      unless items.include?(result)
        items << result 
      end
      recipe = "#{print_item item} + #{print_item item_1} = #{print_item result}"
      puts recipe
      File.write("recipes.ignore", recipe, mode: ?a)
      if result_1["isNew"]
        puts "#{print_item result} is a new discovery!"
        File.write("discoveries.ignore", recipe, mode: ?a)
      end
      sleep(5) # no ratelimit
    end

    puts "Sleeping for 10 seconds to prevent ratelimit"
    sleep(10) # no ratelimit
  end
rescue Interrupt
  puts "Interrupted, continuing..."
end


