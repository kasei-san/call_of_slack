require 'aws-sdk'
require 'singleton'

class Polly
  include Singleton
  def speech(message)
    Tempfile.create("mp3") do |mp3|
      @client.synthesize_speech(
        response_target: mp3.path,
        output_format: 'mp3',
        text: message,
        voice_id: "Mizuki",
      )
      system "/usr/bin/afplay #{mp3.path}"
    end
  end

  def initialize
    @client ||= Aws::Polly::Client.new
  end
end

