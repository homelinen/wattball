class CreateSportCenters < ActiveRecord::Migration
  def change
    create_table :sport_centers do |t|
      t.string :name
      t.string :email
      t.string :address_line1
      t.string :address_line2
      t.string :address_town
      t.string :address_city
      t.string :address_postcode
      t.references :contact

      t.timestamps
    end
    add_index :sport_centers, :contact_id
  end
end
