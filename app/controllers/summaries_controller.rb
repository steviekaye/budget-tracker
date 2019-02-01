class SummariesController < ApplicationController
  def index
    @totals = category_totals
    @overall_sum = Purchase.all.to_a.map(&:amount).sum
    @month_totals = sum_month(category_totals_per_month.flatten.group_by { |n| n[:name] })
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
      sum_purchases_by_month(c).map do |p|
        {
          name: c.name,
          date: p[:date],
          amount: p[:amount]
        }
      end
    end
  end

  def sum_purchases_by_month(cat)
    Purchase.where(subcategory: cat.subcategories).map { |p| { date: p.date, amount: p.amount } }
  end

  def sum_month(mon)
    mon.map { |key, value| { name: key, data: value.group_by_month { |n| n[:date] }.map { |key, value| [key.strftime('%B %Y'), value.map { |v| v[:amount] }.sum] } } }
  end
end
