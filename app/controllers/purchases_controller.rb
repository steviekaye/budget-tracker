class PurchasesController < ApplicationController
  def index
    @purchases = Purchase.all.order(:date).reverse_order.limit(5)
    @purchase = Purchase.new
    @categories = Category.all
  end

  def show; end

  def new; end

  def edit; end

  def create
    @categories = Category.all
    @purchase = Purchase.new(purchase_params)
    @purchase.subcategory = Subcategory.find(params[:subcategory_id]) if params[:subcategory_id].present?
    @purchase.purchaser = User.find(params[:purchase][:purchaser_id]) if params[:purchase][:purchaser_id].present?
    @purchase.purchasee = User.find(params[:purchase][:purchasee_id]) if params[:purchase][:purchasee_id].present?

    if @purchase.save
      redirect_to purchases_path
    else
      render 'index'
    end
  end

  def update; end

  private

  def purchase_params
    params.require(:purchase).permit(:date, :description, :amount, :payee, :subcategory)
  end
end
