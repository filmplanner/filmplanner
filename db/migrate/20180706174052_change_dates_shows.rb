class ChangeDatesShows < ActiveRecord::Migration[5.2]
  def change
    rename_column :shows, :start, :start_at
    rename_column :shows, :end, :end_at

    add_column :shows, :created_at, :datetime, null: false
    add_column :shows, :updated_at, :datetime, null: false

    add_column :movies, :created_at, :datetime, null: false
    add_column :movies, :updated_at, :datetime, null: false

    add_column :theaters, :created_at, :datetime, null: false
    add_column :theaters, :updated_at, :datetime, null: false
  end
end
