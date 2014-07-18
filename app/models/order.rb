class Order < ActiveRecord::Base
  belongs_to :house
  belongs_to :user

  validates :from, :to, presence: true

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
      transition :wait => :cancel
    end
  end
end
