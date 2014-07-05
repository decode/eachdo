class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.references :house, index: true
      t.decimal :day
      t.date :start
      t.date :end
      t.decimal :mon
      t.decimal :tue
      t.decimal :wed
      t.decimal :thu
      t.decimal :fri
      t.decimal :sat
      t.decimal :sun

      t.timestamps
    end
  end
end
