class PurchasesController < ApplicationController
  @@purchase_limit = 20

  def index
    @plimit = @@purchase_limit
    @purchases = purchase_sort
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
    if params[:limit]
      @@purchase_limit = params[:limit].to_i
    elsif params[:date]
      @@purchase_limit = params[:date].to_date
    elsif params[:start_date] && params[:end_date]
      if validate_dates(params[:start_date].to_date, params[:end_date].to_date)
        @@purchase_limit = { 'start_date' => params[:start_date].to_date, 'end_date' => params[:end_date].to_date }
      end
    end
    redirect_to purchases_path
  end

  private

  def purchase_params
    params.require(:purchase).permit(:date, :description, :amount, :payee, :subcategory)
  end

  def purchase_sort
    if @@purchase_limit.instance_of? Integer
      Purchase.order(:date).reverse_order.limit(@@purchase_limit)
    elsif @@purchase_limit.instance_of? Date
      Purchase.where(date: @@purchase_limit..Date.current).order(:date).reverse_order
    elsif @@purchase_limit.instance_of? Hash
      @purchases = Purchase.where(date: @@purchase_limit['start_date']..@@purchase_limit['end_date']).order(:date).reverse_order
    else
      raise 'Invalid sorting value'
    end
  end

  def validate_dates(start_date, end_date)
    if start_date < end_date
      true
    else
      raise 'Invalid date range'
    end
  end
end
