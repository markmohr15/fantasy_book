# == Schema Information
#
# Table name: mass_emails
#
#  id         :integer          not null, primary key
#  message    :text(65535)
#  subject    :string(255)
#  group      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  send_at    :datetime
#

class MassEmail < ActiveRecord::Base

  validates :message, presence: true
  validates :subject, presence: true
  validates :group, presence: true

  just_define_datetime_picker :send_at

  enum group: [ :Players_And_VIP, :Players, :VIP, :AllAdmins]

  after_initialize :set_time
  after_create :send_emails

  def set_time
    self.send_at ||= Time.now + 10.minutes
  end

  def send_emails
    if self.group == "Players_And_VIP"
      recipients = User.where("role = ? or role = ?", 1, 3)
    elsif self.group == "Players"
      recipients = User.where(role: 1)
    elsif self.group == "VIP"
      recipients = User.where(role: 3)
    elsif self.group == "AllAdmins"
      recipients = User.where("role = ? or role = ?", 0, 2)
    end
    recipients.each do |recipient|
      MailgunMailer.mass_email(self, recipient).deliver_later
    end
  end

  handle_asynchronously :send_emails, :run_at => Proc.new { |i| i.send_at }

end
