FactoryBot.define do
  factory :post do
    title { Faker::Lorem.name }
    body { Faker::Lorem.paragraph }
    status { 1 }
    deleted { false }
    postable_type { "Collaborator" }
    postable_id { 1 }
  end
end
