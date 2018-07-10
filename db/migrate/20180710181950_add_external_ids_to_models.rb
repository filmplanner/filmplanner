class AddExternalIdsToModels < ActiveRecord::Migration[5.2]
  def change
    add_column :theaters, :external_id, :integer
    add_column :movies, :external_id, :integer
    add_column :movies, :chain, :string
  end
end
