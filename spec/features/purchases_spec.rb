require 'rails_helper'

RSpec.feature 'Purchases', type: :feature do
  before (:all) do
    FactoryBot.create(:user, name: 'Ellen')
    FactoryBot.create(:user, name: 'Ben')
    FactoryBot.create(:user, name: 'Both')
    FactoryBot.create(:subcategory)
  end

  before (:each) do
    visit root_path
  end

  scenario 'successfully create a new purchase' do
    expect do
      fill_in 'Date', with: '2018-11-15'
      fill_in 'Description', with: 'Onion'
      fill_in 'Amount', with: 3.0
      select 'MySubCategory', from: 'subcategory_id'
      fill_in 'Payee', with: 'Evil Dairy'
      choose('purchase_purchaser_id_1')
      choose('purchase_purchasee_id_1')
      click_on 'Create Purchase'
    end.to change(Purchase.all, :count).by(1)
  end

  scenario 'unsuccessfully create a new purchase' do
    expect do
      fill_in 'Date', with: Date.tomorrow
      fill_in 'Description', with: 'Onion'
      fill_in 'Amount', with: 3.0
      select 'MySubCategory', from: 'subcategory_id'
      fill_in 'Payee', with: 'Evil Dairy'
      choose('purchase_purchaser_id_1')
      choose('purchase_purchasee_id_1')
      click_on 'Create Purchase'
    end.to change(Purchase.all, :count).by(0)

    expect(page).to have_content "can't be in the future"
  end

  after(:all) do
    # before/after(:all) is not transactional; see https://www.relishapp.com/rspec/rspec-rails/docs/transactions
    DatabaseCleaner.clean_with(:truncation)
  end
end
