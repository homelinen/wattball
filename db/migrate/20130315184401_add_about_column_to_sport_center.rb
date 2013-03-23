class AddAboutColumnToSportCenter < ActiveRecord::Migration
  def change
    add_column :sport_centers, :about, :text
  end
end
