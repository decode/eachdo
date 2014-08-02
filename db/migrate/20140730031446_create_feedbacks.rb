class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.references :house, index: true
      t.references :order, index: true
      t.references :user, index: true
      t.string :title
      t.text :comment
      t.decimal :rating
      t.string :judgement

      t.timestamps
    end
  end
end
