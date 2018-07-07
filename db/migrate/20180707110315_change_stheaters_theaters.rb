class ChangeStheatersTheaters < ActiveRecord::Migration[5.2]
  def change
    rename_column :suggestions, :stheaters_amount, :theaters_amount
  end
end
