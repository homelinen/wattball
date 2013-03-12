class RemoveDateFieldFromEvent < ActiveRecord::Migration
  def up
    remove_column :events, :start
    remove_column :events, :end

    remove_column :events, :date

    add_column :events, :start, :datetime
  end

  def down
    add_column :events, :date, :date

    add_column :events, :start, :time
    add_column :events, :end, :time
  end
end
