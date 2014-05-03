class AddHouseReferenceToAlbums < ActiveRecord::Migration
  def change
    add_reference :albums, :house, index: true
  end
end
