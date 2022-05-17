class EmailDomain < ApplicationRecord
  validates :domain, presence: true
  belongs_to :domainable, polymorphic: true, optional: true
end
