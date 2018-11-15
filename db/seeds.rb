# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

CATEGORY_DATA = [
  {
    name: 'Basics',
    subcategories: ['Rent', 'Household expenses', 'Food - flat', 'Mobile phone', 'Storage unit']
  },
  {
    name: 'Food',
    subcategories: ['Cafe/coffee', 'Food - meal out', 'Food - snacks' 'Food - friends', 'Food - other', 'Alcohol']
  },
  {
    name: 'Clothing',
    subcategories: %w[Clothing Shoes]
  },
  {
    name: 'Travel',
    subcategories: ['Flights', 'Buses (long distance)', 'Public transport']
  },
  {
    name: 'Health',
    subcategories: %w[Doctor Counselling Dentist Gym]
  },
  {
    name: 'Entertainment',
    subcategories: ['Gig/event ticket', 'Books/records/etc', 'Movie ticket']
  },
  {
    name: 'Misc',
    subcategories: ['Postage', 'Github subscription', 'Actual misc']
  }
].freeze

if Category.none?
  CATEGORY_DATA.map do |category|
    cat = Category.create(name: category[:name])

    category[:subcategories].map do |sub|
      Subcategory.create(name: sub, category: cat)
    end
  end
end
