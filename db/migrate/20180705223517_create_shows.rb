class CreateShows < ActiveRecord::Migration[5.2]
  def change
    create_table :shows do |t|
      t.references :theater
      t.references :movie
      t.date :date
      t.datetime :start
      t.datetime :end
      t.string :version
      t.string :url
    end
  end
end
