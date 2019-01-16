require 'rails_helper'

RSpec.feature 'Categories', type: :feature do
  before (:all) do
    category = FactoryBot.create(:category, name: 'Existing Category')
    FactoryBot.create(:subcategory, name: 'ExistingSubCategory', category: category)
  end

  before (:each) do
    visit categories_path
  end

  describe 'user creates a category' do
    context "when the category name hasn't been used" do
      it 'is successfully created' do
        expect do
          fill_in 'name', with: 'Test Category'
          click_on 'create_category'
        end.to change(Category.all, :count).by(1)
      end
    end

    context 'when the category name already exists' do
      it 'is not created' do
        expect do
          fill_in 'name', with: 'Existing Category'
          click_on 'create_category'
        end.to change(Category.all, :count).by(0)
      end
    end
  end

  scenario 'unsuccessfully delete a category with subcategories' do
    expect do
      within('h2') do
        click_link 'Delete category'
      end
    end.to raise_error(Capybara::ElementNotFound)
  end

  describe 'user renames a category' do
    context 'when the new category name is valid' do
      it 'is renamed' do
        expect do
          within('div#category_title_1') do
            Capybara.page.find('.js-edit-category-icon').click
            fill_in 'category_rename', with: 'Renamed Category'
            click_on 'update_category'
          end
        end.to change { Category.first[:name] }.from('Existing Category').to('Renamed Category')
      end
    end

    context 'when the new category name is invalid' do
      it 'is not renamed' do
        expect do
          FactoryBot.create(:category, name: 'Another Category')
          within('div#category_title_1') do
            Capybara.page.find('.js-edit-category-icon').click
            fill_in 'category_rename', with: 'Another Category'
            click_on 'update_category'
          end
        end.not_to change { Category.first[:name] }
      end
    end
  end

  scenario 'successfully delete a category' do
    expect do
      within('div#category_1') do
        click_link 'Delete subcategory'
      end
      within('h2') do
        click_link 'Delete category'
      end
    end.to change(Category.all, :count).by(-1)
  end

  after(:all) do
    # before/after(:all) is not transactional; see https://www.relishapp.com/rspec/rspec-rails/docs/transactions
    DatabaseCleaner.clean_with(:truncation)
  end
end
