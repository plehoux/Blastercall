#= require_tree ./utils
#= require ./game/game

socket = io.connect "http://#{window.location.host}"
socket.on 'action', (data) ->
  console.log "#{data.type}:#{data.action}"
