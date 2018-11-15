class PurchasesController < ApplicationController
  def index
    @purchases = Purchase.all
    @purchase = Purchase.new
    @categories = Category.all
  end

  def show
    @purchase = Purchase.find(params[:id])
  end

  def new; end

  def edit
    @purchase = Purchase.find(params[:id])
  end

  def create
    @purchase = Purchase.new(purchase_params)
    @purchase.category = Subcategory.find(params[:subcategory_id])
  end
end
