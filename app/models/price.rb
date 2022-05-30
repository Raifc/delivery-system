class Price < ApplicationRecord
  belongs_to :company
  validates :min_volume, :max_volume, :min_weight, :max_weight, :km_value, presence: true
  before_validation :volume_validation
  before_validation :weight_validation

  private

  def volume_validation
    return unless max_volume && min_volume

    errors.add(:max_volume, 'deve ser maior que o volume mínimo') if min_volume >= max_volume
  end

  def weight_validation
    return unless min_weight && max_weight

    errors.add(:max_weight, 'deve ser maior que o peso mínimo') if min_weight >= max_weight
  end

end
