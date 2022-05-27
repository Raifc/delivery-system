class Company < ApplicationRecord
  has_one :address, as: :addressable
  has_many :prices
  has_many :delivery_times
  has_many :vehicles
  has_many :service_orders
  has_many :users

  validates :email_domain, format: { with: /\A[a-z0-9]+\.[a-z]+(.[a-z]+)?\z/i }
  validates :corporate_name, :trading_name, :registration_number, :address, presence: true
  validates :corporate_name, :registration_number, uniqueness: true
  accepts_nested_attributes_for :address

  enum status: { Inativa: 0, Ativa: 1 }
end
