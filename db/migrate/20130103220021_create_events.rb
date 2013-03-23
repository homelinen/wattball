class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.time :start
      t.time :end
      t.date :date
      t.string :status
      t.references :official
      t.references :tournament
      t.integer :round

      t.timestamps
    end
    add_index :events, :official_id
    add_index :events, :tournament_id
  end
end
