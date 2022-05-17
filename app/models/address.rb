class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true, optional: true
  validates :full_address, :city, :state, presence: true
end
