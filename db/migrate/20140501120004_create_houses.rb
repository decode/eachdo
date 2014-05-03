class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.string :identifier
      t.string :name
      # 所在地区
      t.string :region
      # 详细地址
      t.string :address
      # 房屋类型
      t.string :house_type
      # 出租类型
      t.string :rent_type
      # 房屋面积
      t.decimal :area
      t.integer :floor
      t.string :floor_type
      t.string :capacity
      t.string :bed
      t.string :direction
      # 配套设施
      t.text :facility
      # 环境
      t.text :environment
      # 服务
      t.text :service
      # 周边
      t.text :surrounding
      # 其它
      t.text :other

      # 房屋状态
      t.string :status
      t.references :user, index: true

      t.timestamps
    end
  end
end
