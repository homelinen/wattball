class AddGenderToAthletes < ActiveRecord::Migration
  def change
    add_column :athletes, :sex, :string
  end
end
