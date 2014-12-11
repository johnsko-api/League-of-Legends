require 'dotenv'
require 'sinatra'
require 'net/http'
require 'json'
require './youtube.rb'

Dotenv.load

api_key = ENV["LEAGUE_API_KEY"]
lol_api_response = URI("https://na.api.pvp.net/api/lol/static-data/na/v1.2/champion?champData=lore&api_key=#{api_key}")
response = Net::HTTP.get(lol_api_response)
champ_list = JSON.parse(response)

get '/' do
erb :index
end

get '/champions' do
@champions = champ_list["data"]
erb :champ_list
end

get '/champions/:name' do
@champ_info = champ_list["data"]
@champ_name = params[:name]
@url = get_url(@champ_name)
  erb :champ_info
end
