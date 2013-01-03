class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name
      t.date :startDate
      t.date :endDate
      t.references :sport
      t.integer :max_competitors
      t.integer :adult_ticket_price
      t.integer :concession_ticket_price

      t.timestamps
    end
    add_index :tournaments, :sport_id
  end
end
