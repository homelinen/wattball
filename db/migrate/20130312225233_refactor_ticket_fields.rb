class RefactorTicketFields < ActiveRecord::Migration
  def up
    remove_column :tickets, :end, :concess_number, :adults_number, :tournament_id
    rename_column :tickets, :dsc, :status
    
    add_column :tickets, :denomination, :string
  end

  def down
    add_column :tickets, :end, :date
    add_column :tickets, :concess_number, :integer
    add_column :tickets, :adults_number, :interger

    add_column :tickets, :tournament_id, :interger
    add_index :tickets, :tournament_id

    rename_column :tickets, :description, :dsc

    remove_column :tickets, :denomination
  end
end
