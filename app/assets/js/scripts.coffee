socket = io.connect "http://#{window.location.host}"
socket.on 'action', (data) ->
  console.log "#{key}: #{value}" for key,value of data.params
