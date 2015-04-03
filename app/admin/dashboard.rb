ActiveAdmin.register_page "Dashboard" do
  menu if: proc{ current_user.superadmin? }, priority: 1

  content do
    columns do
      column do
        panel "Results (VIP Accts)" do
          table do
            thead do
              tr do
                th do
                  "Pending"
                end
                th do
                 "Today"
                end
                th do
                  "Last 7 Days"
                end
                th do
                  "This Month"
                end
                th do
                  "This Year"
                end
                th do
                  "Overall"
                end
              end
            end
            tr do
              td do
                number_to_currency Wager.pending_vip_wagers
              end
              td do
                number_to_currency Wager.vip_results Time.now.to_date, Time.now
              end
              td do
                number_to_currency Wager.vip_results Time.now.to_date - 7.days, Time.now
              end
              td do
                number_to_currency Wager.vip_results Time.now.to_date.beginning_of_month, Time.now
              end
              td do
                number_to_currency Wager.vip_results Time.now.to_date.beginning_of_year, Time.now
              end
              td do
                number_to_currency Wager.vip_results "2015-01-01 00:00:00", Time.now
              end
            end
          end
        end
      end
    end

    columns do
      column do
        panel "Action Items" do
          table do
            tr do
              td do
                "Ungraded Contests:"
              end
              td do
                link_to(Prop.where(state:2).count, admin_gradings_path)
              end
            end
            tr do
              td do
                "Pending Withdrawals:"
              end
              td do
                link_to(Withdrawal.where(state:0).count, admin_withdrawals_path)
              end
            end
            tr do
              td do
                "Pending Transfers:"
              end
              td do
                link_to(Transfer.where(state:0).count, admin_transfers_path)
              end
            end
            tr do
              td do
                "Pending Affiliate Payments:"
              end
              td do
                link_to(AffiliatePayment.where(state:0).count, admin_affiliate_payments_path)
              end
            end
          end
        end
      end
      column do
        panel "Stats" do
          table do
            tr do
              td do
                "Player Account Balances:"
              end
              td do
                number_to_currency User.total_player_balances
              end
            end
            tr do
              td do
                "Pending Bonuses:"
              end
              td do
                number_to_currency Bonus.total_pending_bonuses
              end
            end
          end
        end
      end
    end
  end

  controller do
    before_filter :superadmin_filter

    def superadmin_filter
      redirect_to admin_users_path unless current_user.role == "superadmin"
    end
  end

end
