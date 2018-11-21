require 'rails_helper'

RSpec.feature 'Purchases', type: :feature do
  before (:all) do
    FactoryBot.create(:user, name: 'Ellen')
    FactoryBot.create(:user, name: 'Ben')
    FactoryBot.create(:subcategory)
  end

  before (:each) do
    visit root_path
  end

  scenario 'sucessfully create a new purchase' do
    expect do
      fill_in 'Date', with: '2018-11-15'
      fill_in 'Description', with: 'Onion'
      fill_in 'Amount', with: 3.0
      select 'MySubCategory', from: 'subcategory_id'
      fill_in 'Payee', with: 'Evil Dairy'
      choose('user_id_1')
      click_on 'Create Purchase'
    end.to change(Purchase.all, :count).by(1)
  end

  scenario 'unsucessfully create a new purchase' do
    expect do
      fill_in 'Date', with: Date.tomorrow
      fill_in 'Description', with: 'Onion'
      fill_in 'Amount', with: 3.0
      select 'MySubCategory', from: 'subcategory_id'
      fill_in 'Payee', with: 'Evil Dairy'
      choose('user_id_1')
      click_on 'Create Purchase'
    end.to change(Purchase.all, :count).by(0)

    expect(page).to have_content "can't be in the future"
  end

  scenario 'summarise all purchases' do
    FactoryBot.create_list(:purchase, 3)
    FactoryBot.create(:purchase, description: 'Beer', amount: 7.30, subcategory: FactoryBot.build(:subcategory, name: 'Alcohol'))

    click_link 'Summaries'

    expect(page).to have_content '$20.80'
  end
end
