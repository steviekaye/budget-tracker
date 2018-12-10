class CategoryController < ApplicationController
  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to category_path
    else
      render 'index'
    end
  end

  def index
    @categories = Category.all
  end

  private

  def category_params
    params.permit(:name)
  end
end
