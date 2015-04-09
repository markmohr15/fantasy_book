require 'twilio-ruby'

class TextController < ApplicationController
  include Webhookable

  skip_before_action :verify_authenticity_token

  def notify
    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    message = client.messages.create from: "+15406843040", to: "4023216410", body: "Learning to send SMS you are.", media_url: "http://linode.rabasa.com/yoda.gif"
    render plain: message.status
  end

end
