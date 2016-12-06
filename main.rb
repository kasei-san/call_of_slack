require 'aws-sdk'
require 'slack-ruby-client'
require 'pry-byebug'

polly = Aws::Polly::Client.new

Slack.configure do |config|
  config.token = ENV['SLACK_TOKEN']
end

client = Slack::Web::Client.new

client = Slack::RealTime::Client.new

client.on :hello do
  puts 'Successfully connected.'
end

client.on :message do |data|
  p "Got message : #{data['text']}"
  Tempfile.create("mp3") do |mp3|
    resp = polly.synthesize_speech(
      response_target: mp3.path,
      output_format: 'mp3',
      text: data['text'],
      voice_id: "Mizuki",
    )
    p mp3.path
    system "/usr/bin/afplay #{mp3.path}"
  end
end

client.start!
