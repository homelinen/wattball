class CreateHurdlePlayers < ActiveRecord::Migration
  def change
    create_table :hurdle_players do |t|
      t.references :user
      t.date :dob
      t.integer :phone_number
      t.string :nationality
      t.integer :previous_time
      t.string :sex

      t.timestamps
    end
    add_index :hurdle_players, :user_id
  end
end
