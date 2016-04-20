class Quality
  NONE = 0
  SDTV = 1
  SDDVD = 1 << 1 # 2
  HDTV = 1 << 2  # 4
  RAWHDTV = 1 << 3 # 8  -- 720p/1080i mpeg2 (trollhd releases)
  FULLHDTV = 1 << 4 # 16 -- 1080p HDTV (QCF releases)
  HDWEBDL = 1 << 5 # 32
  FULLHDWEBDL = 1 << 6 # 64 -- 1080p web-dl
  HDBLURAY = 1 << 7 # 128
  FULLHDBLURAY = 1 << 8 # 256
  ANYHDTV = HDTV | FULLHDTV # 20
  ANYWEBDL = HDWEBDL | FULLHDWEBDL # 96
  ANYBLURAY = HDBLURAY | FULLHDBLURAY # 384
  # put these bits at the other end of the spectrum,
  # far enough out that they shouldn't interfere
  UNKNOWN = 1 << 15 # 32768

  STRINGS = {
    NONE: "N/A",
    UNKNOWN: "Unknown",
    SDTV: "SDTV",
    SDDVD: "SD DVD",
    HDTV: "720p HDTV",
    RAWHDTV: "RawHD",
    FULLHDTV: "1080p HDTV",
    HDWEBDL: "720p WEB-DL",
    FULLHDWEBDL: "1080p WEB-DL",
    HDBLURAY: "720p BluRay",
    FULLHDBLURAY: "1080p BluRay"
  }.freeze
  SCENE_STRINGS = {
    NONE: "N/A",
    UNKNOWN: "Unknown",
    SDTV: "HDTV",
    SDDVD: "",
    HDTV: "720p HDTV",
    RAWHDTV: "1080i HDTV",
    FULLHDTV: "1080p HDTV",
    HDWEBDL: "720p WEB-DL",
    FULLHDWEBDL: "1080p WEB-DL",
    HDBLURAY: "720p BluRay",
    FULLHDBLURAY: "1080p BluRay"
  }.freeze
  COMBINED_STRINGS = {
    ANYHDTV: "HDTV",
    ANYWEBDL: "WEB-DL",
    ANYBLURAY: "BluRay"
  }.freeze
  CLASS_STRINGS = {
    NONE: "N/A",
    UNKNOWN: "Unknown",
    SDTV: "SDTV",
    SDDVD: "SDDVD",
    HDTV: "HD720p",
    RAWHDTV: "RawHD",
    FULLHDTV: "HD1080p",
    HDWEBDL: "HD720p",
    FULLHDWEBDL: "HD1080p",
    HDBLURAY: "HD720p",
    FULLHDBLURAY: "HD1080p",
    ANYHDTV: "any-hd",
    ANYWEBDL: "any-hd",
    ANYBLURAY: "any-hd"
  }.freeze
  STATUS_PREFIXES = {
    DOWNLOADED: "Downloaded",
    SNATCHED: "Snatched",
    SNATCHED_PROPER: "Snatched (Proper)",
    FAILED: "Failed",
    SNATCHED_BEST: "Snatched (Best)",
    ARCHIVED: "Archived"
  }.freeze

  def scene_quality(name, anime = false)
    return Quality::UNKNOWN if name.empty?

    check_any = -> (regexes) { regexes.map{ |r| r =~ name }.any? }
    check_all = -> (regexes) { regexes.map{ |r| r =~ name }.all? }

    if anime
      dvdOptions = check_any.call([/dvd/i, /dvdrip/i])
      blueRayOptions = check_any.call([/BD/i, /blue?-?ray/i])
      sdOptions = check_any.call([/360p/i, /480p/i, /848x480/i, /XviD/i])
      hdOptions = check_any.call([/720p/i, /1280x720/i, /960x720/i])
      fullHD = check_any.call([/1080p/i, /1920x1080/i])
      # Now let's see what we got...
      if sdOptions && !blueRayOptions && !dvdOptions
        return Quality::SDTV
      elsif dvdOptions
        return Quality::SDDVD
      elsif hdOptions && !blueRayOptions && !fullHD
        return Quality::HDTV
      elsif fullHD && !blueRayOptions && !hdOptions
        return Quality::FULLHDTV
      elsif hdOptions && !blueRayOptions && !fullHD
        return Quality::HDWEBDL
      elsif blueRayOptions && hdOptions && !fullHD
        return Quality::HDBLURAY
      elsif blueRayOptions && fullHD && !hdOptions
        return Quality::FULLHDBLURAY
      end
    end
    # Not a anime!
    if check_all([/480p|web.?dl|web(rip|mux|hd)|[sph]d.?tv|dsr|tv(rip|mux)|satrip/i, /xvid|divx|[xh].?26[45]/i]) && !check_all([/(720|1080)[pi]/i]) && !check_any([/hr.ws.pdtv.[xh].?26[45]/i])
      return Quality::SDTV
    elsif check_all([/dvd(rip|mux)|b[rd](rip|mux)|blue?-?ray/i, /xvid|divx|[xh].?26[45]/i]) && !check_all([/(720|1080)[pi]/i]) && !check_any([/hr.ws.pdtv.[xh].?26[45]/i])
      return Quality::SDDVD
    elsif check_all([/720p/i, /hd.?tv/i, /[xh].?26[45]/i]) || check_any([/hr.ws.pdtv.[xh].?26[45]/i]) && !check_all([/1080[pi]/i])
      return Quality::HDTV
    elsif check_all([/720p|1080i/i, /hd.?tv/i, /mpeg-?2/i]) || checkName([/1080[pi].hdtv/i, /h.?26[45]/i])
      return Quality::RAWHDTV
    elsif check_all([/1080p/i, /hd.?tv/i, /[xh].?26[45]/i])
      return Quality::FULLHDTV
    elsif check_all([/720p/i, /web.?dl|web(rip|mux|hd)/i]) || checkName([/720p/i, /itunes/i, /[xh].?26[45]/i])
      return Quality::HDWEBDL
    elsif check_all([/1080p/i, /web.?dl|web(rip|mux|hd)/i]) || checkName([/1080p/i, /itunes/i, /[xh].?26[45]/i])
      return Quality::FULLHDWEBDL
    elsif check_all([/720p/i, /blue?-?ray|hddvd|b[rd](rip|mux)/i, /[xh].?26[45]/i])
      return Quality::HDBLURAY
    elsif check_all([/1080p/i, /blue?-?ray|hddvd|b[rd](rip|mux)/i, /[xh].?26[45]/i])
      return Quality::FULLHDBLURAY
    end
  end
end
