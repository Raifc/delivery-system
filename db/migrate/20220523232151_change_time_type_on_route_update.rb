class ChangeTimeTypeOnRouteUpdate < ActiveRecord::Migration[7.0]
  def change
    change_column :route_updates, :time, :datetime
  end
end
