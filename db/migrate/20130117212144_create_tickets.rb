class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.datetime :start
      t.datetime :end
      t.references :user
      t.references :tournament
      t.string :dsc
      t.integer :adults_number
      t.integer :concess_number

      t.timestamps
    end
    add_index :tickets, :user_id
    add_index :tickets, :tournament_id
  end
end
