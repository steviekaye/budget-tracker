require 'rails_helper'

RSpec.feature 'Purchases', type: :feature do
  before (:all) do
    FactoryBot.create(:user, name: 'Ellen')
    FactoryBot.create(:user, name: 'Ben')
    FactoryBot.create(:user, name: 'Both')
    FactoryBot.create(:subcategory)
    FactoryBot.create_list(:purchase, 28)
    FactoryBot.create_list(:purchase, 3, date: 2.days.ago)
    FactoryBot.create_list(:purchase, 3, date: 10.days.ago)
    FactoryBot.create_list(:purchase, 3, date: 23.days.ago)
  end

  before (:each) do
    visit root_path
  end

  scenario 'display twenty purchases by default' do
    click_link 'Purchases'

    purchases_count = page.all(:css, 'table tbody tr').size

    expect(purchases_count).to be == 20
  end

  scenario 'display five purchases after clicking appropriate button' do
    click_link 'Purchases'
    click_on 'button_limit_5'

    purchases_count = page.all(:css, 'table tbody tr').size

    expect(purchases_count).to be == 5
  end

  scenario 'display purchases from the last week' do
    click_link 'Purchases'
    click_on 'button_Week'

    purchases_count = page.all(:css, 'table tbody tr').size

    expect(purchases_count).to be == 3
  end

  scenario 'display purchases from the last fortnight' do
    click_link 'Purchases'
    click_on 'button_Fortnight'

    purchases_count = page.all(:css, 'table tbody tr').size

    expect(purchases_count).to be == 6
  end

  scenario 'display purchases from the last month' do
    click_link 'Purchases'
    click_on 'button_Month'

    purchases_count = page.all(:css, 'table tbody tr').size

    expect(purchases_count).to be == 9
  end

  after(:all) do
    # before/after(:all) is not transactional; see https://www.relishapp.com/rspec/rspec-rails/docs/transactions
    DatabaseCleaner.clean_with(:truncation)
  end
end
