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
    months_in_range = (first_purchase..last_purchase).map { |d| d.strftime('%B %Y') }.uniq

    group_and_sum_purchases_by_category_and_month(purchases_by_category, months_in_range)
  end

  def purchases_by_category
    totals = Category.all.map do |c|
      extract_purchases_by_category(c).map { |p| { name: c.name, date: p[:date], amount: p[:amount] } }
    end
    totals.flatten.group_by { |n| n[:name] }
  end

  def extract_purchases_by_category(category)
    Purchase.where(subcategory: category.subcategories).map { |p| { date: p.date, amount: p.amount } }
  end

  def group_and_sum_purchases_by_category_and_month(purchases_by_category, months_in_range)
    purchases_by_category.map { |key, value| { name: key, data: value.group_by_month { |n| n[:date] }.map { |key, value| [key.strftime('%B %Y'), value.map { |v| v[:amount] }.sum] } } }.each do |c|
      contained_months = c[:data].map(&:first)
      blank_months = months_in_range - contained_months
      blank_months.each { |b| insert_empty_month(c[:data], [b, 0]) }
    end
  end

  def insert_empty_month(vals, empty_month)
    vals.insert(vals.index { |instance| empty_month.first.to_date <= instance.first.to_date } || -1, empty_month)
  end
end
