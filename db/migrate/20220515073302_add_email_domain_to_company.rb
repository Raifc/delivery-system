class AddEmailDomainToCompany < ActiveRecord::Migration[7.0]
  def change
    add_reference :companies, :email_domain, null: false, foreign_key: true
  end
end
