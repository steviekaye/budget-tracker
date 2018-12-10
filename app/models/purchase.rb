class Purchase < ApplicationRecord
  belongs_to :subcategory
  belongs_to :purchaser, class_name: 'User', foreign_key: 'purchaser_id'
  belongs_to :purchasee, class_name: 'User', foreign_key: 'purchasee_id'

  validates :date, presence: true
  validates :description, presence: true
  validates :amount, presence: true
  validates :payee, presence: true
  validates_numericality_of :amount, greater_than: 0.0
  validates :subcategory, presence: true

  validate :date_cannot_be_in_the_future

  def date_cannot_be_in_the_future
    errors.add(:date, "can't be in the future") if
      date.present? && (date > Date.today)
    end
  end
