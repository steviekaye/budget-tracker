class SubcategoriesController < ApplicationController
  def create
    @category = Category.find(params[:category_id])
    @subcategory = @category.subcategories.create(subcategory_params)

    redirect_to categories_path
  end

  def destroy
    @subcategory = Subcategory.find(params[:id])
    @subcategory.destroy

    redirect_to categories_path
end

  private

  def subcategory_params
    params.require(:subcategory).permit(:name)
  end
end
