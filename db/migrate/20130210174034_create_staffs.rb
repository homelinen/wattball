class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.references :user
      t.references :address
      t.string :telephone
      t.string :address

      t.timestamps
    end
    add_index :staffs, :user_id
    add_index :staffs, :address_id
  end
end
