class DeliveryTime < ApplicationRecord
  belongs_to :company
  validates :min_distance, :max_distance, :business_days, presence: true
  before_validation :distance_validation

  private

  def distance_validation
    return unless min_distance && max_distance

    errors.add(:max_distance, 'deve ser maior que a distância mínima') if min_distance >= max_distance
  end
end
