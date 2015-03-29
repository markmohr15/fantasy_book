class PropMailer < ActionMailer::Base
  #default from: "help@fantasybook.guru"

  def test_email user
    @user = user
    RestClient.post "https://api:key-3ax6xnjp29jd6fds4gc373sgvjxteol0"\
  "@api.mailgun.net/v3/samples.mailgun.org/messages",
  :from => "Excited User <excited@samples.mailgun.org>",
  :to => "devs@mailgun.net",
  :subject => "Hello",
  :text => "Testing some Mailgun awesomeness!"
    #mail to: @user.email, subject: "Thank You."
  end


end



