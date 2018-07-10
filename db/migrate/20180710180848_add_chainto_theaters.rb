class AddChaintoTheaters < ActiveRecord::Migration[5.2]
  def change
    add_column :theaters, :chain, :string
  end
end
