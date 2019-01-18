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

    numrows = page.all(:css, 'table tbody tr').size

    expect(numrows).to be == 20
  end

  scenario 'display five purchases after clicking appropriate button' do
    click_link 'Purchases'
    click_on 'button_limit_5'

    numrows = page.all(:css, 'table tbody tr').size

    expect(numrows).to be == 5
  end

  scenario 'display three purchases after clicking on week button' do
    click_link 'Purchases'
    click_on 'button_Week'

    numrows = page.all(:css, 'table tbody tr').size # subtracting header row

    expect(numrows).to be == 3
  end

  scenario 'display six purchases after clicking on fortnight button' do
    click_link 'Purchases'
    click_on 'button_Fortnight'

    numrows = page.all(:css, 'table tbody tr').size # subtracting header row

    expect(numrows).to be == 6
  end

  scenario 'display nine purchases after clicking on month button' do
    click_link 'Purchases'
    click_on 'button_Month'

    numrows = page.all(:css, 'table tbody tr').size # subtracting header row

    expect(numrows).to be == 9
  end

  after(:all) do
    # before/after(:all) is not transactional; see https://www.relishapp.com/rspec/rspec-rails/docs/transactions
    DatabaseCleaner.clean_with(:truncation)
  end
end
