class DeleteAdress < ActiveRecord::Migration[7.0]
  def change
    drop_table :adresses
  end
end
