class CreateTaskScores < ActiveRecord::Migration
  def change
    create_table :task_scores do |t|
      t.float :score
      t.text :content
      t.references :user, index: true, foreign_key: true
      t.references :task, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
