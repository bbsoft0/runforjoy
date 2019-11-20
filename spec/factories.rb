FactoryGirl.define do
  factory :user do
    id {Faker::Number.number(3)}
    email {Faker::Internet.email}
    password "password"
    password_confirmation "password"
  end

  factory :segment, class: Segment do
    id {Faker::Number.number(3)}
    name {Faker::Name.name}
    dist {Faker::Number.decimal(2)}
    pr {Faker::Number.decimal(2)}
    goal {Faker::Name.name}
  end

  factory :stat, class: Stat do
    id {Faker::Number.number(3)}
    segment_id {Faker::Number.number(3)}
    place {Faker::Number.number(3)}
    name {Faker::Name.name}
    company {Faker::Name.name}
    time {Faker::Number.number(12).to_s}
    minkm {Faker::Number.number(12).to_s}
    kmh {Faker::Number.number(12).to_s}
    stars {Faker::Number.number(8)}
  end

end
