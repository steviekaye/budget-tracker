require 'rails_helper'

RSpec.describe Subcategory, type: :model do
  context 'when a subcategory name already exists within that category' do
    it 'is invalid' do
      testcategory = FactoryBot.create(:category)
      FactoryBot.create(:subcategory, category: testcategory)
      subcategory = FactoryBot.build(:subcategory, category: testcategory)
      subcategory.valid?

      expect(subcategory.errors[:name]).to include('subcategory names are unique within that category')
    end
  end

  context 'when a subcategory name already exists within another category' do
    it 'is valid' do
      testcategory = FactoryBot.create(:category, name: 'One')
      testcategory2 = FactoryBot.create(:category, name: 'Two')
      FactoryBot.create(:subcategory, category: testcategory)
      subcategory = FactoryBot.build(:subcategory, category: testcategory2)

      expect(subcategory).to be_valid
    end
  end
end
