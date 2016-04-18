class AddPathToSerie < ActiveRecord::Migration
  def change
    add_column :series, :path, :string
  end
end
