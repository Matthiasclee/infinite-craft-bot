require "json"

items = JSON.parse(File.read("items.json"))
items_no_icons = items.map{|x| x[0]}
recipes = File.read("recipes.ignore")

def check_pair(item_1, item_2)
  url = "https://neal.fun/api/infinite-craft/pair?first=#{item_1}&second=#{item_2}"
  curl_command = "curl -s -H 'Referer: https://neal.fun/infinite-craft/' '#{url}'"
  response = `#{curl_command}`
  return false if response.include?("error code: 1015")
  begin
    item_info = JSON.parse response 
  rescue JSON::ParserError
    return {"result" => "Nothing", "emoji" => ??, "isNew" => false}
  rescue => e
    return false
  end
  return item_info
end

def print_item(item)
  "#{item[0]}"
end

begin
  items.each_with_index do |item, i|
    items.each_with_index do |item_1, i_1|
      # Skip to pick up somewhere
      result_1 = nil
      loop do
        result_1 = check_pair(item[0], item_1[0])
        break if result_1
        STDOUT.puts "Something went wrong, you are most likely being ratelimited. Trying again in 20 minutes..."
        1200.times do |x|
          print "\r#{x}/1200 seconds"
          begin
          sleep 1
          rescue Interrupt
            STDOUT.puts "Interrupted, continuing..."
          end
            
        end
        STDOUT.puts
      end
      result = [result_1["result"], result_1["emoji"]]
      unless items.include?(result)
        items << result 
      end
      recipe = "#{print_item item} + #{print_item item_1} = #{print_item result}"
      STDOUT.puts recipe
      File.write("recipes.ignore", recipe + "\n", mode: ?a)
      if result_1["isNew"]
        STDOUT.puts "#{print_item result} is a new discovery!"
        File.write("discoveries.ignore", recipe, mode: ?a)
      end
      begin
        sleep(5) # no ratelimit
      rescue Interrupt
        STDOUT.puts "Interrupted, continuing..."
      end
    end
  end
rescue
  STDOUT.puts "Interrupted, continuing..."
end

File.write("items.json", items.to_json)
