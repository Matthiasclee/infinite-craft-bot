require "json"

items_from_recipes =
  [
    [
      "Water",
      "💧"
    ],
    [
      "Fire",
      "🔥"
    ],
    [
      "Wind",
      "🌬️"
    ],
    [
      "Earth",
      "🌍"
    ]
  ] + 
  File.read("recipes.ignore").split("\n").map{|x| x.split(" = ")[1]}.uniq.map{|x| [x, ??]}
File.write("items.json", items_from_recipes.to_json)
