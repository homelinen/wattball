class AddTournamentColumnToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :tournament_id, :integer

    add_index :teams, :tournament_id
  end
end
