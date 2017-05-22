class CreateLocationsAndPopulations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :name

      t.timestamps
    end

    create_table :populations do |t|
      t.string :name

      t.timestamps
    end
  end
end
