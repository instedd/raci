class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.references :organization, foreign_key: true
      t.string :location
      t.date :start_date
      t.date :end_date
      t.boolean :published

      t.timestamps
    end
  end
end
