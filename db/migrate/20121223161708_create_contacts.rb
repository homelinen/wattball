class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :line1
      t.string :line2
      t.string :city
      t.string :country
      t.string :postcode

      t.timestamps
    end
  end
end
