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
  Purchase.create(date: '2018-11-15', description: 'Avocado', amount: 4.5, payee: 'Evil Dairy',
                  purchaser: User.first, purchasee: User.first, subcategory: Subcategory.find_by(name: 'Food - snacks'))
  Purchase.create(date: '2018-11-14', description: 'Cup of soup', amount: 3.0, payee: 'Patels',
                  purchaser: User.first, purchasee: User.first, subcategory: Subcategory.find_by(name: 'Food - snacks'))
  Purchase.create(date: '2018-11-18', description: 'Chocolate', amount: 6.30, payee: 'Shalimar',
                  purchaser: User.first, purchasee: User.third, subcategory: Subcategory.find_by(name: 'Food - snacks'))
  Purchase.create(date: '2018-11-09', description: 'Tamarillo', amount: 2.0, payee: 'Fruit shoppe',
                  purchaser: User.second, purchasee: User.third, subcategory: Subcategory.find_by(name: 'Food - snacks'))
  Purchase.create(date: '2018-11-22', description: 'Socks', amount: 18.99, payee: 'Farmers',
                  purchaser: User.second, purchasee: User.second, subcategory: Subcategory.find_by(name: 'Clothing'))
  Purchase.create(date: '2018-11-09', description: 'Snapper top-up', amount: 20.0, payee: 'Evil Dairy',
                  purchaser: User.second, purchasee: User.second, subcategory: Subcategory.find_by(name: 'Public transport'))
  Purchase.create(date: '2018-11-22', description: 'Summer hat', amount: 23.00, payee: 'Paperbag Princess',
                  purchaser: User.first, purchasee: User.first, subcategory: Subcategory.find_by(name: 'Clothing'))
  Purchase.create(date: '2019-01-05', description: 'Mandy tickets', amount: 26.00, payee: 'Lighthouse Cuba',
                  purchaser: User.first, purchasee: User.third, subcategory: Subcategory.find_by(name: 'Movie ticket'))
  Purchase.create(date: '2019-01-08', description: 'Beer beer', amount: 8.00, payee: 'Garage Project',
                  purchaser: User.first, purchasee: User.first, subcategory: Subcategory.find_by(name: 'Alcohol'))
  Purchase.create(date: '2019-01-10', description: 'Hot choco', amount: 5.00, payee: 'Scopa',
                  purchaser: User.first, purchasee: User.first, subcategory: Subcategory.find_by(name: 'Cafe/coffee'))
  Purchase.create(date: '2018-12-28', description: 'File folder', amount: 4.70, payee: 'Warehouse Stationary',
                  purchaser: User.second, purchasee: User.second, subcategory: Subcategory.find_by(name: 'Actual misc'))
  Purchase.create(date: '2018-10-13', description: 'Koha door charge', amount: 2.00, payee: 'Upoko Alpine Resort',
                  purchaser: User.second, purchasee: User.second, subcategory: Subcategory.find_by(name: 'Gig/event ticket'))
  Purchase.create(date: '2018-10-13', description: 'Cassette', amount: 10.00, payee: 'fruit juice parade',
                  purchaser: User.second, purchasee: User.second, subcategory: Subcategory.find_by(name: 'Books/records/etc'))
  Purchase.create(date: '2018-08-25', description: 'Book at book launch', amount: 20.00, payee: 'Lawrence & Gibson',
                  purchaser: User.second, purchasee: User.second, subcategory: Subcategory.find_by(name: 'Books/records/etc'))
  Purchase.create(date: '2018-08-21', description: 'Rent', amount: 320.00, payee: '9 Holloway Rd',
                  purchaser: User.second, purchasee: User.third, subcategory: Subcategory.find_by(name: 'Rent'))
  Purchase.create(date: '2018-08-21', description: 'Household expenses', amount: 50.00, payee: '9 Holloway Rd',
                  purchaser: User.second, purchasee: User.third, subcategory: Subcategory.find_by(name: 'Household expenses'))
  Purchase.create(date: '2018-08-21', description: 'Food - flat', amount: 100.00, payee: '9 Holloway Rd',
                  purchaser: User.second, purchasee: User.third, subcategory: Subcategory.find_by(name: 'Food - flat'))
  Purchase.create(date: '2018-08-14', description: 'Rent', amount: 320.00, payee: '9 Holloway Rd',
                  purchaser: User.second, purchasee: User.third, subcategory: Subcategory.find_by(name: 'Rent'))
  Purchase.create(date: '2018-08-14', description: 'Household expenses', amount: 50.00, payee: '9 Holloway Rd',
                  purchaser: User.second, purchasee: User.third, subcategory: Subcategory.find_by(name: 'Household expenses'))
  Purchase.create(date: '2018-08-14', description: 'Food - flat', amount: 100.00, payee: '9 Holloway Rd',
                  purchaser: User.second, purchasee: User.third, subcategory: Subcategory.find_by(name: 'Food - flat'))
  Purchase.create(date: '2018-08-28', description: 'Rent', amount: 320.00, payee: '9 Holloway Rd',
                  purchaser: User.second, purchasee: User.third, subcategory: Subcategory.find_by(name: 'Rent'))
  Purchase.create(date: '2018-08-28', description: 'Household expenses', amount: 50.00, payee: '9 Holloway Rd',
                  purchaser: User.second, purchasee: User.third, subcategory: Subcategory.find_by(name: 'Household expenses'))
  Purchase.create(date: '2018-08-28', description: 'Food - flat', amount: 100.00, payee: '9 Holloway Rd',
                  purchaser: User.second, purchasee: User.third, subcategory: Subcategory.find_by(name: 'Food - flat'))
end
