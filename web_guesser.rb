require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(100)

get '/' do
  guess = params['guess'].to_i
  message = check_guess(guess)
  erb :index, :locals => {:number => SECRET_NUMBER, :message => message, :color => @@color}
end

def check_guess(guess)
  message = ""
  if guess > SECRET_NUMBER + 5 || guess < SECRET_NUMBER - 5
    @@color = 'red'
    message = "Too high!"
  elsif guess < SECRET_NUMBER
    @@color = '#FF9999'
    message = "Too low!"
  else
    @@color = 'green'
    message = "You got it!"
  end
end
