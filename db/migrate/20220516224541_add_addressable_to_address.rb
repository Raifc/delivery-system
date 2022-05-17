class AddAddressableToAddress < ActiveRecord::Migration[7.0]
  def change
    add_reference :addresses, :addressable, polymorphic: true
  end
end
