class ApplicationController

  # GET /
  @index = (req, res) ->
    res.render 'index',
      view: 'index'

  # GET /voice-callback/:type
  @voice_callback = (req, res) ->
    console.log "TARBARNAK"
    console.log(param) for param of req.params
    global.socket.emit 'voice', type: req.params

  # GET /sms-callback/:type
  @sms_callback = (req, res) ->
    global.socket.emit 'sms', type: req.params.type


# Exports
global.ApplicationController = ApplicationController
