require "redis"
require "json"

$redis = ENV["QUIBBLE_REDIS"] ? Redis.new(url: ENV["QUIBBLE_REDIS"]) : Redis.new
