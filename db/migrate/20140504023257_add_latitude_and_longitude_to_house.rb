class AddLatitudeAndLongitudeToHouse < ActiveRecord::Migration
  def change
    add_column :houses, :latitude, :float
    add_column :houses, :longitude, :float
    add_column :houses, :geo_address, :string
  end
end
