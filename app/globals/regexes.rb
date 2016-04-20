class Regexes
    NORMAL = {
    standard_repeat:
     # Show.Name.S01E02.S01E03.Source.Quality.Etc-Group
     # Show Name - S01E02 - S01E03 - S01E04 - Ep Name
     %r{
     ^(?<series_name>.+?)[. _-]+                # Show_Name and separator
     s(?<season_num>\d+)[. _-]*                 # S01 and optional separator
     e(?<ep_num>\d+)                            # E02 and separator
     ([. _-]+s(?=season_num)[. _-]*             # S01 and optional separator
     e(?<extra_ep_num>\d+))+                    # E03/etc and separator
     [. _-]*((?<extra_info>.+?)                 # Source_Quality_Etc-
     ((?<![. _-])(?<!WEB)                        # Make sure this is really the release group
     -(?<release_group>[^- ]+([. _-]\[.*\])?))?)?$              # Group
     }ix,

    fov_repeat:
     # Show.Name.1x02.1x03.Source.Quality.Etc-Group
     # Show Name - 1x02 - 1x03 - 1x04 - Ep Name
     %r{
     ^(?<series_name>.+?)[. _-]+                # Show_Name and separator
     (?<season_num>\d+)x                        # 1x
     (?<ep_num>\d+)                             # 02 and separator
     ([. _-]+(?=season_num)x                    # 1x
     (?<extra_ep_num>\d+))+                     # 03/etc and separator
     [. _-]*((?<extra_info>.+?)                 # Source_Quality_Etc-
     ((?<![. _-])(?<!WEB)                        # Make sure this is really the release group
     -(?<release_group>[^- ]+([. _-]\[.*\])?))?)?$              # Group
     }ix,

    standard:
     # Show.Name.S01E02.Source.Quality.Etc-Group
     # Show Name - S01E02 - My Ep Name
     # Show.Name.S01.E03.My.Ep.Name
     # Show.Name.S01E02E03.Source.Quality.Etc-Group
     # Show Name - S01E02-03 - My Ep Name
     # Show.Name.S01.E02.E03
     %r{
     ^((?<series_name>.+?)[. _-]+)?             # Show_Name and separator
     (\()?s(?<season_num>\d+)[. _-]*            # S01 and optional separator
     e(?<ep_num>\d+)(\))?                       # E02 and separator
     (([. _-]*e|-)                               # linking e/- char
     (?<extra_ep_num>(?!(1080|720|480)[pi])\d+)(\))?)*   # additional E03/etc
     [. _-]*((?<extra_info>.+?)                 # Source_Quality_Etc-
     ((?<![. _-])(?<!WEB)                        # Make sure this is really the release group
     -(?<release_group>[^- ]+([. _-]\[.*\])?))?)?$              # Group
     }ix,

    fov:
     # Show_Name.1x02.Source_Quality_Etc-Group
     # Show Name - 1x02 - My Ep Name
     # Show_Name.1x02x03x04.Source_Quality_Etc-Group
     # Show Name - 1x02-03-04 - My Ep Name
     %r{
     ^((?<series_name>.+?)[\[. _-]+)?           # Show_Name and separator
     (?<season_num>\d+)x                        # 1x
     (?<ep_num>\d+)                             # 02 and separator
     (([. _-]*x|-)                               # linking x/- char
     (?<extra_ep_num>
     (?!(1080|720|480)[pi])(?!(?<=x)264)             # ignore obviously wrong multi-eps
     \d+))*                                      # additional x03/etc
     [\]. _-]*((?<extra_info>.+?)               # Source_Quality_Etc-
     ((?<![. _-])(?<!WEB)                        # Make sure this is really the release group
     -(?<release_group>[^- ]+([. _-]\[.*\])?))?)?$              # Group
     }ix,

    scene_date_format:
     # Show.Name.2010.11.23.Source.Quality.Etc-Group
     # Show Name - 2010-11-23 - Ep Name
     %r{
     ^((?<series_name>.+?)[. _-]+)?             # Show_Name and separator
     (?<air_date>(\d+[. _-]\d+[. _-]\d+)|(\d+\w+[. _-]\w+[. _-]\d+))
     [. _-]*((?<extra_info>.+?)                 # Source_Quality_Etc-
     ((?<![. _-])(?<!WEB)                        # Make sure this is really the release group
     -(?<release_group>[^- ]+([. _-]\[.*\])?))?)?$              # Group
     }ix,

    scene_sports_format:
     # Show.Name.100.Event.2010.11.23.Source.Quality.Etc-Group
     # Show.Name.2010.11.23.Source.Quality.Etc-Group
     # Show Name - 2010-11-23 - Ep Name
     %r{
     ^(?<series_name>.*?(UEFA|MLB|ESPN|WWE|MMA|UFC|TNA|EPL|NASCAR|NBA|NFL|NHL|NRL|PGA|SUPER LEAGUE|FORMULA|FIFA|NETBALL|MOTOGP).*?)[. _-]+
     ((?<series_num>\d{1,3})[. _-]+)?
     (?<air_date>(\d+[. _-]\d+[. _-]\d+)|(\d+\w+[. _-]\w+[. _-]\d+))[. _-]+
     ((?<extra_info>.+?)((?<![. _-])
     (?<!WEB)-(?<release_group>[^- ]+([. _-]\[.*\])?))?)?$
     }ix,

    stupid:
     # tpz-abc102
     %r{
     (?<release_group>.+?)-\w+?[\. ]?           # tpz-abc
     (?!264)                                     # don't count x264
     (?<season_num>\d{1,2})                     # 1
     (?<ep_num>\d{2})$                          # 02
     }ix,

    newpct:
     # Example: Sobrenatural - Temporada 10 [HDTV][Cap.1023][Espanol Castellano]
     %r{
     (?<series_name>.+?)                      # Showw_Name: "Sobrenatural"
     (?:.-.+\d{1,2}.\[)                        # Separator and junk: " - Temporada 10 ["
     (?<extra_info>.+)                        # Quality: "HDTV"
     (?:\]\[.+\.)                              # junk: "][Cap."
     (?<season_num>\d{1,2})                   # Season number: "10"
     (?<ep_num>\d{2})(?:])                    # Episode number: "23"
     }ix,

    verbose:
     # Show Name Season 1 Episode 2 Ep Name
     %r{
     ^(?<series_name>.+?)[. _-]+                # Show Name and separator
     season[. _-]+                               # season and separator
     (?<season_num>\d+)[. _-]+                  # 1
     episode[. _-]+                              # episode and separator
     (?<ep_num>\d+)[. _-]+                      # 02 and separator
     (?<extra_info>.+)$                         # Source_Quality_Etc-
     }ix,

    season_only:
     # Show.Name.S01.Source.Quality.Etc-Group
     %r{
     ^((?<series_name>.+?)[. _-]+)?             # Show_Name and separator
     s(eason[. _-])?                             # S01/Season 01
     (?<season_num>\d+)[. _-]*                  # S01 and optional separator
     [. _-]*((?<extra_info>.+?)                 # Source_Quality_Etc-
     ((?<![. _-])(?<!WEB)                        # Make sure this is really the release group
     -(?<release_group>[^- ]+([. _-]\[.*\])?))?)?$              # Group
     }ix,

    no_season_multi_ep:
     # Show.Name.E02-03
     # Show.Name.E02.2010
     %r{
     ^((?<series_name>.+?)[. _-]+)?             # Show_Name and separator
     (e(p(isode)?)?|part|pt)[. _-]?              # e, ep, episode, or part
     (?<ep_num>(\d+|(?<!e)[ivx]+))                    # first ep num
     ((([. _-]+(and|&|to)[. _-]+)|-)             # and/&/to joiner
     (?<extra_ep_num>(?!(1080|720|480)[pi])(\d+|(?<!e)[ivx]+))[. _-])            # second ep num
     ([. _-]*(?<extra_info>.+?)                 # Source_Quality_Etc-
     ((?<![. _-])(?<!WEB)                        # Make sure this is really the release group
     -(?<release_group>[^- ]+([. _-]\[.*\])?))?)?$              # Group
     }ix,

    no_season_general:
     # Show.Name.E23.Test
     # Show.Name.Part.3.Source.Quality.Etc-Group
     # Show.Name.Part.1.and.Part.2.Blah-Group
     %r{
     ^((?<series_name>.+?)[. _-]+)?             # Show_Name and separator
     (e(p(isode)?)?|part|pt)[. _-]?              # e, ep, episode, or part
     (?<ep_num>(\d+|((?<!e)[ivx]+(?=[. _-]))))                    # first ep num
     ([. _-]+((and|&|to)[. _-]+)?                # and/&/to joiner
     ((e(p(isode)?)?|part|pt)[. _-]?)           # e, ep, episode, or part
     (?<extra_ep_num>(?!(1080|720|480)[pi])
     (\d+|((?<!e)[ivx]+(?=[. _-]))))[. _-])*            # second ep num
     ([. _-]*(?<extra_info>.+?)                 # Source_Quality_Etc-
     ((?<![. _-])(?<!WEB)                        # Make sure this is really the release group
     -(?<release_group>[^- ]+([. _-]\[.*\])?))?)?$              # Group
     }ix,

    no_season:
     # Show Name - 01 - Ep Name
     # 01 - Ep Name
     # 01 - Ep Name
     %r{
     ^((?<series_name>.+?)(?:[. _-]{2,}|[. _]))?    # Show_Name and separator
     (?<ep_num>\d{1,3})                             # 02
     (?:-(?<extra_ep_num>\d{1,3}))*                 # -03-04-05 etc
     \s?of?\s?\d{1,3}?                               # of joiner (with or without spaces) and series total ep
     [. _-]+((?<extra_info>.+?)                     # Source_Quality_Etc-
     ((?<![. _-])(?<!WEB)                            # Make sure this is really the release group
     -(?<release_group>[^- ]+([. _-]\[.*\])?))?)?$  # Group
     }ix,

    bare:
     # Show.Name.102.Source.Quality.Etc-Group
     %r{
     ^(?<series_name>.+?)[. _-]+                # Show_Name and separator
     (?<season_num>\d{1,2})                     # 1
     (?<ep_num>\d{2})                           # 02 and separator
     ([. _-]+(?<extra_info>(?!\d{3}[. _-]+)[^-]+) # Source_Quality_Etc-
     (-(?<release_group>[^- ]+([. _-]\[.*\])?))?)?$                # Group
     }ix
   }

  ANIME_REGEXES = {
    anime_horriblesubs:
     # [HorribleSubs] Maria the Virgin Witch - 01 [720p].mkv
     %r{
     ^(?:\[(?<release_group>HorribleSubs)\][\s\.])
     (?:(?<series_name>.+?)[\s\.]-[\s\.])
     (?<ep_ab_num>((?!(1080|720|480)[pi]))\d{1,3})
     (-(?<extra_ab_ep_num>((?!(1080|720|480)[pi])|(?![hx].?264))\d{1,3}))?
     (?:v(?<version>[0-9]))?
     (?:[\w\.\s]*)
     (?:(?:(?:[\[\(])(?<extra_info>\d{3,4}[xp]?\d{0,4}[\.\w\s-]*)(?:[\]\)]))|(?:\d{3,4}[xp]))
     .*?
     }ix,
    anime_ultimate:
     %r{
     ^(?:\[(?<release_group>.+?)\][ ._-]*)
     (?<series_name>.+?)[ ._-]+
     (?<ep_ab_num>((?!(1080|720|480)[pi])|(?![hx].?264))\d{1,3})
     (-(?<extra_ab_ep_num>((?!(1080|720|480)[pi])|(?![hx].?264))\d{1,3}))?[ ._-]+?
     (?:v(?<version>[0-9]))?
     (?:[\w\.]*)
     (?:(?:(?:[\[\(])(?<extra_info>\d{3,4}[xp]?\d{0,4}[\.\w\s-]*)(?:[\]\)]))|(?:\d{3,4}[xp]))
     (?:[ ._]?\[(?<crc>\w+)\])?
     .*?
     }ix,

    anime_ISLAND:
     # [ISLAND]One_Piece_679_[VOSTFR]_[V1]_[8bit]_[720p]_[EB7838FC].mp4
     # [ISLAND]One_Piece_679_[VOSTFR]_[8bit]_[720p]_[EB7838FC].mp4
     %r{
     ^\[(?<release_group>ISLAND?)\]                                          # Release Group
     (?<series_name>.+?)[ ._-]+                                              # Show_Name and separator
     (?<ep_ab_num>\d{1,3})[ ._-]+                                            # Episode number
     (\[VOSTFR\])
     ([ ._-]+\[[vV](?<version>[0-9])\])*[ ._-]+                              # Version
     (\[(8bit|10bit)\])?[ ._-]+
     \[(?<extra_info>(\d{3,4}[xp]?\d{0,4})?[\.\w\s-]*)\][ ._-]+              # Extra info
     (\[(?<crc>\w{8})\])?                                                    # CRC
     .*?
     }ix,

    anime_kaerizaki_fansub:
     # [Kaerizaki-Fansub]_One_Piece_679_[VOSTFR][HD_1280x720].mp4
     # [Kaerizaki-Fansub]_One_Piece_681_[VOSTFR][HD_1280x720]_V2.mp4
     # [Kaerizaki-Fansub] High School DxD New 04 VOSTFR HD (1280x720) V2.mp4
     # [Kaerizaki-Fansub] One Piece 603 VOSTFR PS VITA (960x544) V2.mp4
     %r{
     ^\[(?<release_group>Kaerizaki-Fansub?)\][ ._-]*                         # Release Group and separator
     (?<series_name>.+?)[ ._-]+                                              # Show_Name and separator
     (?<ep_ab_num>((?!\[VOSTFR|VOSTFR))\d{1,3})                              # Episode number
     (-(?<extra_ab_ep_num>((?!\[VOSTFR|VOSTFR))\d{1,3}))?                    # Extra episode number
     ([ ._](\[VOSTFR\]|VOSTFR))?
     (\[|[ ._])?(?<extra_info>([SH]D_\d{3,4}ix,\d{3,4}|((SD|HD|PS\sVITA)[ ._]\(\d{3,4}ix,\d{3,4}\))))(\])?         # Extra info
     ([ ._][vV](?<version>[0-9]))?                                           # Version
     .*?                                                                      # Separator and EOL
     }ix,

    anime_standard:
     # [Group Name] Show Name.13-14
     # [Group Name] Show Name - 13-14
     # Show Name 13-14
     # [Group Name] Show Name.13
     # [Group Name] Show Name - 13
     # Show Name 13
     %r{
     ^(\[(?<release_group>.+?)\][ ._-]*)?                        # Release Group and separator
     (?<series_name>.+?)[ ._-]+                                 # Show_Name and separator
     (?<ep_ab_num>((?!(1080|720|480)[pi])|(?![hx].?264))\d{1,3})                                       # E01
     (-(?<extra_ab_ep_num>((?!(1080|720|480)[pi])|(?![hx].?264))\d{1,3}))?                             # E02
     (v(?<version>[0-9]))?                                       # version
     [ ._-]+\[(?<extra_info>\d{3,4}[xp]?\d{0,4}[\.\w\s-]*)\]       # Source_Quality_Etc-
     (\[(?<crc>\w{8})\])?                                        # CRC
     .*?                                                          # Separator and EOL
     }ix,

    anime_standard_round:
     # [Stratos-Subs]_Infinite_Stratos_-_12_(1280x720_H.264_AAC)_[379759DB]
     # [ShinBunBu-Subs] Bleach - 02-03 (CX 1280x720 x264 AAC)
     %r{
     ^(\[(?<release_group>.+?)\][ ._-]*)?                                    # Release Group and separator
     (?<series_name>.+?)[ ._-]+                                              # Show_Name and separator
     (?<ep_ab_num>((?!(1080|720|480)[pi])|(?![hx].?264))\d{1,3})                                                   # E01
     (-(?<extra_ab_ep_num>((?!(1080|720|480)[pi])|(?![hx].?264))\d{1,3}))?                                         # E02
     (v(?<version>[0-9]))?                                                   # version
     [ ._-]+\((?<extra_info>(CX[ ._-]?)?\d{3,4}[xp]?\d{0,4}[\.\w\s-]*)\)     # Source_Quality_Etc-
     (\[(?<crc>\w{8})\])?                                                    # CRC
     .*?                                                                      # Separator and EOL
     }ix,

    anime_slash:
     # [SGKK] Bleach 312v1 [720p/MKV]
     %r{
     ^(\[(?<release_group>.+?)\][ ._-]*)? # Release Group and separator
     (?<series_name>.+?)[ ._-]+           # Show_Name and separator
     (?<ep_ab_num>((?!(1080|720|480)[pi])|(?![hx].?264))\d{1,3})                # E01
     (-(?<extra_ab_ep_num>((?!(1080|720|480)[pi])|(?![hx].?264))\d{1,3}))?      # E02
     (v(?<version>[0-9]))?                # version
     [ ._-]+\[(?<extra_info>\d{3,4}p)     # Source_Quality_Etc-
     (\[(?<crc>\w{8})\])?                 # CRC
     .*?                                   # Separator and EOL
     }ix,

    anime_standard_codec:
     # [Ayako]_Infinite_Stratos_-_IS_-_07_[H264][720p][EB7838FC]
     # [Ayako] Infinite Stratos - IS - 07v2 [H264][720p][44419534]
     # [Ayako-Shikkaku] Oniichan no Koto Nanka Zenzen Suki Janain Dakara ne - 10 [LQ][h264][720p] [8853B21C]
     %r{
     ^(\[(?<release_group>.+?)\][ ._-]*)?                        # Release Group and separator
     (?<series_name>.+?)[ ._]*                                   # Show_Name and separator
     ([ ._-]+-[ ._-]+[A-Z]+[ ._-]+)?[ ._-]+                       # funny stuff, this is sooo nuts ! this will kick me in the butt one day
     (?<ep_ab_num>((?!(1080|720|480)[pi])|(?![hx].?264))\d{1,3})                                       # E01
     (-(?<extra_ab_ep_num>((?!(1080|720|480)[pi])|(?![hx].?264))\d{1,3}))?                             # E02
     (v(?<version>[0-9]))?                                       # version
     ([ ._-](\[\w{1,2}\])?\[[a-z][.]?\w{2,4}\])?                        #codec
     [ ._-]*\[(?<extra_info>(\d{3,4}[xp]?\d{0,4})?[\.\w\s-]*)\]    # Source_Quality_Etc-
     (\[(?<crc>\w{8})\])?
     .*?                                                          # Separator and EOL
     }ix,

    anime_codec_crc:
     %r{
    ^(?:\[(?<release_group>.*?)\][ ._-]*)?
    (?:(?<series_name>.*?)[ ._-]*)?
    (?:(?<ep_ab_num>(((?!(1080|720|480)[pi])|(?![hx].?264))\d{1,3}))[ ._-]*).+?
    (?:\[(?<codec>.*?)\][ ._-]*)
    (?:\[(?<crc>\w{8})\])?
    .*?
    }ix,

    anime_and_normal:
     # Bleach - s16e03-04 - 313-314
     # Bleach.s16e03-04.313-314
     # Bleach s16e03e04 313-314
     %r{
     ^(?<series_name>.+?)[ ._-]+                 # start of string and series name and non optinal separator
     [sS](?<season_num>\d+)[. _-]*               # S01 and optional separator
     [eE](?<ep_num>\d+)                          # epipisode E02
     (([. _-]*e|-)                                # linking e/- char
     (?<extra_ep_num>\d+))*                      # additional E03/etc
     ([ ._-]{2,}|[ ._]+)                          # if "-" is used to separate at least something else has to be there(->{2,}) "s16e03-04-313-314" would make sens any way
     ((?<ep_ab_num>((?!(1080|720|480)[pi])|(?![hx].?264))\d{1,3}))?                       # absolute number
     (-(?<extra_ab_ep_num>((?!(1080|720|480)[pi])|(?![hx].?264))\d{1,3}))?             # "-" as separator and anditional absolute number, all optinal
     (v(?<version>[0-9]))?                       # the version e.g. "v2"
     .*?
     }ix,

    anime_and_normal_x:
     # Bleach - s16e03-04 - 313-314
     # Bleach.s16e03-04.313-314
     # Bleach s16e03e04 313-314
     %r{
     ^(?<series_name>.+?)[ ._-]+                 # start of string and series name and non optinal separator
     (?<season_num>\d+)[. _-]*               # S01 and optional separator
     [xX](?<ep_num>\d+)                          # epipisode E02
     (([. _-]*e|-)                                # linking e/- char
     (?<extra_ep_num>\d+))*                      # additional E03/etc
     ([ ._-]{2,}|[ ._]+)                          # if "-" is used to separate at least something else has to be there(->{2,}) "s16e03-04-313-314" would make sens any way
     ((?<ep_ab_num>((?!(1080|720|480)[pi])|(?![hx].?264))\d{1,3}))?                       # absolute number
     (-(?<extra_ab_ep_num>((?!(1080|720|480)[pi])|(?![hx].?264))\d{1,3}))?             # "-" as separator and anditional absolute number, all optinal
     (v(?<version>[0-9]))?                       # the version e.g. "v2"
     .*?
     }ix,

    anime_and_normal_reverse:
     # Bleach - 313-314 - s16e03-04
     %r{
     ^(?<series_name>.+?)[ ._-]+                 # start of string and series name and non optinal separator
     (?<ep_ab_num>((?!(1080|720|480)[pi])|(?![hx].?264))\d{1,3})                       # absolute number
     (-(?<extra_ab_ep_num>((?!(1080|720|480)[pi])|(?![hx].?264))\d{1,3}))?             # "-" as separator and anditional absolute number, all optinal
     (v(?<version>[0-9]))?                       # the version e.g. "v2"
     ([ ._-]{2,}|[ ._]+)                          # if "-" is used to separate at least something else has to be there(->{2,}) "s16e03-04-313-314" would make sens any way
     [sS](?<season_num>\d+)[. _-]*               # S01 and optional separator
     [eE](?<ep_num>\d+)                          # epipisode E02
     (([. _-]*e|-)                                # linking e/- char
     (?<extra_ep_num>\d+))*                      # additional E03/etc
     .*?
     }ix,

    anime_and_normal_front:
     # 165.Naruto Shippuuden.s08e014
     %r{
     ^(?<ep_ab_num>((?!(1080|720|480)[pi])|(?![hx].?264))\d{1,3})                       # start of string and absolute number
     (-(?<extra_ab_ep_num>((?!(1080|720|480)[pi])|(?![hx].?264))\d{1,3}))?              # "-" as separator and anditional absolute number, all optinal
     (v(?<version>[0-9]))?[ ._-]+                 # the version e.g. "v2"
     (?<series_name>.+?)[ ._-]+
     [sS](?<season_num>\d+)[. _-]*                 # S01 and optional separator
     [eE](?<ep_num>\d+)
     (([. _-]*e|-)                               # linking e/- char
     (?<extra_ep_num>\d+))*                      # additional E03/etc
     .*?
     }ix,

    anime_ep_name:
     %r{
    ^(?:\[(?<release_group>.+?)\][ ._-]*)
    (?<series_name>.+?)[ ._-]+
    (?<ep_ab_num>((?!(1080|720|480)[pi])|(?![hx].?264))\d{1,3})
    (-(?<extra_ab_ep_num>((?!(1080|720|480)[pi])|(?![hx].?264))\d{1,3}))?[ ._-]*?
    (?:v(?<version>[0-9])[ ._-]+?)?
    (?:.+?[ ._-]+?)?
    \[(?<extra_info>\w+)\][ ._-]?
    (?:\[(?<crc>\w{8})\])?
    .*?
     }ix,

    anime_WarB3asT:
     # 003. Show Name - Ep Name.ext
     # 003-004. Show Name - Ep Name.ext
     %r{
     ^(?<ep_ab_num>\d{3,4})(-(?<extra_ab_ep_num>\d{3,4}))?\.\s+(?<series_name>.+?)\s-\s.*
     }ix,

    anime_bare:
     # One Piece - 102
     # [ACX]_Wolf's_Spirit_001.mkv
     %r{
     ^(\[(?<release_group>.+?)\][ ._-]*)?
     (?<series_name>.+?)[ ._-]+                         # Show_Name and separator
     (?<ep_ab_num>((?!(1080|720|480)[pi])|(?![hx].?264))\d{1,3})                                      # E01
     (-(?<extra_ab_ep_num>((?!(1080|720|480)[pi])|(?![hx].?264))\d{1,3}))?                            # E02
     (v(?<version>[0-9]))?                                     # v2
     .*?                                                         # Separator and EOL
     }ix
  }
end