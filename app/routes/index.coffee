app = global.app

# Game
app.get '/', ApplicationController.index
app.get '/voice-callback', ApplicationController.voiceCallback
app.get '/sms-callback', ApplicationController.smsCallback

# Error handling (No previous route found. Assuming it’s a 404)
app.get '/*', (req, res) ->
  NotFound res

global.NotFound = (res) ->
  res.render '404', status: 404, view: 'four-o-four'
