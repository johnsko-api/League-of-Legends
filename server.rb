require 'pry'
require 'dotenv'
require 'sinatra'
require 'net/http'
require 'json'
require './youtube.rb'

Dotenv.load

api_key = ENV["LEAGUE_API_KEY"]
lol_api_response = URI("https://na.api.pvp.net/api/lol/static-data/na/v1.2/champion?champData=all&api_key=#{api_key}
")

response = Net::HTTP.get(lol_api_response)
champ_data = JSON.parse(response)
champions = champ_data["data"]
###########################
###Reorganize Data#########
clean_data = Array.new
champions.each do |key, value|
  clean_data << value
end
##########################
##########################

get '/' do
erb :index
end

get '/champions/:id' do
  champ_id = params[:id].to_i
  @champ_info = clean_data.find {|f| f["id"] == champ_id}
  @url = get_url(@champ_info["name"])
  erb :champ_info
end

get '/champions' do
@champions = clean_data
erb :champ_list
end


get '/champions/:role' do
  @champions = clean_data
  @role = params[:role]
  erb :categories
end
