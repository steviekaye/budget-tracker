require 'rails_helper'

RSpec.feature 'Summaries', type: :feature do
  before (:all) do
    FactoryBot.create(:user, name: 'Ellen')
    FactoryBot.create(:user, name: 'Ben')
    FactoryBot.create(:user, name: 'Both')
    FactoryBot.create(:subcategory)
  end

  before (:each) do
    visit root_path
  end

  scenario 'summarise all purchases' do
    FactoryBot.create(:purchase, description: 'Beer', amount: 7.30, subcategory: FactoryBot.build(:subcategory, name: 'Alcohol', category: FactoryBot.build(:category, name: 'Food and drink')))
    FactoryBot.create(:purchase, description: 'Socks', amount: 15.50, subcategory: FactoryBot.build(:subcategory, name: 'Clothing', category: FactoryBot.build(:category, name: 'Clothing')))
    click_link 'Summaries'

    expect(page).to have_content '$22.80'
  end

  after(:all) do
    # before/after(:all) is not transactional; see https://www.relishapp.com/rspec/rspec-rails/docs/transactions
    DatabaseCleaner.clean_with(:truncation)
  end
end
