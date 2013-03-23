class AddDetailsToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :phone_number, :string, :default => "000000"
    add_column :teams, :website, :string
  end
end
