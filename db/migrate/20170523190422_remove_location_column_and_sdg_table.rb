class RemoveLocationColumnAndSdgTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :projects, :location

    drop_table :sustainable_development_goals
  end
end
