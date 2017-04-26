require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(100)

get '/' do
  guess = params['guess'].to_i
  message = check_guess(guess)
  erb :index, :locals => {:number => SECRET_NUMBER, :message => message}
end

def check_guess(guess)
  message = ""
  if guess > SECRET_NUMBER
    message = "Too high!"
  elsif guess < SECRET_NUMBER
    message = "Too low!"
  else
    message = "You got it!"
  end
end
