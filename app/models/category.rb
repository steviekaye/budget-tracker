class Category < ApplicationRecord
  has_many :subcategories

  validates :name, uniqueness: true
end
