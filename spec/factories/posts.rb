FactoryBot.define do
  factory :post do
    title { Faker::Lorem.name }
    body { Faker::Lorem.paragraph_by_chars([200, 247, 400].sample, false) }
    status { 1 }
    deleted { false }
    postable_type { "Collaborator" }
    postable_id { 1 }
  end
end
