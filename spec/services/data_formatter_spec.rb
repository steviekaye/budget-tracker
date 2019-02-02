require 'rails_helper'

RSpec.describe DataFormatter, type: :service do
  before do
    basics_category = FactoryBot.build(:category, name: 'Basics')
    food_category = FactoryBot.build(:category, name: 'Food')
    rent_subcategory = FactoryBot.build(:subcategory, name: 'Rent', category: basics_category)
    groceries_subcategory = FactoryBot.build(:subcategory, name: 'Groceries', category: food_category)

    FactoryBot.create(:purchase, description: 'Rent', amount: 150, date: '2018-12-15', subcategory: rent_subcategory)
    FactoryBot.create(:purchase, description: 'Rent', amount: 100, date: '2018-10-15', subcategory: rent_subcategory)
    FactoryBot.create(:purchase, description: 'Durian', amount: 70, date: '2018-12-15', subcategory: groceries_subcategory)
    FactoryBot.create(:purchase, description: 'Durian', amount: 60, date: '2018-10-15', subcategory: groceries_subcategory)
  end

  describe '#category_totals' do
    it 'correctly sums category totals' do
      expected = [['Basics', 0.25e3], ['Food', 0.13e3]]

      expect(DataFormatter.new(Purchase.all).category_totals).to eq(expected)
    end
  end

  describe '#category_totals_by_month' do
    it 'correctly sums totals by month' do
      expected = [{ data: [['October 2018', 0.1e3], ['November 2018', 0], ['December 2018', 0.15e3]], name: 'Basics' }, { data: [['October 2018', 0.6e2], ['November 2018', 0], ['December 2018', 0.7e2]], name: 'Food' }]

      expect(DataFormatter.new(Purchase.all).category_totals_by_month).to eq(expected)
    end
  end

  # TODO: month order with more complicated data, empty months
end
