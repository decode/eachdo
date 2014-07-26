class House < ActiveRecord::Base
  belongs_to :user
  has_many :albums
  has_many :prices
  has_many :orders
  
  validates :name, :region, :address, :house_type, :area, :floor, :bed, presence: true

  before_create :save_region
  before_save :save_region

  HOUSE_TYPE = %W(民居 公寓 独幢别墅 旅馆 客栈 阁楼 四合院 海别小屋 集体宿舍 林间小屋 豪宅 城堡 树屋 船舱 房车 冰屋)
  FACILITY = %W(电视 空调 冰箱 洗衣机 24小时热水 饮水机 电脑 暖气 厨房 沐浴 浴缸 拖鞋 洗漱用品 毛巾浴巾 电梯)

  geocoded_by :geo_address

  def facilities
    self.facility.nil? ? [] : self.facility.strip.split(" ")
  end

  def save_region
    if region
      begin
        self.district = ChinaCity.get region
        c = ChinaCity.city region
        self.city = ChinaCity.get c
        p = ChinaCity.province region
        self.province = ChinaCity.get p
      rescue
      end
    end
  end

  def district
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

  def can_order?(*range)
    return false unless status == 'open'
    if range.length > 0
      from = range[0][:from]
      to = range[0][:to]
      exe_orders = orders.where status: 'execution'
      exe_orders.each do |o|
        return false if from < DateTime.now.to_date
        return false if (from < o.to and to > o.to) or (from < o.from and to > o.from)
      end
    end
    return true
  end

  def is_order?(date)
    return false unless orders.length > 0
    orders.where(status: 'execution').each do |order|
      return true if (order.from..order.to).include?(date)
    end
    return false
  end

  def date_price(date, amount, *price)
    if price.length > 0 and !price[0].nil?
      p = price[0]
    elsif prices.length > 0
      p = prices.last 
    else
      return 0
    end

    return p.day * amount if date > p.end or date < p.start

    case date.wday
    when 1
      m = p.mon || p.day
    when 2
      m = p.tue || p.day
    when 3
      m = p.wed || p.day
    when 4
      m = p.thu || p.day
    when 5
      m = p.fri || p.day
    when 6
      m = p.sat || p.day
    when 0
      m = p.sun || p.day
    else
      m = p.day
    end
    return m * amount 
  end

  def total_price(from, to, amount)
    return 0 if from > to
    price = 0
    (from..to).each do |t|
      price += date_price(t, amount)
    end
    return price
  end

  def local_status
    status_list = %W(draft open reserve rent close)
    local = [I18n.t('house_status_draft'), I18n.t('house_status_open'), I18n.t('house_status_reserve'), I18n.t('house_status_rent'), I18n.t('house_status_close')]
    h = Hash[*status_list.zip(local).flatten]
    return h[status]
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
