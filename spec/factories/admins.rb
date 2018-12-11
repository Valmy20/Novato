FactoryBot.define do
  factory :admin do
    name { Faker::Lorem.name }
    email { Faker::Internet.email }
    password { "123456" }
    password_confirmation { "123456" }
    status { true }
    deleted { false }
  end
end
