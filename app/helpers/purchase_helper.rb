module PurchaseHelper
  def active_limit(val, limit)
    if val == limit
      ' is-dark'
    else
      ''
    end
  end
end
