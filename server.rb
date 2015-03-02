require "sinatra"

WINNING_COMBO = [["rock", "scissors"], ["paper", "rock"], ["scissors", "paper"]]

use Rack::Session::Cookie, {
  secret: "keep_it_secret_keep_it_safe"
}

def computer_choice
  ["rock", "paper", "scissors"].sample
end

get '/' do
  redirect '/play'
end

get '/play' do
  session[:computer_score] ||= 0
  session[:player_score] ||= 0

  erb :play
end

get '/player/:choice' do
  player = params["choice"]
  computer = computer_choice

  if WINNING_COMBO.include?([player, computer])
    session[:player_score] += 1
    session[:result] = "Player won!"
  elsif player == computer
    session[:result] = "It's a tie!"
  else
    session[:computer_score] += 1
    session[:result] = "Computer won!"
  end

  redirect '/play'
end
