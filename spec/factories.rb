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


end
