class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.text :description
      t.string :province
      t.string :city
      t.string :zipcode
      t.string :address

      t.timestamps null: false
    end
    add_index :schools, :name, unique: true
  end
end
