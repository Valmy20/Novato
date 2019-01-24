FactoryBot.define do
  factory :publication do
    title { Faker::Name.name }
    _type { 1 }
    information { Faker::Lorem.paragraph_by_chars([600, 850, 1050, 2470].sample, false) }
    remunaration { 500 }
    vacancies { 2 }
    publicationable_type {"Employer"}
    publicationable_id { Employer.last.id }
  end
end
