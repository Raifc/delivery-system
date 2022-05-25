class CreateRouteUpdates < ActiveRecord::Migration[7.0]
  def change
    create_table :route_updates do |t|
      t.references :service_order, null: false, foreign_key: true
      t.string :city
      t.time :time
      t.date :date

      t.timestamps
    end
  end
end
