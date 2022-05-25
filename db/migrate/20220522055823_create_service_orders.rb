class CreateServiceOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :service_orders do |t|
      t.references :company, null: false, foreign_key: true
      t.integer :status
      t.integer :origin_address_id
      t.integer :destination_address_id
      t.string :code

      t.timestamps
    end
  end
end
