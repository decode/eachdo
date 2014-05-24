class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.references :house, index: true
      t.decimal :day
      t.decimal :week
      t.decimal :month
      t.decimal :weekend
      t.string :weekend_type

      t.timestamps
    end
  end
end
