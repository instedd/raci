class CreateSustainableDevelopmentGoals < ActiveRecord::Migration[5.0]
  def change
    create_table :sustainable_development_goals do |t|
      t.string :name
      t.integer :number
      t.string :color

      t.timestamps
    end
  end
end
