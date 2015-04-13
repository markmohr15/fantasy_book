FactoryGirl.define do

  factory :player do
    sport
    name "Bo Jackson"
    team "Oakland Raiders"
    position "RB"

    factory :player2 do
      sport
      name "Michael Jordan"
      team "Chicago Bulls"
      position "SG"
    end
  end

  factory :prop_choice do
    prop
    choice [1, 2]
    odds "-110"
    available "50000"
  end

  factory :prop do
    sport
    time Time.now + 2.days
    state "Open"
    proposition "Vs."
    opt1_spread "5"
    association :user, factory: :vip

    factory :prop_with_prop_choices do
      transient do
        prop_choices_count 2
      end

      after(:create) do |prop, evaluator|
        create_list(:prop_choice, evaluator.prop_choices_count, prop: prop)
      end
    end
  end

  factory :sport do
    name "NFL"
  end

  factory :transfer do
    sender
    receiver
    amount "20000"
  end

  factory :user, aliases: [:sender, :receiver] do
    sequence(:email) { |n| "player-#{n}@test.com" }
    password "test1234"
    sequence(:username) { |n| "player-#{n}" }
    address "345 Willowdale St."
    phone "456-432-1234"
    city "Springfield"
    state "Missouri"
    country "USA"
    zip "65810"
    role "player"
    name "Bart Simpson"
    balance "100000"
  end

  factory :admin, class: User do
    sequence(:email) { |n| "admin-#{n}@fb.com" }
    password "test5678"
    name "Adam Admin"
    role "admin"
  end

  factory :superadmin, class: User do
    sequence(:email) { |n| "superadmin-#{n}@fb.com" }
    password "test3421"
    name "Super Dave Admin"
    role "superadmin"
  end

  factory :vip, class: User do
    sequence(:email) { |n| "vip-#{n}@test.com" }
    password "test9012"
    sequence(:username) { |n| "vip-#{n}" }
    address "456 Main St."
    phone "491-555-3322"
    city "Seattle"
    state "Washington"
    country "USA"
    zip "19840"
    role "vip"
    name "Larry Bird"
    balance "100000"
  end

  factory :affiliate, class: User do
    sequence(:email) { |n| "ap-#{n}@test.com" }
    password "test5544"
    sequence(:username) { |n| "ap-#{n}" }
    address "1121 Dodge St."
    phone "456-777-3300"
    city "Chicago"
    state "Illinois"
    country "USA"
    zip "65740"
    role "player"
    name "Jack Rabbit"
    balance "100000"
    affiliate "true"
  end

  factory :affiliate_payment do
    affiliate
    user
    amount "20000"
  end

  factory :bonus do
    bonus_code
    user
    amount 30000
  end

  factory :bonus_code do
    code "RELOAD25"
    percentage 25
    rollover 20
    maximum 20000
    length 90
  end

  factory :credit do
    user
    admin
    amount 4000
  end

  factory :deposit do
    user
    bonus_code "RELOAD25"
    amount 50000
  end

  factory :withdrawal do
    user
    amount 60000
    kind "ACH"
  end

  factory :mass_email do
    message "rspec testing is fun"
    subject "test"
    group 1
    send_at (Time.now + 1.hour).change(min: 0)

    factory :mass_email_with_users do
      transient do
        users_count 2
      end

      after(:create) do |mass_email, evaluator|
        create_list(:mass_email, evaluator.users_count, mass_email: mass_email)
      end
    end
  end


end
