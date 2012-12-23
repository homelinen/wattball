class CreateAthletes < ActiveRecord::Migration
  def change
    create_table :athletes do |t|
      t.references :user
      t.date :dateOfBirth
      t.integer :phoneNumber
      t.string :nationality
      t.references :contact
      t.string :type
      t.integer :previousTime
      t.string :organisationTag
      t.references :manager

      t.timestamps
    end
    add_index :athletes, :user_id
    add_index :athletes, :contact_id
    add_index :athletes, :manager_id
  end
end
