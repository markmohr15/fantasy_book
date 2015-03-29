class PropMailer < ActionMailer::Base
  default from: "help@fantasybook.guru"

  def test_email user
    @user = user

    mail to: @user.email, from: "postmaster@mg.fantasybook.guru", subject: "Thank You."
  end


end



