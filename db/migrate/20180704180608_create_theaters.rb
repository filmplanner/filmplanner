class CreateTheaters < ActiveRecord::Migration[5.2]
  def change
    create_table :theaters do |t|
      t.string :name
      t.string :city
      t.string :image
      t.string :path
    end
  end
end
