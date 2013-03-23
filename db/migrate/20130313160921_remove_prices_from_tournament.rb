class RemovePricesFromTournament < ActiveRecord::Migration
  def up
    remove_column :tournaments, :adult_ticket_price, :concession_ticket_price

    add_column :tournaments, :competition_id, :integer

    add_index :tournaments, :competition_id
  end

  def down
    add_column :tournaments, :adult_ticket_price, :decimal, :precision => 2
    add_column :tournaments, :concession_ticket_price, :decimal, :precision => 2

    remove_column :tournaments, :competition_id
  end
end
