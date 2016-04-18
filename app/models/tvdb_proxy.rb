class TvdbProxy

  # cattr_reader :client

	def initialize
		@@client = TTVDB::Client.new(api_key: THE_TVDB_KEY)
	end

  def self.serie tvdb_id
    client.get_series_by_id tvdb_id
  end

  def self.client
    @@client ||= TTVDB::Client.new(api_key: THE_TVDB_KEY)
  end
end