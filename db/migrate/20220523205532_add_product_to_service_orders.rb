class AddProductToServiceOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :service_orders, :product, null: true, foreign_key: true
  end
end
