class DeliveryTime < ApplicationRecord
  belongs_to :company
  validates :min_distance, :max_distance, :business_days, presence: true
  before_validation :distance_validation
  before_validation :negative_for_min_distance
  before_validation :negative_for_max_distance
  before_validation :negative_for_business_days

  private

  def negative_for_min_distance
    return unless min_distance

    errors.add(:min_distance, 'deve ser positiva') if min_distance <= 0
  end

  def negative_for_max_distance
    return unless max_distance

    errors.add(:max_distance, 'deve ser positiva') if max_distance <= 0
  end

  def negative_for_business_days
    return unless business_days

    errors.add(:business_days, 'deve ser positivo') if business_days <= 0
  end

  def distance_validation
    return unless min_distance && max_distance

    errors.add(:max_distance, 'deve ser maior que a distância mínima') if min_distance >= max_distance
  end
end
