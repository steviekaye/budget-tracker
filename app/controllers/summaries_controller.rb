class SummariesController < ApplicationController
  def index
    @totals = category_totals
    @overall_sum = Purchase.all.to_a.map(&:amount).sum
  end

  private

  def category_totals
    Category.all.map do |c|
      [
        c.name,
        sum_purchases_in_category(c)
      ]
    end
  end

  def sum_purchases_in_category(cat)
    Purchase.where(subcategory: cat.subcategories).to_a.map(&:amount).sum
  end
end
