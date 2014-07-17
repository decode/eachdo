class House < ActiveRecord::Base
  belongs_to :user
  has_many :albums
  has_many :prices
  has_many :orders
  
  validates :name, :region, :address, :house_type, :area, :floor, :bed, presence: true

  HOUSE_TYPE = %W(民居 公寓 独幢别墅 旅馆 客栈 阁楼 四合院 海别小屋 集体宿舍 林间小屋 豪宅 城堡 树屋 船舱 房车 冰屋)
  FACILITY = %W(电视 空调 冰箱 洗衣机 24小时热水 饮水机 电脑 暖气 厨房 沐浴 浴缸 拖鞋 洗漱用品 毛巾浴巾 电梯)

  geocoded_by :geo_address

  def facilities
    self.facility.nil? ? [] : self.facility.strip.split(" ")
  end

  def district
    #name = ChinaCity.get(region)
    if region
      begin
        name = ChinaCity.get(region)
        city = ChinaCity.city(region)
        name = ChinaCity.get(city) + name unless city == region
        province = ChinaCity.province(region)
        name = ChinaCity.get(province) + name unless province == region
      rescue
        name = ""
      end
    end
    return name
  end

  def can_order?(from, to)
    return true if orders.length == 0
  end

  def date_price(date)
    if prices.length > 0
      p = prices.last 
      return p.day if date > p.end or date < p.start

      case date.wday
      when 1
        price = p.mon || p.day
      when 2
        price = p.tue || p.day
      when 3
        price = p.wed || p.day
      when 4
        price = p.thu || p.day
      when 5
        price = p.fri || p.day
      when 6
        price = p.sat || p.day
      when 0
        price = p.sun || p.day
      else
        price = p.day
      end
      return price
    else
      return 0
    end
  end

  state_machine :status, :initial => :draft do
    event :publish do
      transition [:draft, :close] => :open
    end

    event :order do
      transition :open => :reserve
    end
    
    event :checkin do
      transition [:open, :reserve] => :rent
    end

    event :checkout do
      transition [:reserve, :rent] => :open
    end

    event :close do
      transition :open => :close
    end
  end

end
