class AddVehicleToServiceOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :service_orders, :vehicle_id, :integer
  end
end
