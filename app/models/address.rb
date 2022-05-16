class Address < ApplicationRecord
  has_one :company
  validates :full_address, :city, :state, presence: true
end
