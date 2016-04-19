Result = Struct.new(:title, :category, :seeds, :leechs, :torrent_size, :torrent_hash) do
  include Comparable
  def <=>(other)
    other.seeds <=> seeds
  end

  def dead?
    seeds == 0
  end
  
  def mb
    torrent_size / 1048576.0
  end

  def gb
    mb / 1024.0
  end

  def season?
    cetainty = 0.0
    cetainty += 0.2 if gb > 4
    cetainty += 1.5 if title =~ /season.+\d{1,2}.+complete/i
    cetainty += 0.2 if title =~ /season.+complete/i

    cetainty > 1.5
  end
  
end