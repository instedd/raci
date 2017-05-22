class CreateJoinTableProjectLocation < ActiveRecord::Migration[5.0]
  def change
    create_join_table :projects, :locations do |t|
      t.index [:project_id, :location_id]
    end
  end
end
