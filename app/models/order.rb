class Order < ActiveRecord::Base
  belongs_to :house
  belongs_to :user
  belongs_to :price

  validates :from, :to, presence: true

  def local_status
    status = %W(wait execution finish cancel)
    local = %W(t('order_status_wait') t('order_status_execution') t('finish') t('cancel'))
    h = Array.new(4)
    status.each {|s| h << s.intern}
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
