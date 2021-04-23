require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/multi_route'
require 'dotenv'
require 'net/http'
require 'json'
Dotenv.load
PERSONAL_ACCESS_TOKEN = ENV['HARVEST_ACCESS_TOKEN']
ACCOUNT_ID = ENV['HARVEST_ACCOUNT_ID']

get '/', '/home' do
  @api_response = api_request
  erb :home, :locals => { :api_response => @api_response }
end

# This page gets rendered when the user enters an unidentified route
not_found do
  erb :not_found, :layout => :error_layout
end

# methods
def api_request
  uri = URI('https://api.harvestapp.com/v2/users/me')

  Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
  request = Net::HTTP::Get.new uri
  request['User-Agent'] = 'Ruby Harvest API Sample'
  request['Authorization'] = "Bearer #{PERSONAL_ACCESS_TOKEN}"
  request['Harvest-Account-ID'] = ACCOUNT_ID
  puts request

  response = http.request request
  json_response = JSON.parse(response.body)

  puts JSON.pretty_generate(json_response)
  return json_response
end
end

def all_headers(response)
  header_list = {}
  response.header.each_capitalized do |k,v|
    header_list[k] =v unless k == "Transfer-Encoding"
  end
  header_list
end

def incoming_headers(request)
  request.env.map { |header, value|  [header[5..-1].split("_").map(&:capitalize).join('-'), value] if header.start_with?("HTTP_") }.compact.to_h
end
