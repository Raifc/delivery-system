class Price < ApplicationRecord
  belongs_to :company
  validates :min_volume, :max_volume, :min_weight, :max_weight, :km_value, presence: true
end
