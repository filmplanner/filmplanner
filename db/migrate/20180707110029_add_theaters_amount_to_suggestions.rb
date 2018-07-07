class AddTheatersAmountToSuggestions < ActiveRecord::Migration[5.2]
  def change
    add_column :suggestions, :stheaters_amount, :integer
  end
end
