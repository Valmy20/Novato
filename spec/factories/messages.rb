FactoryBot.define do
  factory :message do
    email { "MyString" }
    body { "MyText" }
    deleted { false }
  end
end
