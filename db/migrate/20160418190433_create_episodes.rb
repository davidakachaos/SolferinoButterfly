class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :name
      t.belongs_to :serie, index: true
      t.integer :state
      t.integer :number
      t.integer :tvdb_id

      t.timestamps null: false
    end
  end
end
