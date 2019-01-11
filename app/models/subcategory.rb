class Subcategory < ApplicationRecord
  belongs_to :category

  validates :name, uniqueness: { scope: :category,
                                 message: 'subcategory names are unique within that category' }
end
