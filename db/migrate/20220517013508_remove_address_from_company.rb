class RemoveAddressFromCompany < ActiveRecord::Migration[7.0]
  def change
    remove_reference :companies, :address, null: false, foreign_key: true
  end
end
