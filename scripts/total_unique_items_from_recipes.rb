puts File.read("recipes.ignore").split("\n").map{|x| x.split(" = ")[1]}.uniq.length
