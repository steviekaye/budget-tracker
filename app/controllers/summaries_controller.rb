class SummariesController < ApplicationController
  def index
    @totals = category_totals
    @overall_sum = Purchase.all.to_a.map(&:amount).sum
    @testthisout = category_totals_per_month
    byebug
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

  def category_totals_per_month
    Category.all.map do |c|
      [
        c.name,
        sum_purchases_by_month(c)
      ]
    end
    # do stuff here
  end

  def sum_purchases_by_month(cat)
    Purchase.where(subcategory: cat.subcategories).map { |p| { date: p.date, amount: p.amount } }
  end
end
