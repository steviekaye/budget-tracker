class Category < ApplicationRecord
  has_many :subcategories, dependent: :destroy

  has_many :purchases, through: :subcategories

  validates :name, uniqueness: true, presence: true
end
