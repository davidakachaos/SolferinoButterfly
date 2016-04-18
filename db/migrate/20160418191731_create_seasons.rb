class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.belongs_to :serie, index: true
      t.integer :state
      t.integer :number
      t.integer :tvdb_id

      t.timestamps null: false
    end

    remove_index :episodes, :serie_id
    rename_column :episodes, :serie_id, :season_id
    add_index :episodes, :season_id
  end
end
