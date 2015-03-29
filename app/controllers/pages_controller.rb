class PagesController < ApplicationController
  layout "application"

  def contact
    PropMailer.test_email(current_user).deliver
  end

  def privacy
    render
  end

  def rules
    render
  end

  def terms
    render
  end

end
