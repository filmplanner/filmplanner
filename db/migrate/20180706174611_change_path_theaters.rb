class ChangePathTheaters < ActiveRecord::Migration[5.2]
  def change
    rename_column :theaters, :path, :url
  end
end
