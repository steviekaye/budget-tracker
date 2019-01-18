FactoryBot.define do
  factory :subcategory do
    name { 'MySubCategory' }
    sequence(:category) { |n| FactoryBot.create(:category, name: "testcategory#{n}") }
  end
end
