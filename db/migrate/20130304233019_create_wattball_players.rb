class CreateWattballPlayers < ActiveRecord::Migration
  def change
    create_table :wattball_players do |t|
      t.references :user
      t.references :team
      t.references :contact
      t.string :org_tag
      t.date :dob
      t.integer :phone_number

      t.timestamps
    end
    add_index :wattball_players, :user_id
    add_index :wattball_players, :team_id
    add_index :wattball_players, :contact_id
  end
end
