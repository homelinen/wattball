class RemoveAddressFromStaff < ActiveRecord::Migration
  def up
    remove_column :staffs, :address
  end

  def down
    add_column :staffs, :address, :string
  end
end
