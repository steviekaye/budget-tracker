require 'rails_helper'

RSpec.feature 'Categories', type: :feature do
  before (:all) do
    FactoryBot.create(:category, name: 'Existing Category')
  end

  before (:each) do
    visit categories_path
  end

  scenario 'sucessfully create a new category' do
    expect do
      fill_in 'name', with: 'Test Category'
      click_on 'create_category'
    end.to change(Category.all, :count).by(1)
  end

  scenario 'unsucessfully create a new category' do
    expect do
      fill_in 'name', with: 'Existing Category'
      click_on 'create_category'
    end.to change(Category.all, :count).by(0)
  end
end
