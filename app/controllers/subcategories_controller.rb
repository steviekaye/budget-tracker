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

  def update
    @subcategory = Subcategory.find(params[:id])

    if @subcategory.name == params[:subcategory][:name]
      redirect_to categories_path
    else
      @subcategory.name = params[:subcategory][:name]
      @subcategory.save

      redirect_to categories_path
    end
  end

  private

  def subcategory_params
    params.require(:subcategory).permit(:name)
  end
end
