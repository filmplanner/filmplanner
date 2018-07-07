class AddShowsAmountToSuggestions < ActiveRecord::Migration[5.2]
  def change
    add_column :suggestions, :shows_amount, :integer
  end
end
