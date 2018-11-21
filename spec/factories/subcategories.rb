FactoryBot.define do
  factory :subcategory do
    name { 'MySubCategory' }
    category { FactoryBot.create(:category) }
  end
end
