class RouteUpdate < ApplicationRecord
  belongs_to :service_order
  validates :city, :service_order_id, :time, presence: true
  before_validation :date_validation

  private

  def date_validation
    return unless time

    errors.add(:time, 'devem ser maiores ou iguais a atual') if Time.now >= time
  end

end
