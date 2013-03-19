class RelateTournamentToHurdler < ActiveRecord::Migration
  def change
    add_column :hurdle_players, :tournament_id, :integer
    add_index :hurdle_players, :tournament_id
  end
end
