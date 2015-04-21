class RegistrationsController < Devise::RegistrationsController

  def new
    @sports = Sport.all
    super
  end

end
