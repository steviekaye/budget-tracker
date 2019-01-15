class Category < ApplicationRecord
  has_many :subcategories, dependent: :destroy

  validates :name, uniqueness: true, presence: true
end
