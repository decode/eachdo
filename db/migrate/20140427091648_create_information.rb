class CreateInformation < ActiveRecord::Migration
  def change
    create_table :information do |t|
      t.references :user, index: true
      t.integer :login_count
      t.string :rank
      t.decimal :credit

      t.timestamps
    end
  end
end
