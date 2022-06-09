class DeliveryTime < ApplicationRecord
  belongs_to :company
  validates :min_distance, :max_distance, :business_days, numericality: true
  validates :min_distance, :max_distance, :business_days, comparison: { greater_than: 0 }, presence: true
  before_validation :distance_validation
  before_validation :distance_range_exists

  private

  def distance_validation
    return unless min_distance && max_distance

    errors.add(:max_distance, 'deve ser maior que a distância mínima') if min_distance >= max_distance
  end

  def distance_range_exists
    return unless company

    @error_message = 'já registrada!'
    company.delivery_times.each do |delivery_time|
      next if delivery_time == self

      range = (delivery_time.min_distance..delivery_time.max_distance)
      errors.add(:min_distance, @error_message) if range.include? min_distance
      errors.add(:max_distance, @error_message) if range.include? max_distance
    end
  end

end

