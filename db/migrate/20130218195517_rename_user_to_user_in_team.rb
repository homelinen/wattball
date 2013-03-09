class RenameUserToUserInTeam < ActiveRecord::Migration
  def change

    remove_index :teams, :User_id

    rename_column :teams, :User_id, :user_id

    add_index :teams, :user_id
  end
end
