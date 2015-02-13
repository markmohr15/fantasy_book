class PropsController < ApplicationController
  layout "application"

  def index
    if params[:sport_id].present?
      @props = Prop.where(sport_id: params[:sport_id])
    else
      @props = Prop.all
    end
    @sports = Sport.all
  end

end
