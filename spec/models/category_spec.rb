require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'when a category name already exists' do
    it 'is invalid' do
      FactoryBot.create(:category)
      category = FactoryBot.build(:category)
      category.valid?

      expect(category.errors[:name]).to include('has already been taken')
    end
  end

  context 'when a category name is blank' do
    it 'is invalid' do
      test_category = FactoryBot.build(:category, name: '')
      test_category.valid?

      expect(test_category.errors[:name]).to include("can't be blank")
    end
  end
end
