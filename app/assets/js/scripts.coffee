#= require_tree ./utils
#= require ./game/game

socket = io.connect "http://#{window.location.host}"
socket.on 'action', (data) ->
  console.log "action"
  console.log("#{key}-#{value}") for key,value in data.params
