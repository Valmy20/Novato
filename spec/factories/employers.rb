FactoryBot.define do
  factory :employer do
    name { "MyString" }
    email { "MyString" }
    password_digest { "MyString" }
    logo { "MyString" }
    token_reset { "MyString" }
    slug { "MyString" }
    status { 1 }
    deleted { false }
  end
end
