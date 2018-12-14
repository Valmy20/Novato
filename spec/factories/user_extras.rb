FactoryBot.define do
  factory :user_extra do
    bio { Faker::Lorem.paragraph }
    skill { Faker::Lorem.paragraph }
    phone { "(74) 988437854" }
    user
  end
end
