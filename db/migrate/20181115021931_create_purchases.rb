class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.date :date
      t.text :description
      t.float :amount
      t.references :user, foreign_key: true
      t.references :subcategory, foreign_key: true
      t.string :Payee

      t.timestamps
    end
  end
end
