class AddCodeToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :code, :string
  end
end
