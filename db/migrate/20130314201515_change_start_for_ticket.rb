class ChangeStartForTicket < ActiveRecord::Migration
  def up
    change_column :tickets, :start, :date
    add_column :tickets, :competition_id, :integer
    add_index :tickets, :competition_id
  end

  def down
    change_column :tickets, :start, :datetime
    remove_column :tickets, :competition_id
  end
end
