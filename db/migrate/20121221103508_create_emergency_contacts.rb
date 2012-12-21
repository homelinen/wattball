class CreateEmergencyContacts < ActiveRecord::Migration
  def change
    create_table :emergency_contacts do |t|
      t.string :name
      t.references :address

      t.timestamps
    end
    add_index :emergency_contacts, :address_id
  end
end
