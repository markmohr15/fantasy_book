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
    time "2015-04-01 10:00:00"
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

end
