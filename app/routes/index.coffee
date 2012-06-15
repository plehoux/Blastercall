app = global.app

# Game
app.get '/', ApplicationController.index
app.get '/voice-callback/:type', ApplicationController.voice_callback
app.get '/sms-callback/:type', ApplicationController.sms_callback

# Error handling (No previous route found. Assuming it’s a 404)
app.get '/*', (req, res) ->
  NotFound res

global.NotFound = (res) ->
  res.render '404', status: 404, view: 'four-o-four'
