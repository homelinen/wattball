class SimplifyTicketsAgain < ActiveRecord::Migration
  def up
    remove_column :tickets, :denomination
    add_column :tickets, :adults, :integer
    add_column :tickets, :concessions, :integer
  end

  def down
    add_column :tickets, :denomination, :string
    remove_column :tickets, :adults, :concessions
  end
end
