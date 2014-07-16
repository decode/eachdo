class Order < ActiveRecord::Base
  belongs_to :house
  belongs_to :user


  validates :from, :to, :price, :is_oneself, presence: true
end
