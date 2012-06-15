socket = io.connect "http://#{window.location.host}"
socket.on 'voice', (data) ->
  console.log "#{key}: #{value}" for key,value of data

socket.on 'sms', (data) ->
  console.log "sms: #{data.type}"
