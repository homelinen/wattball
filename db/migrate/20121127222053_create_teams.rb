class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.references :User
      t.string :teamName
      t.attachment :badge

      t.timestamps
    end
    add_index :teams, :User_id
  end
end
