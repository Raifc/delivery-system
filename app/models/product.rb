class Product < ApplicationRecord
  has_many :service_orders
  validates :code, :height, :width, :weight, :depth, presence: true
  validates :code, uniqueness: true
  before_save :calculate_volume

  private

  def calculate_volume
    self.volume = height * width * depth
  end

end
