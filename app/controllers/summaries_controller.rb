class SummariesController < ApplicationController
  def index
    purchases = Purchase.all
    @totals = DataFormatter.new(purchases).category_totals
    @overall_sum = Purchase.all.to_a.map(&:amount).sum
    @category_totals_by_month = DataFormatter.new(purchases).category_totals_by_month
  end
end
