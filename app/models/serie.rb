class Serie < ActiveRecord::Base
  has_many :episodes, through: :seasons, inverse_of: :serie
  has_many :seasons, inverse_of: :serie

  validates :name, presence: true, uniqueness: true

  after_create :get_from_tvdb

  def get_from_tvdb
    serie = TvdbProxy.client.get_series(name).first
    fail "No serie named #{name} found!" unless serie
    Serie.column_names.reject{|f|f == 'id' || f.ends_with?('_at')}.each do |field|
      self.send("#{field}=", serie.send(field)) if serie.respond_to?(field)
    end
    save!
    serie.episodes # Need to call this to deepen the serie
    serie.seasons.each do |nr, episodes|
      s = self.seasons.where(number: nr).first_or_create
      # puts "Episodes: #{episodes.inspect}"
      episodes.each do |index, ep|
        epi = s.episodes.where(tvdb_id: ep.id).first_or_create
        epi.name = ep.name
        epi.save!
      end
    end
  end

  def check_path
    fail 'No path given' if path.empty?
    fail 'Path doesn\'t exist!' unless File.exists?(path)
    tv_serie = TvdbProxy.serie self.series_id
    files = Dir.glob("#{path}/**/*.{avi,mkv,m4v,mp4}")
    puts "Found #{files.size} files."
    files.each do |file|
      epi = tv_serie.match_episode file
      if epi
        puts "We found a episode!!"
        es = self.episodes.where(tvdb_id: epi.id).first
        es.done!
      end
    end
  end

end
