class ServiceOrder < ApplicationRecord
  attr_accessor :destination_address, :origin_address

  validates :product_id, :origin_address_id, :destination_address_id, presence: true
  belongs_to :product
  belongs_to :company
  belongs_to :origin_address, class_name: :Address, foreign_key: :origin_address_id, optional: true
  belongs_to :destination_address, class_name: :Address, foreign_key: :destination_address_id, optional: true
  enum status: { Pendente: 0, Aceita: 5, Recusada: 10, Finalizada: 15 }
  before_create :generate_code
  has_many :addresses
  has_many :route_updates

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(15).upcase
  end

end
