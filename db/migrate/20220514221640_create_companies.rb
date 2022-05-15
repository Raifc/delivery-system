class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :corporate_name
      t.string :trading_name
      t.string :registration_number

      t.timestamps
    end
  end
end
