require 'slack-ruby-client'
require 'pry-byebug'

Dir[File.join(__dir__, 'lib/*.rb')].each(&method(:require))

Slack.configure do |config|
  config.token = ENV['SLACK_TOKEN']
end

client = Slack::RealTime::Client.new

client.on :hello do
  puts 'Successfully connected.'
end

client.on :message do |data|
  p "Got message : #{data['text']}"
  Polly.instance.speech(data['text'])
end

client.start!
