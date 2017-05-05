class AddLogoToOrganizations < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :logo, :string
  end
end
