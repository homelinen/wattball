class RenameAthleteToHurdlePlayerForHurdleTimes < ActiveRecord::Migration
  def change
    rename_column :hurdle_times, :athlete_id, :hurdle_player_id
    add_index :hurdle_times, :hurdle_player_id
  end
end
