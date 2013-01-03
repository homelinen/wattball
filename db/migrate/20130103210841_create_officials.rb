class CreateOfficials < ActiveRecord::Migration
  def change
    create_table :officials do |t|
      t.references :user
      t.integer :phone

      t.timestamps
    end
    add_index :officials, :user_id
  end
end
