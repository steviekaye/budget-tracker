require 'rails_helper'

RSpec.feature 'Categories', type: :feature do
  before (:all) do
    category = FactoryBot.create(:category, name: 'Existing Category')
    FactoryBot.create(:subcategory, name: 'ExistingSubCategory', category: category)
  end

  before (:each) do
    visit categories_path
  end

  scenario 'successfully create a new category' do
    expect do
      fill_in 'name', with: 'Test Category'
      click_on 'create_category'
    end.to change(Category.all, :count).by(1)
  end

  scenario 'unsuccessfully create a new category' do
    expect do
      fill_in 'name', with: 'Existing Category'
      click_on 'create_category'
    end.to change(Category.all, :count).by(0)
  end

  scenario 'successfully delete a category with subcategories' do
    expect do
      within('h2') do
        click_link 'Delete category'
      end
    end.to change(Category.all, :count).by(-1)
                                       .and change(Subcategory.all, :count).by(-1)
  end

  after(:all) do
    # before/after(:all) is not transactional; see https://www.relishapp.com/rspec/rspec-rails/docs/transactions
    DatabaseCleaner.clean_with(:truncation)
  end
end
