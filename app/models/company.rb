class Company < ApplicationRecord
  has_one :email_domain, as: :domainable
  has_one :address, as: :addressable
  has_many :prices
  has_many :delivery_times
  has_many :vehicles
  validates :corporate_name, :trading_name, :registration_number, presence: true
  validates :corporate_name, :trading_name, :registration_number, uniqueness: true
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :email_domain
  enum status: { Inactive: 0, Active: 1 }
end
