class CreateManagers < ActiveRecord::Migration
  def change
    create_table :managers do |t|
      t.string :teamname
      t.references :user

      t.timestamps
    end
  end
end
