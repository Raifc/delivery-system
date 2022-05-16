class Company < ApplicationRecord
  belongs_to :address
  belongs_to :email_domain
  validates :corporate_name, :trading_name, :registration_number, presence: true
  validates :corporate_name, :trading_name, :registration_number, uniqueness: true
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :email_domain
  enum status: { inactive: 0, active: 1 }
end
