class ChangeTimeToIntForHurdleTime < ActiveRecord::Migration
  def up
    change_column :hurdle_times, :time, :int
  end

  def down

    change_column :hurdle_times, :time, :time
  end
end
