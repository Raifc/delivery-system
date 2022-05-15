class CreateEmailDomains < ActiveRecord::Migration[7.0]
  def change
    create_table :email_domains do |t|
      t.string :domain

      t.timestamps
    end
  end
end
