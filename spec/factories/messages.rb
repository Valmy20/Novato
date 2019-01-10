FactoryBot.define do
  factory :message do
    email { Faker::Internet.email }
    body { Faker::Lorem.paragraph }
    deleted { false }
  end
end
