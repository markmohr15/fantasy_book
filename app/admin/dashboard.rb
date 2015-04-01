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
    end
    controller do
        before_filter :superadmin_filter

        def superadmin_filter
            redirect_to admin_users_path unless current_user.role == "superadmin"
        end
    end

end

