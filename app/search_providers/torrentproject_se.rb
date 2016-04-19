class TorrentprojectSe
  require 'httparty'
  require 'digest'
  URL = "https://torrentproject.se/"
  TYPE = :json

  cattr_accessor :cache
  @@cache = {}.with_indifferent_access
  # search for a torrent

  attr_reader :results, :total

  # returns a instance of self with a parsed result
  def initialize(json_object)
    @results = []
    @total = 0
    convert_results(json_object)
  end

  def self.clear_cache!
    @@cache = {}.with_indifferent_access
  end

  def self.search(term: nil)
    sha256 = Digest::SHA256.hexdigest(term)
    return cache[sha256] if cache.key?(sha256)
    url = "#{URL}?s=#{term}&out=json&num=100&orderby=seeders"
    response = HTTParty.get(url)
    
    cache[sha256] = self.new(response.parsed_response)
  end

  private

  def convert_results(json_object)
    @total = json_object.delete('total_found')
    json_object.keys.each do |key|
      r = Result.new
      json_object[key].keys.each do |field|
        r.send("#{field}=", json_object[key][field])
      end
      results << r
    end
  end

  def rank_result(res: {})
    
  end
  
end