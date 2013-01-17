class CreateHurdleMatches < ActiveRecord::Migration
  def change
    create_table :hurdle_matches do |t|
      t.references :event

      t.timestamps
    end
    add_index :hurdle_matches, :event_id
  end
end
