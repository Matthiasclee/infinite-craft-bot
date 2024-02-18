require "json"

items = JSON.parse(File.read("items.json")).map{|i| i[0]}

index = items.index(ARGV[0])
puts items[index+1]
