require 'sinatra'
require 'json'
require 'google_drive'
require './forecast.rb'

get '/' do
  content_type :json
  [200, {:status => 'OK'}.to_json]
end

# Route to show all Things, ordered like a blog
get '/forecast' do
  content_type :json
  current_forecast.to_json
#  "looks good".to_json
end


def current_forecast
  @session ||= GoogleDrive::Session.from_config("config.json")
  @payload ||= @session.spreadsheet_by_url(
      "https://docs.google.com/spreadsheets/d/1wlMSFn0qxtwYjm7P4nMVSHh5fadhxLfo4gHVnkk9WUg/edit#gid=441509683"
    )
  @forecast ||= Forecast.new(@payload)
end