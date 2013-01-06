class CreateWattballMatches < ActiveRecord::Migration
  def change
    create_table :wattball_matches do |t|
      t.references :event
      t.integer :team1_id
      t.integer :team2_id

      t.timestamps
    end
    add_index :wattball_matches, :event_id
    add_index :wattball_matches, :team1_id
    add_index :wattball_matches, :team2_id
  end
end
