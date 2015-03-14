ActiveAdmin.setup do |config|

  module ActiveAdmin #speeds up development
    module Reloader
      class Rails32Reloader
        def attach!
        end
      end
    end
  end

  def player_or_house
      [
        ["Player", 1],
        ["House", 3]
      ]
  end

  config.default_namespace = :admin
  config.current_user_method = :current_user
  config.logout_link_path = :destroy_user_session_path
  config.logout_link_method = :delete
  config.comments = false
  config.show_comments_in_menu = false
  config.batch_actions = true
  config.default_per_page = 50
  config.register_javascript "admin.js"

  config.namespace :admin do |ns|
    ns.authentication_method = :authenticate_active_admin_user!
    ns.site_title = "FantasyBook Admin"
    ns.site_title_link = "/admin"
    ns.root_to = 'users#index'

    ns.build_menu :utility_navigation do |menu|
      menu.add label: "View Site &rarr;".html_safe, url: "/"
      ns.add_logout_button_to_menu menu
    end
  end

  def authenticate_active_admin_user!
    redirect_to(root_path) unless (current_user.role == "admin" || current_user.role == "superadmin")
  end

  module ActiveAdmin::ViewHelpers
    include ApplicationHelper
  end

end
