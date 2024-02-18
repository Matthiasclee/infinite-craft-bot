# Infinite Craft Bot
This program uses the [Infinite Craft](https://neal.fun/infinite-craft/) API to discover new items.
<br>
Using this, I was able to discover a lot of items and recipes, including 84 new discoveries, however, Cloudflare started
filtering my requests, so I had to shut it down. This repo contains the results of everything I found.

## Stats
* Total recipes checked: 113,765 *Additional recipes checked after the API started filtering requests have been omitted.*
* Total unique items found: 6,114
* Total new discoveries: 84

## Links
* New Discoveries \[84\] [\[TXT\]][1]
* All items \[6,114\] [\[JSON\]][2] [\[TXT\]][5] [\[JSON (for import)\]][4]
* All recipes \[113,765\] [\[TXT\]][3]

## To run it

To run the program, you need to create an `items.json` file. Either start fresh, and copy the below data into it, or copy everything from
`results/items.json`.
```json
[
  ["Water","💧"],
  ["Fire","🔥"],
  ["Wind","🌬️"],
  ["Earth","🌍"]
]
```

Then, run `ruby main.rb` to start. To start from a certain point instead of from the beginning, run `ruby main.rb "Item1" "Item2"`.
For example, `ruby main.rb "Whale" "Fish Farm"` starts where I left off.

<br>

Recipes will be saved to `recipes.ignore`, new discoveries to `discoveries.ignore`, and when you exit the program,
items will be written to `items.json`.

### Scripts
* `generate_storage_data.rb`: Converts `items.json` into a local storage compatible format to import items to the game
* `instructions_to_create_item.rb "<item>"`: Shows instructions to create `<item>` out of the four base elements
* `load_items_from_recipes.rb`: Covnerts `recipes.ignore` into `items.json`
* `next_item "<item>"`: Shows what item comes after `<item>`
* `total_unique_items_from_recipes.rb`: Uses `recipes.ignore` to count the total unique items


[1]: https://github.com/Matthiasclee/infinite-craft-bot/raw/master/results/discoveries.txt
[2]: https://github.com/Matthiasclee/infinite-craft-bot/raw/master/results/found_items.json
[3]: https://github.com/Matthiasclee/infinite-craft-bot/raw/master/results/recipes.txt
[4]: https://github.com/Matthiasclee/infinite-craft-bot/raw/master/results/storage_data.json
[5]: https://github.com/Matthiasclee/infinite-craft-bot/raw/master/results/unique_items.txt
