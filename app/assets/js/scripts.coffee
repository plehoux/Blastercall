window.enemies = {}
socket = io.connect "http://#{window.location.host}"
socket.on 'action', (data) ->
  action  = data.action
  params  = data.params
  enemies = window.enemies
  switch action
    when 'connect'
      console.log "#{params.From} just connected!"
      enemies[params.From] = 1
    when 'disconnect'
      console.log "#{params.From} just disconnected!"
      delete enemies[params.From]
    when 'move'
      enemies[params.From]++

#= require_tree ./utils
#= require ./game/game