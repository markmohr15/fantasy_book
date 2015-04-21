class PasswordsController < Devise::PasswordsController

  def new
    @sports = Sport.all
    super
  end

end
