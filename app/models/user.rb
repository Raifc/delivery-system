class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :company, optional: true
  before_validation :set_company
  validate :company_is_valid

  private
  def set_company
    email_domain = email.split('@')[1]
    self.company = Company.find_by(email_domain: email_domain)
  end

  def company_is_valid
    errors.add :email, 'No companies with this email address!' unless company
  end
end
