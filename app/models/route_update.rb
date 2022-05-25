class RouteUpdate < ApplicationRecord
  belongs_to :service_order
  validates :city, :service_order_id, :time, presence: true
end
