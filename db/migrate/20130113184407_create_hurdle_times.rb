class CreateHurdleTimes < ActiveRecord::Migration
  def change
    create_table :hurdle_times do |t|
      t.references :athlete
      t.references :hurdle_match
      t.time :time
      t.integer :lane

      t.timestamps
    end
    add_index :hurdle_times, :athlete_id
    add_index :hurdle_times, :hurdle_match_id
  end
end
