require "json"

items = JSON.parse(File.read("items.json")).map do |x|
  {
    "text" => x[0],
    "emoji" => x[1],
    "discovered" => false
  }
end

infinite_craft_data = {
  "elements" => items
}

puts infinite_craft_data.to_json
