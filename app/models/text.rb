class Text < ActiveRecord::Base

  def self.mass_sms mass_email, user
    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    message = client.messages.create from: "+15406843040", to: user.phone, body: mass_email.message
  end

  def self.contest_started wager
    text = wager.user.username + ", " + wager.prop.prop_choices.first.name + " Vs. " + wager.prop.prop_choices.last.name + " has begun.\nYour Selection: " + wager.prop_choice.name + "\nBuy-In: " + sprintf('%.2f', wager.risk_dollars).to_s + "\nWin: " + sprintf('%.2f', wager.win_dollars).to_s + "\nGood Luck,\nFantasyBook.guru"
    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    message = client.messages.create from: "+15406843040", to: wager.user.phone, body: text
  end

  def self.contest_graded wager
    text = wager.user.username + ", " + wager.prop.prop_choices.first.name + " Vs. " + wager.prop.prop_choices.last.name + " has completed.\nYour Selection: " + wager.prop_choice.name + "\nBuy-In: " + sprintf('%.2f', wager.risk_dollars).to_s + "\nWin: " + sprintf('%.2f', wager.win_dollars).to_s + "Result: " + sprintf('%.2f', wager.result).to_s + "\nThanks for Playing,\nFantasyBook.guru"
    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    message = client.messages.create from: "+15406843040", to: wager.user.phone, body: text
  end

  def self.transfer_request transfer
    text = transfer.sender.username + ", you have requested a transfer of " + sprintf('%.2f', transfer.amount_dollars).to_s + " to " + transfer.receiver.username + ".  We are currently reviewing your request and will let you know of the result as soon as possible.\nThank you,\nFantasyBook.guru"
    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    message = client.messages.create from: "+15406843040", to: transfer.sender.phone, body: text
  end

  def self.transfer_approved transfer
    text = transfer.sender.username + ", your transfer of " + sprintf('%.2f', transfer.amount_dollars).to_s + " to " + transfer.receiver.username + " was approved.\nThank you,\nFantasyBook.guru"
    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    message = client.messages.create from: "+15406843040", to: transfer.sender.phone, body: text
  end

  def self.transfer_sent transfer
    text = transfer.receiver.username + ", you just received a transfer of " + sprintf('%.2f', transfer.amount_dollars).to_s + " from " + transfer.sender.username + ".\nGood Luck,\nFantasyBook.guru"
    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    message = client.messages.create from: "+15406843040", to: transfer.receiver.phone, body: text
  end

  def self.transfer_rejected transfer
    text = "Sorry, " + transfer.sender.username + ", your transfer of " + sprintf('%.2f', transfer.amount_dollars).to_s + " to " + transfer.receiver.username + " was rejected.  If you need further information, please contact us at info@fantasybook.guru.\nThank you,\nFantasyBook.guru"
    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    message = client.messages.create from: "+15406843040", to: transfer.sender.phone, body: text
  end

  def self.withdrawal_request withdrawal
    text = withdrawal.user.username + ", you just requested a " + withdrawal.kind + " withdrawal in the amount of " + sprintf('%.2f', withdrawal.net_amount).to_s + ".  Your request will be processed in 24-48 business hours.\nThank you,\nFantasyBook.guru"
    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    message = client.messages.create from: "+15406843040", to: withdrawal.user.phone, body: text
  end

  def self.withdrawal_approved withdrawal
    text = withdrawal.user.username + ", your " + withdrawal.kind + " withdrawal request in the amount of " + sprintf('%.2f', withdrawal.net_amount).to_s + "was approved.\nThank you,\nFantasyBook.guru"
    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    message = client.messages.create from: "+15406843040", to: withdrawal.user.phone, body: text
  end

  def self.withdrawal_rejected withdrawal
    text = withdrawal.user.username + ", your " + withdrawal.kind + " withdrawal in the amount of " + sprintf('%.2f', withdrawal.net_amount).to_s + "was rejected.  If you need further information, please contact us at info@fantasybook.guru.\nThank you,\nFantasyBook.guru"
    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    message = client.messages.create from: "+15406843040", to: withdrawal.user.phone, body: mass_email.message
  end

end
