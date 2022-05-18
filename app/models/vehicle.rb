class Vehicle < ApplicationRecord
  belongs_to :company
  validates :license_plate, :brand, :model, :year, :load_capacity, presence: true
  validates :license_plate, uniqueness: true
end
