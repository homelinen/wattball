class AddRoundColumnToEvent < ActiveRecord::Migration
  def change
    add_column :events, :round, :integer
  end
end
