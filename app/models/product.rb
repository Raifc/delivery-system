class Product < ApplicationRecord
  validates :code, :width, :height, :weight, :depth, presence: true
  validates :code, uniqueness: true
end
