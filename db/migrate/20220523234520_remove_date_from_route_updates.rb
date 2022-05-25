class RemoveDateFromRouteUpdates < ActiveRecord::Migration[7.0]
  def change
    remove_column :route_updates, :date
  end
end
