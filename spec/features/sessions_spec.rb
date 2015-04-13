require "rails_helper"

RSpec.feature "Sessions" do
  let(:admin) { create :admin, password: "test1234" }
  let(:superadmin) { create :superadmin, password: "test4321" }
  let(:user) { create :user, password: "test5678" }
  let(:prop) { create :prop_with_prop_choices }

  scenario "signing in with correct email/password for admin" do
    visit new_user_session_path

    fill_in "user_login", with: admin.email
    fill_in "user_password", with: "test1234"
    click_on "Log in"

    expect(current_path).to eq admin_users_path
  end

  scenario "signing in with correct email/password for superadmin" do
    visit new_user_session_path

    fill_in "user_login", with: superadmin.email
    fill_in "user_password", with: "test4321"
    click_on "Log in"

    expect(current_path).to eq admin_root_path
  end

  scenario "signing in with correct email/password for user" do
    visit new_user_session_path

    fill_in "user_login", with: user.email
    fill_in "user_password", with: "test5678"
    click_on "Log in"

    expect(current_path).to eq root_path
  end

  scenario "signing in with incorrect email for admin" do
    visit new_user_session_path

    fill_in "user_login", with: "admin@admin.com"
    fill_in "user_password", with: "test1234"
    click_on "Log in"

    expect(current_path).to eq new_user_session_path
  end

  scenario "signing in with incorrect email for superadmin" do
    visit new_user_session_path

    fill_in "user_login", with: "admin@admin.com"
    fill_in "user_password", with: "test4321"
    click_on "Log in"

    expect(current_path).to eq new_user_session_path
  end

  scenario "signing in with incorrect email for user" do
    visit new_user_session_path

    fill_in "user_login", with: "user@user.com"
    fill_in "user_password", with: "test5678"
    click_on "Log in"

    expect(current_path).to eq new_user_session_path
  end

  scenario "signing in with incorrect password for admin" do
    visit new_user_session_path

    fill_in "user_login", with: admin.email
    fill_in "user_password", with: "test5678"
    click_on "Log in"

    expect(current_path).to eq new_user_session_path
  end

  scenario "signing in with incorrect password for superadmin" do
    visit new_user_session_path

    fill_in "user_login", with: superadmin.email
    fill_in "user_password", with: "test1234"
    click_on "Log in"

    expect(current_path).to eq new_user_session_path
  end

  scenario "signing in with incorrect password for user" do
    visit new_user_session_path

    fill_in "user_login", with: user.email
    fill_in "user_password", with: "test1234"
    click_on "Log in"

    expect(current_path).to eq new_user_session_path
  end

end
