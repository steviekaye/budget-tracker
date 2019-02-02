class SummariesController < ApplicationController
  def index
    @totals = category_totals
    @overall_sum = Purchase.all.to_a.map(&:amount).sum
    @month_totals = month_totals
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

  def sum_purchases_in_category(category)
    Purchase.where(subcategory: category.subcategories).to_a.map(&:amount).sum
  end

  def month_totals
    first_purchase = Purchase.all.order(:date).first[:date]
    last_purchase = Purchase.all.order(:date).last[:date] # this could be Date.today rather than most recent purchase
    date_range = (first_purchase..last_purchase).map { |d| d.strftime('%B %Y') }.uniq
    sum_month(category_totals_per_month.flatten.group_by { |n| n[:name] }, date_range)
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

  def sum_purchases_by_month(category)
    Purchase.where(subcategory: category.subcategories).map { |p| { date: p.date, amount: p.amount } }
  end

  def sum_month(month, date_range)
    month.map { |key, value| { name: key, data: value.group_by_month { |n| n[:date] }.map { |key, value| [key.strftime('%B %Y'), value.map { |v| v[:amount] }.sum] } } }.each do |c|
      contained_months = c[:data].map(&:first)
      blank_months = date_range - contained_months
      blanks_months.each { |b| insert_empty_month(c[:data], [b, 0]) }
    end
  end

  def insert_empty_month(vals, empty_month)
    vals.insert(vals.index { |instance| empty_month.first.to_date <= instance.first.to_date } || -1, empty_month)
  end
end
