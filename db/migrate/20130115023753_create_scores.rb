class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.references :wattball_player
      t.references :event
      t.integer :amount

      t.timestamps
    end
    add_index :scores, :wattball_player_id
    add_index :scores, :event_id
  end
end
