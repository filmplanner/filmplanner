class CreateSuggestions < ActiveRecord::Migration[5.2]
  def change
    create_table :suggestions do |t|
      t.string :key
      t.string :show_key
      t.string :movie_key
      t.string :theater_key
      t.date :date
      t.datetime :start_at
      t.datetime :end_at
      t.integer :wait_time
      t.timestamps
    end
  end
end
