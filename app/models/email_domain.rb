class EmailDomain < ApplicationRecord
  validates :domain, presence: true
  has_one :company
end
