class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :tid
      t.string :name
      t.string :grade
      t.text :description
      t.references :school

      t.timestamps null: false
    end
  end
end
