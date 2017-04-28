require 'sinatra'
require 'sinatra/reloader'

@@secret_number = rand(100)
@@guess_count = 5
@@game_won = false

get '/' do
  guess = params['guess']
  message = check_guess(guess)
  if params['cheat']
    erb :index, :locals => {:number => @@secret_number, :message => message + "<br><p>The SECRET NUMBER is #{@@secret_number}</p>", :color => @@color}
  else
    erb :index, :locals => {:number => @@secret_number, :message => message, :color => @@color}
  end
end

def check_guess(guess)
  if guess.nil?
    @@color = 'white'
    message = ""
  else
    compare_guess(guess)
  end
end

def guess_counter(guess)
  @@guess_count -= 1
  if @@guess_count == 0
    restart_game
  end
end

def compare_guess(guess)
  guess = guess.to_i
  if guess > @@secret_number + 5
    guess_counter(guess)
    @@color = 'red'
    message = "Way too high!"
  elsif guess < @@secret_number - 5
    guess_counter(guess)
    @@color = 'red'
    message = "Way too low!"
  elsif guess < @@secret_number
    guess_counter(guess)
    @@color = '#FF9999'
    message = "Too low!"
  elsif guess > @@secret_number
    guess_counter(guess)
    @@color = '#FF9999'
    message = "Too high!"
  elsif guess == @@secret_number
    @@color = 'green'
    @@game_won = true
    restart_game
  end
end

def restart_game
  if @@game_won == true
    @@secret_number = rand(100)
    @@guess_count = 5
    message = "You got it! Let's play again with a new number!"
  else
    new_game
  end
end

def new_game
  @@game_won = false
  @@secret_number = rand(100)
  @@guess_count = 5
  message = "Not this time. Let's try again with a new number! A new number has been generated. Let's play!"
end
