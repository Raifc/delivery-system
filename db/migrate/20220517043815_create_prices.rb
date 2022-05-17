class CreatePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :prices do |t|
      t.decimal :min_volume
      t.decimal :max_volume
      t.decimal :min_weight
      t.decimal :max_weight
      t.decimal :km_value
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
