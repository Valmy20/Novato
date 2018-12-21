FactoryBot.define do
  factory :employer do
    name { Faker::Name.name }
    email { "employer@gmail.com" }
    password { "123456" }
    password_confirmation { "123456" }
    status { 1 }
    deleted { false }
  end
end
