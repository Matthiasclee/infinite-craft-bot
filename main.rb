require "net/http"
require "uri"
require "json"

API_PAIR_URL = "https://neal.fun/api/infinite-craft/pair"

def check_pair(item_1, item_2)
  uri = URI.parse("#{API_PAIR_URL}?first=#{item_1}&second=#{item_2}")
end
