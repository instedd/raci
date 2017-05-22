class CreateJoinTableProjectPopulation < ActiveRecord::Migration[5.0]
  def change
    create_join_table :projects, :populations do |t|
      t.index [:project_id, :population_id]
    end
  end
end
