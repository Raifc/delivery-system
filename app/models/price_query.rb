class PriceQuery < ApplicationRecord
  validates :height, :width, :weight, :depth, :distance, numericality: true
  validates :height, :width, :weight, :depth, :distance, presence: true
  before_save :set_volume

  private

  def set_volume
    self.volume = height * width * depth
  end
end
