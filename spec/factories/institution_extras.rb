FactoryBot.define do
  factory :institution_extra do
    about { "MyText" }
    phone { "MyString" }
    location { "MyString" }
    institution { nil }
  end
end
