socket = io.connect "http://#{window.location.host}"
socket.on 'voice', (data) ->
  console.log "voice: #{data}"

socket.on 'sms', (data) ->
  console.log "sms: #{data.type}"
