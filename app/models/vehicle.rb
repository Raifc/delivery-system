class Vehicle < ApplicationRecord
  belongs_to :company
  validates :year, :load_capacity, numericality: true
  validates :license_plate, :brand, :model, :year, :load_capacity, presence: true
  validates :license_plate, uniqueness: true
end
