class AddDefaultToServiceOrderStatus < ActiveRecord::Migration[7.0]
  def change
    change_column_default :service_orders, :status, 0
  end
end
