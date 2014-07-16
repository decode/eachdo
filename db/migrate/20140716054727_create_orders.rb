class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :house, index: true
      t.references :user, index: true
      t.date :from, null: false
      t.date :to, null: false
      t.decimal :price
      t.decimal :deposit
      t.decimal :payment
      t.string :name
      t.string :phone
      t.boolean :is_oneself, null: false

      t.timestamps
    end
  end
end
