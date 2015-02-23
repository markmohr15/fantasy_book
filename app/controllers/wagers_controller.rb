class WagersController < ApplicationController
  layout "application"
  before_action :user_required

  def create_multiple
    if current_user.valid_password?(params[:password])
      params[:wager].each do |attr|
        unless attr["prop_id"] == ""
          prop = Prop.find_by id: attr["prop_id"]
          prop_choice1 = prop.prop_choices.first
          prop_choice = PropChoice.find_by id: attr["prop_choice_id"]
          if prop_choice1.id == prop_choice.id && (prop.variety == "Fantasy" || prop.variety == "2P Fantasy")
            prop_spread = prop.opt1_spread
          elsif prop.variety == "Fantasy" || prop.variety == "2P Fantasy"
            prop_spread = prop.opt2_spread
          end
          risk_dollars = attr[:risk_dollars]
          odds = attr[:odds].to_i
          spread = attr[:spread].to_f
          total = attr[:total].to_f
          if prop.state != "Open"
            redirect_to :back, alert: t("wager.closed") and return
          elsif prop_choice.odds != odds
            redirect_to :back, alert: t("wager.line_change") and return
          elsif prop.variety == "Over/Under" && prop.over_under != total
            redirect_to :back, alert: t("wager.line_change") and return
          elsif (prop.variety == "Fantasy" || prop.variety == "2P Fantasy") && prop_spread == spread
            redirect_to :back, alert: t("wager.line_change") and return
          else
            wager = Wager.new(attr.to_hash)
            wager.user_id = current_user.id
            wager.save
          end
        end
      end
      redirect_to :back, notice: t("wager.successful_wager")
    else
      redirect_to :back, alert: t("wager.invalid_password")
    end
  end

  private

  def wager_params
    params.require(:wager).permit(:prop_id, :prop_choice_id, :risk_dollars, :odds, :spread, :total)
  end

end
