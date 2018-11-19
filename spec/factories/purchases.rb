FactoryBot.define do
  factory :purchase do
    date { '2018-11-15' }
    description { 'MyText' }
    amount { 1.5 }
    # payee { 'MyPayee' }
    user { FactoryBot.build(:user) }
    subcategory { FactoryBot.build(:subcategory) }
  end
end
