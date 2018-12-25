FactoryBot.define do
  factory :publication do
    title { Faker::Name.name }
    type { 1 }
    information { Faker::Lorem.paragraph }
    remunaration { 500 }
    vacancies { 2 }
  end
end
