class ChangeEventRelationForScore < ActiveRecord::Migration
  def change
    rename_column :scores, :event_id, :wattball_match_id
    rename_index :scores, :event_id, :wattball_match_id
  end
end
