class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.date :date
      t.text :description
      t.decimal :amount, precision: 15, scale: 2
      t.references :user, foreign_key: true
      t.references :subcategory, foreign_key: true
      t.string :payee

      t.timestamps
    end
  end
end
