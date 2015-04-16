require "rails_helper"

RSpec.feature "Navigation" do
  let(:user) { create :user, affiliate: true }

  scenario "clicking Fantasy Contests takes you to the correct page" do
    visit root_path

    click_on "Fantasy Contests"

    expect(current_path).to eq root_path
  end

  scenario "clicking Deposit will take you to the correct page" do
    visit new_user_session_path

    fill_in "user_login", with: user.email
    fill_in "user_password", with: user.password
    click_on "Log in"
    click_on "Deposit"

    expect(current_path).to eq my_account_deposit_path
  end

  scenario "My Fantasy links will all take you to the correct page" do
    visit new_user_session_path

    fill_in "user_login", with: user.email
    fill_in "user_password", with: user.password
    click_on "Log in"
    click_on "My Fantasy"

    expect(current_path).to eq my_fantasy_my_action_path

    click_on "My History"

    expect(current_path).to eq my_fantasy_my_history_path

    within(".nav-tabs") do
      click_on "My Action"
    end

    expect(current_path).to eq my_fantasy_my_action_path
  end

  scenario "My Account links will all take you to the correct page" do
    visit new_user_session_path

    fill_in "user_login", with: user.email
    fill_in "user_password", with: user.password
    click_on "Log in"
    click_on "My Account"

    expect(current_path).to eq edit_user_registration_path

    within(".nav-tabs") do
      click_on "Deposit"
    end

    expect(current_path).to eq my_account_deposit_path

    within(".nav-tabs") do
      click_on "Withdraw"
    end

    expect(current_path).to eq my_account_withdraw_path

    click_on "Account Details"

    expect(current_path).to eq edit_user_registration_path

    click_on "Transfer"

    expect(current_path).to eq my_account_transfer_path

    click_on "Bonuses"

    expect(current_path).to eq my_account_bonuses_path

    click_on "Balance"

    expect(current_path).to eq my_account_balance_path

    click_on "Affiliate"

    expect(current_path).to eq my_account_affiliate_path
  end

end
