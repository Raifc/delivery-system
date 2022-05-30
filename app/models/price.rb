class Price < ApplicationRecord
  belongs_to :company
  validates :min_volume, :max_volume, :min_weight, :max_weight, :km_value, presence: true
  before_validation :volume_validation
  before_validation :weight_validation
  before_validation :negative_for_min_volume
  before_validation :negative_for_max_volume
  before_validation :negative_for_min_weight
  before_validation :negative_for_max_weight

  private

  def negative_for_min_volume
    return unless min_volume

    errors.add(:min_volume, 'deve ser positivo') if min_volume <= 0
  end

  def negative_for_max_volume
    return unless max_volume

    errors.add(:max_volume, 'deve ser positivo') if max_volume <= 0
  end

  def negative_for_min_weight
    return unless min_weight

    errors.add(:min_weight, 'deve ser positivo') if min_weight <= 0
  end

  def negative_for_max_weight
    return unless max_weight

    errors.add(:max_weight, 'deve ser positivo') if max_weight <= 0
  end

  def volume_validation
    return unless max_volume && min_volume

    errors.add(:max_volume, 'deve ser maior que o volume mínimo') if min_volume >= max_volume
  end

  def weight_validation
    return unless min_weight && max_weight

    errors.add(:max_weight, 'deve ser maior que o peso mínimo') if min_weight >= max_weight
  end

end
