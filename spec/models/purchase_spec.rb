require 'rails_helper'

RSpec.describe Purchase, type: :model do
  context 'when it has valid attributes' do
    it 'is valid' do
      purchase = FactoryBot.build(:purchase)

      expect(purchase).to be_valid
    end
  end

  context 'when a date is nil' do
    it 'is invalid' do
      purchase = FactoryBot.build(:purchase, date: nil)
      purchase.valid?

      expect(purchase.errors[:date]).to include("can't be blank")
    end
  end

  context 'when an amount is negative' do
    it 'is invalid' do
      purchase = FactoryBot.build(:purchase, amount: -1.5)
      purchase.valid?

      expect(purchase.errors[:amount]).to include('must be greater than 0.0')
    end
  end

  context 'when a purchase has a future date' do
    it 'is invalid' do
      purchase = FactoryBot.build(:purchase, date: Date.tomorrow + 2)
      purchase.valid?

      expect(purchase.errors[:date]).to include("can't be in the future")
    end
  end
end
