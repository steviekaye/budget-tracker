require 'rails_helper'

RSpec.feature 'Purchases', type: :feature do
  before (:all) do
    FactoryBot.create(:user, name: 'Ellen')
    FactoryBot.create(:user, name: 'Ben')
    FactoryBot.create(:user, name: 'Both')
    FactoryBot.create(:subcategory)
    FactoryBot.create_list(:purchase, 28)
  end

  before (:each) do
    visit root_path
  end

  scenario 'display twenty purchases by default' do
    click_link 'Purchases'

    numrows = page.all(:css, 'table tr').size - 1 # subtracting header row

    expect(numrows).to be == 20
  end

  scenario 'display five purchases after clicking appropriate button' do
    click_link 'Purchases'
    click_on 'button_limit_5'

    numrows = page.all(:css, 'table tr').size - 1 # subtracting header row

    expect(numrows).to be == 5
  end

  after(:all) do
    # before/after(:all) is not transactional; see https://www.relishapp.com/rspec/rspec-rails/docs/transactions
    DatabaseCleaner.clean_with(:truncation)
  end
end
