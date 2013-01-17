class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.references :sport
      t.string :name
      t.references :sport_center
      t.integer :capacity

      t.timestamps
    end
    add_index :venues, :sport_id
    add_index :venues, :sport_center_id
  end
end
