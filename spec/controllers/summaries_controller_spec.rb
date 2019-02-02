require 'rails_helper'

RSpec.describe SummariesController, type: :controller do
  describe 'assignation of month totals' do
    before do
      basics_category = FactoryBot.build(:category, name: 'Basics')
      food_category = FactoryBot.build(:category, name: 'Food')
      rent_subcategory = FactoryBot.build(:subcategory, name: 'Rent', category: basics_category)
      groceries_subcategory = FactoryBot.build(:subcategory, name: 'Groceries', category: food_category)

      FactoryBot.create(:purchase, description: 'Rent', amount: 150, date: '2018-12-15', subcategory: rent_subcategory)
      FactoryBot.create(:purchase, description: 'Rent', amount: 100, date: '2018-11-15', subcategory: rent_subcategory)
      FactoryBot.create(:purchase, description: 'Durian', amount: 70, date: '2018-12-15', subcategory: groceries_subcategory)
      FactoryBot.create(:purchase, description: 'Durian', amount: 60, date: '2018-11-15', subcategory: groceries_subcategory)
    end

    it 'assigns the instance variable @category_totals_by_month' do
      get :index
      expect(assigns(:category_totals_by_month)).to_not be nil
    end

    context 'correctly shapes the data for chartkick' do
      it 'includes correctly structured items' do
        expected = { data: [['November 2018', 100], ['December 2018', 150]], name: 'Basics' }

        get :index
        expect(assigns(:category_totals_by_month).first).to eq(expected)
      end

      it 'is in month order' do
        expected = { data: [['November 2018', 100], ['December 2018', 150]], name: 'Basics' }

        get :index
        expect(assigns(:category_totals_by_month).first).to eq(expected)
      end
    end
  end
end
