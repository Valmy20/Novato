FactoryBot.define do
  factory :publication do
    title { Faker::Name.name }
    _type { 1 }
    information { Faker::Lorem.paragraph }
    remunaration { 500 }
    vacancies { 2 }
    publicationable_type {"Employer"}
    publicationable_id { Employer.last.id }
  end
end
