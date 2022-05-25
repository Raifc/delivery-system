class AddVolumeToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :volume, :integer
  end
end
