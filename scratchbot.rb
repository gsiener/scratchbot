require 'slack-ruby-bot'
require 'google_drive'
require './forecast.rb'
require 'dotenv/load'

SlackRubyBot::Client.logger.level = Logger::WARN

class ScratchBot < SlackRubyBot::Bot
  help do
    title 'Scratch'
    desc 'shares current field forecast'
    command 'forecast' do
      long_desc 'shows, in Millions, the field commit in PCF Annual Contract Value for the current quarter'
    end
  end

  command 'hi' do |client, data, match|
    client.say(text: 'meow', channel: data.channel)
  end

  command 'forecast' do |client, data, match|
    f = ForecastService.new.to_s
    client.say(text: f, channel: data.channel)
  end

  command 'top' do |client, data, match|
    f = ForecastService.new
    client.say(text: f.top, channel: data.channel)
  end

end

class ForecastService
  def initialize
    @session ||= GoogleDrive::Session.from_config("config.json")
    @payload ||= @session.spreadsheet_by_url(ENV['FORECAST_URL'])
    @forecast ||= Forecast.new(@payload)
  end

  def top
    @forecast.top_twenty
  end

  def to_s
    @forecast.to_s
  end
end
