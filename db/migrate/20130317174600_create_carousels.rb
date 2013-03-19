class CreateCarousels < ActiveRecord::Migration
  def change
    create_table :carousels do |t|
      t.string :title
      t.text :description
      t.attachment :banner_image

      t.timestamps
    end
  end
end
