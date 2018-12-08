class CategoryController < ApplicationController
  def create
    @categories = Category.all
    @category = Category.new(category_params)

    if @category.save
      redirect_to category_path
    else
      render 'index'
    end
  end

  def category
    @categories = Category.all
    # @category = Category.find(params[:id])
  end

  private

  def category_params
    params.permit(:name)
  end
end
