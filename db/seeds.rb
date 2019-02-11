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
  Purchase.create(date: 1.month.ago, description: 'Avocado', amount: 4.5, payee: 'Evil Dairy',
                  purchaser: User.first, purchasee: User.first, subcategory: Subcategory.find_by(name: 'Food - snacks'))
  Purchase.create(date: 1.month.ago(1.days.ago), description: 'Cup of soup', amount: 3.0, payee: 'Patels',
                  purchaser: User.first, purchasee: User.first, subcategory: Subcategory.find_by(name: 'Food - snacks'))
  Purchase.create(date: 1.month.ago(1.days.since), description: 'Chocolate', amount: 6.30, payee: 'Shalimar',
                  purchaser: User.first, purchasee: User.third, subcategory: Subcategory.find_by(name: 'Food - snacks'))
  Purchase.create(date: 1.month.ago(6.days.ago), description: 'Tamarillo', amount: 2.0, payee: 'Fruit shoppe',
                  purchaser: User.second, purchasee: User.third, subcategory: Subcategory.find_by(name: 'Food - snacks'))
  Purchase.create(date: 1.month.ago(1.weeks.since), description: 'Socks', amount: 18.99, payee: 'Farmers',
                  purchaser: User.second, purchasee: User.second, subcategory: Subcategory.find_by(name: 'Clothing'))
  Purchase.create(date: 1.month.ago(6.days.ago), description: 'Snapper top-up', amount: 20.0, payee: 'Evil Dairy',
                  purchaser: User.second, purchasee: User.second, subcategory: Subcategory.find_by(name: 'Public transport'))
  Purchase.create(date: 1.month.ago(1.weeks.since), description: 'Summer hat', amount: 23.00, payee: 'Paperbag Princess',
                  purchaser: User.first, purchasee: User.first, subcategory: Subcategory.find_by(name: 'Clothing'))
  Purchase.create(date: 1.week.ago, description: 'Mandy tickets', amount: 26.00, payee: 'Lighthouse Cuba',
                  purchaser: User.first, purchasee: User.third, subcategory: Subcategory.find_by(name: 'Movie ticket'))
  Purchase.create(date: 6.days.ago, description: 'Beer beer', amount: 8.00, payee: 'Garage Project',
                  purchaser: User.first, purchasee: User.first, subcategory: Subcategory.find_by(name: 'Alcohol'))
  Purchase.create(date: 3.days.ago, description: 'Hot choco', amount: 5.00, payee: 'Scopa',
                  purchaser: User.first, purchasee: User.first, subcategory: Subcategory.find_by(name: 'Cafe/coffee'))
  Purchase.create(date: 3.weeks.ago, description: 'File folder', amount: 4.70, payee: 'Warehouse Stationary',
                  purchaser: User.second, purchasee: User.second, subcategory: Subcategory.find_by(name: 'Actual misc'))
  Purchase.create(date: 2.months.ago, description: 'Koha door charge', amount: 2.00, payee: 'Upoko Alpine Resort',
                  purchaser: User.second, purchasee: User.second, subcategory: Subcategory.find_by(name: 'Gig/event ticket'))
  Purchase.create(date: 2.months.ago(1.days.since), description: 'Cassette', amount: 10.00, payee: 'fruit juice parade',
                  purchaser: User.second, purchasee: User.second, subcategory: Subcategory.find_by(name: 'Books/records/etc'))
  Purchase.create(date: 4.months.ago, description: 'Book at book launch', amount: 20.00, payee: 'Lawrence & Gibson',
                  purchaser: User.second, purchasee: User.second, subcategory: Subcategory.find_by(name: 'Books/records/etc'))
  Purchase.create(date: 4.months.ago(5.days.ago), description: 'Rent', amount: 70.00, payee: '9 Holloway Rd',
                  purchaser: User.second, purchasee: User.third, subcategory: Subcategory.find_by(name: 'Rent'))
  Purchase.create(date: 4.months.ago, description: 'Household expenses', amount: 50.00, payee: '9 Holloway Rd',
                  purchaser: User.second, purchasee: User.third, subcategory: Subcategory.find_by(name: 'Household expenses'))
  Purchase.create(date: 4.months.ago, description: 'Food - flat', amount: 40.00, payee: '9 Holloway Rd',
                  purchaser: User.second, purchasee: User.third, subcategory: Subcategory.find_by(name: 'Food - flat'))
  Purchase.create(date: 3.months.ago, description: 'Rent', amount: 70.00, payee: '9 Holloway Rd',
                  purchaser: User.second, purchasee: User.third, subcategory: Subcategory.find_by(name: 'Rent'))
  Purchase.create(date: 3.months.ago, description: 'Household expenses', amount: 50.00, payee: '9 Holloway Rd',
                  purchaser: User.second, purchasee: User.third, subcategory: Subcategory.find_by(name: 'Household expenses'))
  Purchase.create(date: 2.months.ago, description: 'Food - flat', amount: 40.00, payee: '9 Holloway Rd',
                  purchaser: User.second, purchasee: User.third, subcategory: Subcategory.find_by(name: 'Food - flat'))
  Purchase.create(date: 2.months.ago, description: 'Rent', amount: 70.00, payee: '9 Holloway Rd',
                  purchaser: User.second, purchasee: User.third, subcategory: Subcategory.find_by(name: 'Rent'))
  Purchase.create(date: 1.months.ago, description: 'Household expenses', amount: 50.00, payee: '9 Holloway Rd',
                  purchaser: User.second, purchasee: User.third, subcategory: Subcategory.find_by(name: 'Household expenses'))
  Purchase.create(date: 1.months.ago, description: 'Food - flat', amount: 40.00, payee: '9 Holloway Rd',
                  purchaser: User.second, purchasee: User.third, subcategory: Subcategory.find_by(name: 'Food - flat'))
  Purchase.create(date: 3.months.ago, description: 'Plane ticket', amount: 70.00, payee: 'Jetstar',
                  purchaser: User.second, purchasee: User.second, subcategory: Subcategory.find_by(name: 'Flights'))
  Purchase.create(date: 3.months.ago, description: 'Package to France', amount: 33.00, payee: 'NZ Post',
                  purchaser: User.second, purchasee: User.second, subcategory: Subcategory.find_by(name: 'Postage'))
  Purchase.create(date: 4.months.ago, description: 'Dental checkup', amount: 85.00, payee: 'Tooths R Us',
                  purchaser: User.second, purchasee: User.first, subcategory: Subcategory.find_by(name: 'Dentist'))
  Purchase.create(date: 1.week.ago, description: 'Gym membership', amount: 40.00, payee: 'Sweat It Out',
                  purchaser: User.second, purchasee: User.first, subcategory: Subcategory.find_by(name: 'Gym'))
  Purchase.create(date: 2.months.ago, description: 'Blue suede shoes', amount: 60.00, payee: 'Tread City',
                  purchaser: User.second, purchasee: User.second, subcategory: Subcategory.find_by(name: 'Shoes'))
end
