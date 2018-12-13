FactoryBot.define do
  factory :category do
    name { Faker::Space.planet }
    slug { Faker::Space.planet }
    status { true }
    deleted { false }
    admin
  end
end
