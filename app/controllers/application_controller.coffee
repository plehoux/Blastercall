class ApplicationController

  # GET /
  @index = (req, res) ->
    res.render 'index',
      view: 'index'

  # GET /voice-callback/:type
  @voice_callback = (req, res) ->
    console.log "TARBARNAK"
    console.log "#{req.params}"
    console.log "#{key} : #{value}" for key,value of req.query 
    global.socket.emit 'voice', type: "enemy"

  # GET /sms-callback/:type
  @sms_callback = (req, res) ->
    global.socket.emit 'sms', type: req.params.type


# Exports
global.ApplicationController = ApplicationController
