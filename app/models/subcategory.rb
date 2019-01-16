class Subcategory < ApplicationRecord
  belongs_to :category

  validates :name, presence: true, uniqueness: { scope: :category,
                                                 message: 'subcategory names are unique within that category' }
end
