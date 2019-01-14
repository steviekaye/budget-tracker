class CategoriesController < ApplicationController
  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path
    else
      render 'index'
    end
  end

  def index
    @categories = Category.all.order(:id)
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    redirect_to categories_path
  end

  def update
    @category = Category.find(params[:id])

    if @category.name == params[:category][:name]
      redirect_to categories_path
    else
      @category.name = params[:category][:name]
      @category.save

      redirect_to categories_path
    end
  end

  private

  def category_params
    params.permit(:name)
  end
end
