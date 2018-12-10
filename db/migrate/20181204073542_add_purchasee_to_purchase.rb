class AddPurchaseeToPurchase < ActiveRecord::Migration[5.2]
  def change
    remove_reference :purchases, :user, index: true, foreign_key: true
    add_reference :purchases, :purchaser
    add_reference :purchases, :purchasee
  end
end
