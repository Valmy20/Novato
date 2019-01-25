FactoryBot.define do
  factory :user_extra do
    bio { Faker::Lorem.paragraph }
    user
  end
end
