---
layout: post
title: My flexget config file
comments: true
---

```YAML
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
```
```YAML
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
```
#The full config file is below.
[Flexget config.yml](/files/config.yml)
