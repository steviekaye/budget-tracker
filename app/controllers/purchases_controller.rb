class PurchasesController < ApplicationController
  def index
    @purchases = Purchase.all
    @purchase = Purchase.new
    @categories = Category.all
  end

  def show; end

  def new; end

  def edit; end

  def create
    @categories = Category.all
    @purchase = Purchase.new(purchase_params)
    @purchase.subcategory = Subcategory.find(params[:subcategory_id])
    @purchase.user = User.find(params[:user_id])

    @purchase.save

    redirect_to purchases_path
  end

  def update; end

  private

  def purchase_params
    params.require(:purchase).permit(:date, :description, :amount, :payee)
  end
end
