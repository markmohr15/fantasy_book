class MailgunMailer < ActionMailer::Base

  def test_email user
    @user = user
    mail to: @user.email, from: "postmaster@fantasybook.guru", subject: "Thank You."
  end

  def mass_email mass_email, user
    @user = user
    @mass_email = mass_email
    mail to: @user.email, from: "postmaster@fantasybook.guru", subject: @mass_email.subject
  end

  def contest_started wager
    @wager = wager
    mail to: @wager.user.email, from: "postmaster@fantasybook.guru", subject: "Contest Started"
  end

  def contest_graded wager
    @wager = wager
    mail to: @wager.user.email, from: "postmaster@fantasybook.guru", subject: "Contest Finished"
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

  def withdrawal_request withdrawal
    @withdrawal = withdrawal
    mail to: @withdrawal.user.email, from: "postmaster@fantasybook.guru", subject: "Withdrawal Request"
  end

  def withdrawal_approved withdrawal
    @withdrawal = withdrawal
    mail to: @withdrawal.user.email, from: "postmaster@fantasybook.guru", subject: "Withdrawal Approved"
  end

  def withdrawal_rejected withdrawal
    @withdrawal = withdrawal
    mail to: @withdrawal.user.email, from: "postmaster@fantasybook.guru", subject: "Withdrawal Rejected"
  end

  def deposit_made deposit
    @deposit = deposit
    mail to: @deposit.user.email, from: "postmaster@fantasybook.guru", subject: "Deposit Approved"
  end

end

