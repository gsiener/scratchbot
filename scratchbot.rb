require 'slack-ruby-bot'
require 'google_drive'
require './forecast.rb'

SlackRubyBot::Client.logger.level = Logger::WARN

class ScratchBot < SlackRubyBot::Bot
  command 'hi' do |client, data, match|
    client.say(text: 'meow', channel: data.channel)
  end

  command 'forecast' do |client, data, match|
    f = ForecastService.new.to_s
    client.say(text: f, channel: data.channel)
  end

end

class ForecastService
  
  def initialize
    @session ||= GoogleDrive::Session.from_config("config.json")
    @payload ||= @session.spreadsheet_by_url(
      "https://docs.google.com/spreadsheets/d/1wlMSFn0qxtwYjm7P4nMVSHh5fadhxLfo4gHVnkk9WUg/edit#gid=441509683"
    )
    @forecast ||= Forecast.new(@payload)
  end
  
  def to_s
    @forecast.to_s
  end
end