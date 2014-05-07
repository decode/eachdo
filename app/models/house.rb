class House < ActiveRecord::Base
  belongs_to :user
  has_many :albums
  
  validates :name, :region, :address, :house_type, :area, :floor, :bed, presence: true

  HOUSE_TYPE = %W(民居 公寓 独幢别墅 旅馆 客栈 阁楼 四合院 海别小屋 集体宿舍 林间小屋 豪宅 城堡 树屋 船舱 房车 冰屋)
  FACILITY = %W(电视 空调 冰箱 洗衣机 24小时热水 饮水机 电脑 暖气 厨房 沐浴 浴缸 拖鞋 洗漱用品 毛巾浴巾 电梯)

  geocoded_by :geo_address

  def facilities
    self.facility.nil? ? [] : self.facility.strip.split(" ")
  end

  def district
    name = ChinaCity.get(region)
    if region
      name = ChinaCity.get(region)
      city = ChinaCity.city(region)
      name = ChinaCity.get(city) + name unless city == region
      province = ChinaCity.province(region)
      name = ChinaCity.get(province) + name unless province == region
    end
    return name
  end

end
