require 'sinatra'
num = rand(100)
get '/' do
  "The secret number is #{num}"
end
