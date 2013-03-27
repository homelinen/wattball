class RenameUserToUserInTeam < ActiveRecord::Migration
  def change
    rename_column :teams, :User_id, :user_id
    rename_index :teams, :User_id, :user_id
  end
end
