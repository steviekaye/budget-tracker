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
    subcategories: ['Cafe/coffee', 'Food - meal out', 'Food - snacks', 'Food - friends', 'Food - other', 'Alcohol']
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

if User.none?
  User.create(name: 'Ellen')
  User.create(name: 'Ben')
  User.create(name: 'Both')
end

if Purchase.none?
  Purchase.create(date: '2018-11-15', description: 'Avocado', amount: 4.5, payee: 'Evil Dairy', purchaser: User.find(1), purchasee: User.find(1), subcategory: Subcategory.find(8))
  Purchase.create(date: '2018-11-14', description: 'Cup of soup', amount: 3.0, payee: 'Patels', purchaser: User.find(1), purchasee: User.find(1), subcategory: Subcategory.find(8))
  Purchase.create(date: '2018-11-18', description: 'Chocolate', amount: 6.30, payee: 'Shalimar', purchaser: User.find(1), purchasee: User.find(3), subcategory: Subcategory.find(9))
  Purchase.create(date: '2018-11-09', description: 'Tamarillo', amount: 2.0, payee: 'Fruit shoppe', purchaser: User.find(2), purchasee: User.find(3), subcategory: Subcategory.find(3))
  Purchase.create(date: '2018-11-22', description: 'Socks', amount: 18.99, payee: 'Farmers', purchaser: User.find(2), purchasee: User.find(2), subcategory: Subcategory.find(12))
  Purchase.create(date: '2018-11-09', description: 'Snapper top-up', amount: 20.0, payee: 'Evil Dairy', purchaser: User.find(2), purchasee: User.find(2), subcategory: Subcategory.find(16))
  Purchase.create(date: '2018-11-22', description: 'Summer hat', amount: 23.00, payee: 'Paperbag Princess', purchaser: User.find(1), purchasee: User.find(1), subcategory: Subcategory.find(3))
end
