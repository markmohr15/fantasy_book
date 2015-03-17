FactoryGirl.define do

  factory :player do
    sport
    name "Bo Jackson"
    team "Oakland Raiders"
    position "RB"
  end

  factory :prop_choice do
    prop
    choice "[1, 2]"
    odds "-110"
    available "50000"
  end

  factory :prop do
    sport
    time "2015-04-01 10:00:00"
    state "Open"
    proposition "Vs"
    opt1_spread "5"
    opt2_spread "-5"
    user
  end

  factory :sport do
    name "NFL"
  end

  factory :transfer do
    sender
    receiver
    amount "20000"
  end

  factory :user, aliases: [:sender, :receiver] do #player
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

  factory :house, class: User do
    sequence(:email) { |n| "house-#{n}@test.com" }
    password "test9012"
    sequence(:username) { |n| "house-#{n}" }
    address "456 Main St."
    phone "491-555-3322"
    city "Seattle"
    state "Washington"
    country "USA"
    zip "19840"
    role "house"
    name "Larry Bird"
    balance "100000"
  end

  factory :wager do
    prop
    user
    risk "11000"
    prop_choice
    odds "-110"
    spread "5"
  end

end
