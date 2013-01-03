class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name
      t.date :startDate
      t.date :endDate
      t.references :sport
      t.integer :max_competitors
      t.decimal :adult_ticket_price, :precision => 2
      t.decimal :concession_ticket_price, :precision => 2

      t.timestamps
    end
    add_index :tournaments, :sport_id
  end
end
