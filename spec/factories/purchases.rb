FactoryBot.define do
  factory :purchase do
    date { '2018-11-15' }
    description { 'Avocado' }
    amount { 4.5 }
    payee { 'Evil Dairy' }
    purchaser { FactoryBot.build(:user, name: 'Ellen') }
    purchasee { FactoryBot.build(:user, name: 'Both') }
    sequence(:subcategory) { |n| FactoryBot.build(:subcategory, name: "subcategory#{n}") }
  end
end
