require 'rails_helper'

RSpec.describe Subcategory, type: :model do
  context 'when a subcategory name already exists within that category' do
    it 'is invalid' do
      test_category = FactoryBot.create(:category)
      FactoryBot.create(:subcategory, category: test_category)
      subcategory = FactoryBot.build(:subcategory, category: test_category)
      subcategory.valid?

      expect(subcategory.errors[:name]).to include('subcategory names are unique within that category')
    end
  end

  context 'when a subcategory name already exists within another category' do
    it 'is valid' do
      test_category = FactoryBot.create(:category, name: 'One')
      test_category2 = FactoryBot.create(:category, name: 'Two')
      FactoryBot.create(:subcategory, category: test_category)
      subcategory = FactoryBot.build(:subcategory, category: test_category2)

      expect(subcategory).to be_valid
    end
  end

  context 'when a subcategory name is blank' do
    it 'is invalid' do
      test_category = FactoryBot.create(:category, name: 'One')
      subcategory = FactoryBot.build(:subcategory, name: '', category: test_category)
      subcategory.valid?

      expect(subcategory.errors[:name]).to include("can't be blank")
    end
  end
end
