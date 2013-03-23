class ChangeOrgTagFromPlayerToTeam < ActiveRecord::Migration
  def up
    remove_column :wattball_players, :org_tag
    add_column :teams, :org_tag, :string, :default => ""
  end

  def down
    add_column :wattball_players, :org_tag, :string
    remove_column :teams, :org_tag
  end
end
