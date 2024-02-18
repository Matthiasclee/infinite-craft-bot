RECIPES = File.read("recipes.ignore").split("\n").map{|l| l.split(" = ")}.to_h

item = ARGV[0].to_s

unless RECIPES.values.include?(item)
  STDERR.puts "Item \"#{item}\" not found."
  exit 1
end

def recipe_of(item)
  recipe = RECIPES.index(item)
  return recipe.split(" + ")
end

items_to_find = [item]

until items_to_find.length == 0
  items_to_find.each do |i|
    recipe = recipe_of(i)
    recipe.each do |x|
      items_to_find << x unless ["Earth", "Fire", "Wind", "Water"].include?(x)
    end
    items_to_find.delete_at(items_to_find.index i)

    puts "#{recipe[0]} + #{recipe[1]} = #{i}"
  end
end
