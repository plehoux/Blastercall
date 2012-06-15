class ApplicationController

  # GET /
  @index = (req, res) ->
    res.render 'index',
      view: 'index'

  # GET /voice-callback/:type
  @voice_callback = (req, res) ->
    if req.query.ApplicationSid == 'AP581d3685e6ae1ee2f8584fb991b69aa0'
      global.socket?.emit 'voice', {type: req.params.type, params: req.query}
      res.contentType('text/xml')
      res.render 'twilio_response', 
        layout : false
        verb   : 'Say'
        nouns  : 'Hello world!'
  



  # GET /sms-callback/:type
  @sms_callback = (req, res) ->
    global.socket.emit 'sms', type: req.params.type


# Exports
global.ApplicationController = ApplicationController
