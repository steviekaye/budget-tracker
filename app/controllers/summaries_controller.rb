class SummariesController < ApplicationController
  def index
    @categories = Category.all
    @date_start = Purchase.minimum(:date)
    @date_end = Date.today
    @totals = category_totals
  end

  def category_totals
    @totals = []
    Category.all.each do |c|
      @totals << [c.name, Purchase.where(subcategory: c.subcategories).to_a.map(&:amount).sum]
    end
    @totals
  end
end
