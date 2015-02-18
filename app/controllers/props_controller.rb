class PropsController < ApplicationController
  layout "application"

  def index
    if params[:sport_id].present?
      @props = Prop.where(sport_id: params[:sport_id], state: 1)
    else
      @props = Prop.where(state: 1)
    end
    @sports = Sport.all
    @dates = []
    timeRange = Time.now.to_date..Time.now.to_date + 14.days
    timeRange.each do |x|
      @props.all.each do |y|
        if x === y.time.to_date
          @dates << x
        end
      end
    end
    @dates = @dates.uniq
    respond_to do |format|
        format.html
        format.js
    end

  end

  def pc
    respond_to do |format|
      format.json do
        prop_choice_id = params[:prop_choice_id]
        @prop_choice = PropChoice.find_by id: prop_choice_id
        render json: @prop_choice.to_json(:include => [:prop], :methods => [:display_line])
      end
    end
  end

end

