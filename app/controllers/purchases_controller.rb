class PurchasesController < ApplicationController
  @@purchase_limit = 20

  def index
    @plimit = @@purchase_limit
    @purchases = Purchase.order(:date).reverse_order.limit(@@purchase_limit)
  end

  def new
    @purchase = Purchase.new
    @categories = Category.all.order(:id)
  end

  def create
    @categories = Category.all.order(:id)

    @purchase = Purchase.new(purchase_params)
    @purchase.subcategory = Subcategory.find(params[:subcategory_id]) if params[:subcategory_id].present?
    @purchase.purchaser = User.find(params[:purchase][:purchaser_id]) if params[:purchase][:purchaser_id].present?
    @purchase.purchasee = User.find(params[:purchase][:purchasee_id]) if params[:purchase][:purchasee_id].present?

    if @purchase.save
      redirect_to purchases_path
    else
      render new_purchase_path
    end
  end

  def limit
    @@purchase_limit = params[:limit].to_i
    redirect_to purchases_path
  end

  private

  def purchase_params
    params.require(:purchase).permit(:date, :description, :amount, :payee, :subcategory)
  end
end
