FactoryBot.define do
  factory :post do
    title { Faker::Lorem.name }
    body { Faker::Lorem.paragraph_by_chars([1000, 1247, 4000].sample, false) }
    status { 1 }
    deleted { false }
    postable_type { "Collaborator" }
    postable_id { 1 }
  end
end
