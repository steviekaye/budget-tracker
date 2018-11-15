FactoryBot.define do
  factory :purchase do
    date { "2018-11-15" }
    description { "MyText" }
    amount { 1.5 }
    purchaser { nil }
    category { nil }
    Payee { "MyString" }
  end
end
