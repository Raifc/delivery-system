class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :code
      t.decimal :height
      t.decimal :width
      t.decimal :depth
      t.decimal :weight

      t.timestamps
    end
  end
end
