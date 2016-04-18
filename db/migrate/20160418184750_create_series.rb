class CreateSeries < ActiveRecord::Migration
  def change
    create_table :series do |t|
      t.text :actors
      t.string :airs_dayofweek
      t.string :airs_time
      t.string :content_raiting
      t.date :first_aired
      t.string :genre
      t.string :imdb_id
      t.string :language
      t.string :network
      t.integer :network_id
      t.text :overview
      t.string :rating
      t.integer :raring_count
      t.string :runtime
      t.integer :series_id
      t.string :series_name
      t.string :status
      t.date :added
      t.string :added_by
      t.string :banner
      t.string :fanart
      t.datetime :last_updated
      t.string :poster
      t.string :zap2it_id
      t.string :name

      t.timestamps null: false
    end
  end
end
