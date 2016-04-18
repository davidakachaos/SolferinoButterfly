class Episode < ActiveRecord::Base
  belongs_to :season, inverse_of: :episodes
  has_one :serie, through: :season, inverse_of: :episodes

  enum state: {
  	initial: 0,
  	searching: 1,
  	downloading: 2,
  	checking: 3,
  	low_quality: 4,
  	done: 5,
  	archived: 6
  }
end
