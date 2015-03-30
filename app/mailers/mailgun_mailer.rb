class MailgunMailer < ActionMailer::Base

  def test_email user
    @user = user
    mail to: @user.email, from: "postmaster@fantasybook.guru", subject: "Thank You."
  end

  def transfer_request transfer
    @transfer = transfer
    mail to: @transfer.sender.email, from: "postmaster@fantasybook.guru", subject: "Transfer Requested"
  end

  def transfer_approved transfer
    @transfer = transfer
    mail to: @transfer.sender.email, from: "postmaster@fantasybook.guru", subject: "Transfer Approved"
  end

  def transfer_sent transfer
    @transfer = transfer
    mail to: @transfer.receiver.email, from: "postmaster@fantasybook.guru", subject: "Transfer Received"
  end

  def transfer_rejected transfer
    @transfer = transfer
    mail to: @transfer.sender.email, from: "postmaster@fantasybook.guru", subject: "Transfer Rejected"
  end

end




