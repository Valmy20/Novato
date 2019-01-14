FactoryBot.define do
  factory :collaborator do
    name { Faker::Lorem.name }
    email { Faker::Internet.email }
    password { "123456" }
    password_confirmation { "123456" }
    status { 1 }
    deleted { false }
  end
end
