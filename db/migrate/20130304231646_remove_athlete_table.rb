class RemoveAthleteTable < ActiveRecord::Migration
  def change
    remove_index :hurdle_times, :athlete_id
  end

  def up
    remove_column :athletes
  end

  def down
    create_table :athletes do |t|
      t.references :user
      t.date :dateOfBirth
      t.integer :phoneNumber
      t.string :nationality
      t.references :contact
      t.string :type
      t.integer :previousTime
      t.string :organisationTag
      t.references :team
      t.string :sex

      t.timestamps
    end
    add_index :athletes, :user_id
    add_index :athletes, :contact_id
    add_index :athletes, :team_id
  end
end
