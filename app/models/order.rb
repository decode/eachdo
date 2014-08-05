class Order < ActiveRecord::Base
  belongs_to :house
  belongs_to :user
  belongs_to :price

  has_one :feedback

  validates :from, :to, presence: true

  self.per_page = 3 

  def local_status
    status_list = %W(wait execution finish cancel)
    local = [I18n.t('order_status_wait'), I18n.t('order_status_execution'), I18n.t('order_status_finish'), I18n.t('order_status_cancel')]
    h = Hash[*status_list.zip(local).flatten]
    return h[status]
  end

  # 订单四种状态:
  # * 用户预定 wait
  # * 商户确认 execution
  # * 完成订单 finish
  # * 取消订单 cancel
  state_machine :status, :initial => :open do
    event :book do
      transition :open => :wait
    end
    event :confirm do
      transition :wait => :execution
    end
    event :pay do
      transition :execution => :finish
    end
    event :cancel do
      transition [:wait, :execution] => :cancel
    end
  end
end
