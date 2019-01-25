module PurchaseHelper
  def active_limit(val, limit)
    if val == limit
      ' is-dark'
    else
      ''
    end
  end

  def start_date(limit)
    if limit.instance_of? Hash
      limit['start_date']
    else
      ''
    end
  end

  def end_date(limit)
    if limit.instance_of? Hash
      limit['end_date']
    else
      ''
    end
  end

  def date_limit(limit)
    if limit.instance_of? Hash
      ' dark-date'
    else
      ''
    end
  end
end
