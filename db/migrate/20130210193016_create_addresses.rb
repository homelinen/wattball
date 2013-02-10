class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :line1
      t.string :line2
      t.string :town
      t.string :city
      t.string :postcode

      t.timestamps
    end
  end
end
