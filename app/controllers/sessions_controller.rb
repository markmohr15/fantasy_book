class SessionsController < Devise::SessionsController

  def new
    @sports = Sport.all
    super
  end

end
