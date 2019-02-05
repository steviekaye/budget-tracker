class DataFormatter
  def initialize(purchases)
    @purchases = purchases
  end

  def category_totals
    Category.all.map do |c|
      [c.name, sum_purchases_in_category(c)]
    end
  end

  def category_totals_by_month
    sum_purchases_by_month(purchases_by_category)
  end

  private

  def sum_purchases_in_category(category)
    @purchases.where(subcategory: category.subcategories).to_a.map(&:amount).sum
  end

  def purchases_by_category
    totals = Category.all.map do |category|
      purchases = @purchases.where(subcategory: category.subcategories).map { |purchase| { date: purchase.date, amount: purchase.amount } }
      purchases.map { |purchase| purchase.merge!(name: category.name) }
    end

    totals.flatten.group_by { |n| n[:name] }
  end

  def sum_purchases_by_month(purchases_by_category)
    summaries = purchases_by_category.map do |key, value|
      { name: key, data: value.group_by_month { |n| n[:date] }.map do |key, value|
        [key.strftime('%B %Y'), value.map do |v|
          v[:amount]
        end.sum]
      end }
    end

    ensure_all_months_present(summaries)
  end

  def ensure_all_months_present(summaries)
    first_purchase = Purchase.minimum(:date)
    last_purchase = Purchase.maximum(:date)
    months_in_range = (first_purchase..last_purchase).map { |d| d.strftime('%B %Y') }.uniq

    summaries.each do |summary|
      month_totals = months_in_range.map do |month|
        existing_total = summary[:data].detect { |s| s.first == month }

        existing_total || [month, 0]
      end

      summary[:data] = month_totals
    end
   end
end
