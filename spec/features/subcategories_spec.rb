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

  scenario 'sucessfully create a new subcategory' do
    expect do
      within('div#category_1') do
        fill_in 'subcategory_name', with: 'MySubCategory'
        click_on 'create_subcategory'
      end
    end.to change(Subcategory.all, :count).by(1)
  end

  scenario 'unsucessfully create a new subcategory where there is an existing category' do
    expect do
      within('div#category_1') do
        fill_in 'subcategory_name', with: 'ExistingSubCategory'
        click_on 'create_subcategory'
      end
    end.to change(Subcategory.all, :count).by(0)
  end

  scenario 'sucessfully create a new subcategory with the same name as another subcategory in a different category' do
    expect do
      within('div#category_2') do
        fill_in 'subcategory_name', with: 'MySubCategory'
        click_on 'create_subcategory'
      end
    end.to change(Subcategory.all, :count).by(1)
  end

  scenario 'sucessfully delete a new subcategory' do
    expect do
      within('div#category_1') do
        click_link 'Delete subcategory'
      end
    end.to change(Subcategory.all, :count).by(-1)
  end
end
