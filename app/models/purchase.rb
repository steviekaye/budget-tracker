class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :subcategory

  validates :date, presence: true
  validates :description, presence: true
  validates :amount, presence: true
  validates :payee, presence: true
  validates_numericality_of :amount, greater_than: 0.0

  validate :date_cannot_be_in_the_future

  def date_cannot_be_in_the_future
    errors.add(:date, "can't be in the future") if
      date.present? && (date > Date.today)
    end
  end
