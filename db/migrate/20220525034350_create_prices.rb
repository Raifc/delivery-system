class CreatePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :prices do |t|
      t.references :company, null: false, foreign_key: true
      t.float :min_volume
      t.float :max_volume
      t.float :min_weight
      t.float :max_weight
      t.decimal :km_value

      t.timestamps
    end
  end
end
