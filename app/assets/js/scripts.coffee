window.enemies = {}
socket = io.connect "http://#{window.location.host}"
socket.on 'action', (data) ->
  action  = data.action
  params  = data.params
  enemies = window.enemies
  switch action
    when 'connect'
      console.log "#{params.From} just connected!"
      enemies[params.CallSid] = 
        from : params.From
        x    : 1
        y    : 1
    when 'disconnect'
      console.log "#{params.From} just disconnected!"
      delete enemies[params.CallSid]
    when 'move'
      enemies[params.CallSid].x++
      enemies[params.CallSid].y++
      console.log enemies[params.CallSid].x
#= require_tree ./utils
#= require ./game/game