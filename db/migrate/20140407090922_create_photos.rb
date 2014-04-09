class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :album, index: true
      t.string :title
      t.string :image
      t.text :description

      t.timestamps
    end
  end
end
