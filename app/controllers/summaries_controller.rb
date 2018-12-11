class SummariesController < ApplicationController
  def index
    @categories = Category.all
    @date_start = Purchase.minimum(:date)
    @date_end = Date.today
  end
end
