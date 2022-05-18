class DeliveryTime < ApplicationRecord
  belongs_to :company
  validates :min_distance, :max_distance, :business_days, presence: true
end
