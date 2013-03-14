class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :name
      t.integer :ticket_limit
      t.decimal :adult_price, :precision => 2
      t.decimal :concession_price, :precision => 2

      t.timestamps
    end
  end
end
