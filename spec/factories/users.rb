FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { '123456' }
    password_confirmation { '123456' }
    uid { "1231231" }
    status { 1 }
    provider { "email" }
    credentials {
      {
      "token" => "xxxx",
      "refresh_token" => "xxxx",
      "expires_at" => 1403021232,
      "expires" => true
     }
    }
    deleted { false }
  end
end
