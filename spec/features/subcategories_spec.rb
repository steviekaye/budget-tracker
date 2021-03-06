require 'rails_helper'

RSpec.feature 'SubCategories', type: :feature do
  before (:all) do
    category = FactoryBot.create(:category, name: 'MyCategory')
    FactoryBot.create(:category, name: 'MyCategoryTwo')
    FactoryBot.create(:subcategory, name: 'ExistingSubCategory', category: category)
  end

  before (:each) do
    visit categories_path
  end

  describe 'user creates a subcategory' do
    context "when the subcategory name hasn't been used in that category" do
      it 'is successfully created' do
        expect do
          within('div#category_1') do
            fill_in 'subcategory_name', with: 'MySubCategory'
            click_on 'create_subcategory'
          end
        end.to change(Subcategory.all, :count).by(1)
      end
    end

    context 'when the subcategory name already exists within that category' do
      it 'is not created' do
        expect do
          within('div#category_1') do
            fill_in 'subcategory_name', with: 'ExistingSubCategory'
            click_on 'create_subcategory'
          end
        end.to change(Subcategory.all, :count).by(0)
      end
    end

    context 'when the subcategory name already exists within another category' do
      it 'is successfully created' do
        expect do
          within('div#category_2') do
            fill_in 'subcategory_name', with: 'MySubCategory'
            click_on 'create_subcategory'
          end
        end.to change(Subcategory.all, :count).by(1)
      end
    end
  end

  describe 'user renames a subcategory' do
    context 'when the new subcategory name is valid' do
      it 'is renamed' do
        expect do
          within('div#category_1') do
            Capybara.page.find('.js-edit-subcategory-icon').click
            fill_in 'subcategory_rename', with: 'RenamedSubcategory'
            click_on 'update_subcategory'
          end
        end.to change { Subcategory.first[:name] }.from('ExistingSubCategory').to('RenamedSubcategory')
      end
    end

    context 'when the new subcategory name is invalid' do
      it 'is not renamed' do
        expect do
          FactoryBot.create(:subcategory, name: 'AnotherSubcategory', category: Category.first)
          within('div#category_1') do
            Capybara.page.find('.js-edit-subcategory-icon').click
            fill_in 'subcategory_rename', with: 'AnotherSubcategory'
            click_on 'update_subcategory'
          end
        end.not_to change { Subcategory.first[:name] }
      end
    end
  end

  scenario 'successfully delete a new subcategory' do
    expect do
      within('div#category_1') do
        click_link 'Delete subcategory'
      end
    end.to change(Subcategory.all, :count).by(-1)
  end

  after(:all) do
    # before/after(:all) is not transactional; see https://www.relishapp.com/rspec/rspec-rails/docs/transactions
    DatabaseCleaner.clean_with(:truncation)
  end
end
