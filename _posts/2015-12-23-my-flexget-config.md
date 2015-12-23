



```yaml

#Make sure to run as --discover-now --no-cache
secrets: secrets.yml
templates:
  global:
    free_space:
      path: /home
      space: 50000
    # Make sure all filenames are Windows safe (for samba)
    pathscrub: linux
    torrent_scrub: rtorrent
    torrent_alive: yes #number of seeders needed to accept
    retry_failed:
      retry_time: 5 minutes # Base time in between retries
      retry_time_multiplier: 1 # Amount retry time will be multiplied by after each successive failure
      max_retries: 15 # Number of times the entry will be retried
    domain_delay:
      www.torrentleech.org: 10 seconds
      rss.torrentleech.org: 10 minutes
      bt-chat.com: 5 seconds
      torrentz.eu: 10 seconds
    verify_ssl_certificates: no
    parsing:
      movie: guessit
      series: guessit
  
  rtorrent_download:
    rtorrent:
      uri: scgi://localhost:5000
      
      path: '/media/rt/staging/'

  download-movie:
    verify_ssl_certificates: no
    discover:
      what:
        - emit_movie_queue: yes
      from:
#        - torrentz: verified
        - piratebay: yes
#        - publichd: 
#            category:
#              - BluRay 720p
#              - BluRay 1080p
        - isohunt: movies
#        - rarbg: 
#            category:
#              - x264 720p
#              - x264 1080p
        - kat:
            category: movies
            verified: yes
      limit: 20
    movie_queue: accept
    set:
      content_filename: "{{ imdb_name|replace('/', '_')|replace(':', ' -') }} ({{ imdb_year }}) - {{ quality }}"
#    template: rtorrent_download
    download: /media/rt/watchfolder
web_server:
  bind: 0.0.0.0
  port: 5050
api: yes
webui: yes

tasks:
  fill_movie_queue:
    priority: 2
    trakt_list:
      username: '{{ secrets.trakt.usr }}'
#      password: '{{ secrets.trakt.pwd }}'
      list: watchlist
      #strip_dates: yes
      type: movies
    accept_all: yes
    movie_queue: add

  #Last resort if movie can't be found
  get_movies_720p:
    priority: 3
    content_size:
      max: 5360
      min: 724
    exists_movie:
      - /media/rt/media/Movies/
    #assume_quality: 720p bluray #in case of REALLY long titles
    quality: 480p-720p bluray+
    movie_queue: accept
    template: download-movie
    pushbullet:
      apikey: '{{ secrets.pushbullet.api }}'
#      device: '{{ secrets.pushbullet.device }}'
      title: "[Flexget] {{task}}"
      body: "{{ imdb_name }} ({{ imdb_year }})\n{{ quality }}"
      url: "{% if imdb_url %}{{ imdb_url }}{% endif %}"
    # This is a custom plugin, it is part of my rar-unpacking method, it changes
    # 'movedone' based on the regexp in the key

  get_series:
    priority: 4
    content_size:
      max: 2072
      min: 60
    exists_series:
      - "/media/rt/media/TV Shows"
    regexp:
      reject:
        - FASTSUB #French
        - VOSTFR #French
        - Subtitulado #Spanish
        - Special-Wicked #Special trailer episodes from Once Upon a Time
        - Magazine #No magazines on Arrow, thank you.
        - NLsubs
    content_filter:
      reject:
        - '*.avi' #Uhgg Jak!
    verify_ssl_certificates: no
    discover:
      what:
        - emit_series: yes
 
      from:
#        - torrentz: verified
        - piratebay: yes
#        - publichd: 
#            category:
#              - HDTV
        - isohunt: tv
#        - rarbg: 
#            category:
#              - HDTV
        - kat:
            category: tv
            verified: yes
      limit: 20
    configure_series:
      from:
        trakt_list:
          username: '{{ secrets.trakt.usr }}'
#          password: '{{ secrets.trakt.pwd }}'
          list: watchlist
          type: shows
#        listdir:
#          - /volume1/Disk1/Library/TV Shows
      settings:
        quality: 480p-720p <=hdtv
        identified_by: ep
        exact: yes
    set:
      content_filename: "{{ series_name }} - {{ series_id }} ({{ quality|upper }})"
#    template: rtorrent_download
    download: /media/rt/watchfolder
    pushbullet:
      apikey: '{{ secrets.pushbullet.api }}'
#      device: '{{ secrets.pushbullet.device }}'
      title: "[Flexget] {{task}}"
      body: "{{ tvdb_series_name|default(series_name) }} - {{ series_id }}{% if tvdb_ep_name|default(False) %} - {{ tvdb_ep_name }}{% endif %}\n{{ quality }}"
      url: "{% if trakt_series_url is defined and trakt_season is defined and trakt_episode is defined %}{{ trakt_series_url }}/season/{{ trakt_season }}/episode/{{ trakt_episode }}{% endif %}"
  get_series_stripyear:
    manual: yes
    priority: 5
    content_size:
      max: 3072
      min: 60
    exists_series:
      - "/media/rt/media/TV Shows"
    regexp:
      reject:
        - FASTSUB #French
        - VOSTFR #French
        - Subtitulado #Spanish
        - Special-Wicked #Special trailer episodes from Once Upon a Time
        - Magazine #No magazines on Arrow, thank you.
        - NLsubs
    content_filter:
      reject:
        - '*.avi' #Uhgg Jak!
    verify_ssl_certificates: no
    discover:
      what:
        - emit_series:
            from_start: yes
            backfill: yes
      from:
#        - torrentz: verified
        - piratebay: yes
#        - publichd: 
#            category:
#              - HDTV
        - isohunt: tv
#        - rarbg: 
#            category:
#              - HDTV
        - kat:
            category: tv
            verified: yes
      limit: 20
    configure_series:
      from:
        trakt_list:
          username: '{{ secrets.trakt.usr }}'
#          password: '{{ secrets.trakt.pwd }}'
          list: full_show
          type: shows
          strip_dates: yes
#        listdir:
#          - /volume1/Disk1/Library/TV Shows
      settings:
#        quality: any
        identified_by: ep
        exact: yes
    set:
      content_filename: "{{ series_name }} - {{ series_id }} ({{ quality|upper }})"
#    template: rtorrent_download
    download: /media/rt/watchfolder
  seed_series_db:
    # The filesystem plugin will find all of your existing episodes
    filesystem:
      regexp: .*(avi|mkv|mp4)$
      path: "/media/rt/media/TV Shows"
      recursive: yes
#    template: tv
    configure_series:
      from:
        trakt_list:
          username: '{{ secrets.trakt.usr }}'
#          password: '{{ secrets.trakt.pwd }}'
          list: watchlist
          type: shows
#        listdir:
#          - /volume1/Disk1/Library/TV Shows
      settings:
#        quality: 480p-720p <=hdtv
        identified_by: ep
        exact: yes
    # We use the manual plugin so that this task only runs when explicitly called
    manual: yes

  clean_movie_queue:
    template: no_global # None of the global templates make sense here
    priority: 1  
    disable:
      - seen_movies
      - seen 
      - seen_info_hash
    accept_all: yes
    parsing:
      movie: guessit
    filesystem:
      regexp: .*(avi|mkv|mp4)$
      path: /media/rt/media/Movies/
      recursive: true
    tmdb_lookup: yes 
    trakt_lookup: yes
    imdb_lookup: yes
    # Rotten Tomatoes is broken, possibly forever :(
    #rottentomatoes_lookup: yes
    require_field: [movie_name, movie_year]
#    movie_queue: remove
    trakt_remove:
      username: '{{ secrets.trakt.usr }}'
#      password: '{{ secrets.trakt.pwd }}'

      list: watchlist



```
