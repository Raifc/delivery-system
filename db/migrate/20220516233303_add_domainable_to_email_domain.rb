class AddDomainableToEmailDomain < ActiveRecord::Migration[7.0]
  def change
    add_reference :email_domains, :domainable, polymorphic: true
  end
end
