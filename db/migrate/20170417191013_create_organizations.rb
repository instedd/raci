class CreateOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :organizations do |t|
      t.boolean :legally_formed
      t.string :email
      t.string :telephone_number
      t.string :name
      t.string :twitter
      t.string :facebook
      t.boolean :accepted
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
