class Product < ApplicationRecord
  #has_many :service_order_products
  has_many :service_orders
  validates :height, :width, :weight, :depth, numericality: true
  validates :code, :height, :width, :weight, :depth, presence: true
  validates :code, uniqueness: true
  before_save :calculate_volume

  private

  def calculate_volume
    self.volume = height * width * depth
  end

end
