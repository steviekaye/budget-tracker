require 'rails_helper'

RSpec.describe DataFormatter, type: :service do
  before(:each) do
    DatabaseCleaner.clean_with(:truncation)
  end

  let(:basics_category) { FactoryBot.build(:category, name: 'Basics') }
  let(:food_category) { FactoryBot.build(:category, name: 'Food') }
  let(:rent_subcategory) { FactoryBot.build(:subcategory, name: 'Rent', category: basics_category) }
  let(:groceries_subcategory) { FactoryBot.build(:subcategory, name: 'Groceries', category: food_category) }

  describe '#category_totals' do
    before do
      FactoryBot.create(:purchase, amount: 150, subcategory: rent_subcategory)
      FactoryBot.create(:purchase, amount: 100, subcategory: rent_subcategory)
      FactoryBot.create(:purchase, amount: 70, subcategory: groceries_subcategory)
      FactoryBot.create(:purchase, amount: 60, subcategory: groceries_subcategory)
    end

    it 'correctly sums category totals' do
      expected = [['Basics', 250], ['Food', 130]]

      expect(DataFormatter.new(Purchase.all).category_totals).to eq(expected)
    end
  end

  describe '#category_totals_by_month' do
    let(:october_date)  { '2018-10-15' }
    let(:november_date) { '2018-11-15' }

    context 'when each category has a purchase from each month' do
      before do
        FactoryBot.create(:purchase, amount: 150, date: october_date, subcategory: rent_subcategory)
        FactoryBot.create(:purchase, amount: 100, date: november_date, subcategory: rent_subcategory)
        FactoryBot.create(:purchase, amount: 70, date: october_date, subcategory: groceries_subcategory)
        FactoryBot.create(:purchase, amount: 60, date: november_date, subcategory: groceries_subcategory)
      end

      it 'correctly sums the categories per month' do
        expected = [{ name: 'Basics', data: [['October 2018', 150], ['November 2018', 100]] },
                    { name: 'Food', data: [['October 2018', 70], ['November 2018', 60]] }]

        expect(DataFormatter.new(Purchase.all).category_totals_by_month).to eq expected
      end
    end

    context 'when not all categories have a purchase from each month' do
      before do
        FactoryBot.create(:purchase, amount: 150, date: october_date, subcategory: rent_subcategory)
        FactoryBot.create(:purchase, amount: 100, date: november_date, subcategory: rent_subcategory)
        FactoryBot.create(:purchase, amount: 70, date: october_date, subcategory: groceries_subcategory)
        FactoryBot.create(:purchase, amount: 60, date: november_date, subcategory: groceries_subcategory)
        FactoryBot.create(:purchase, amount: 85, date: '2018-12-20', subcategory: groceries_subcategory)
      end

      it 'correctly sums the categories by month, adding zero totals where appropriate' do
        expected = [{ name: 'Basics', data: [['October 2018', 150], ['November 2018', 100], ['December 2018', 0]] },
                    { name: 'Food', data: [['October 2018', 70], ['November 2018', 60], ['December 2018', 85]] }]

        expect(DataFormatter.new(Purchase.all).category_totals_by_month).to eq expected
      end
    end
  end
end
