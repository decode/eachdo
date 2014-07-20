class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :house, index: true
      t.references :user, index: true
      t.references :price, index: true

      t.date :from, null: false
      t.date :to, null: false
      t.decimal :total_price
      t.decimal :deposit
      t.decimal :payment
      t.string :name
      t.string :phone
      t.boolean :is_oneself, default: true
      t.string :status

      t.timestamps
    end
  end

end
