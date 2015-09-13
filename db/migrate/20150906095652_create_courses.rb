class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :cid
      t.string :name
      t.string :term
      t.string :status
      t.text :description
      t.references :user
      t.references :school

      t.timestamps null: false
    end
    add_index :courses, :cid, unique: true
  end
end
