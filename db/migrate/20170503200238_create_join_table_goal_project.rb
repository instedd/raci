class CreateJoinTableGoalProject < ActiveRecord::Migration[5.0]
  def change
    create_table :project_goals do |t|
      t.references :project, foreign_key: true
      t.integer :goal

      t.timestamps
    end

    add_index :project_goals, :goal
  end
end
