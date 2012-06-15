class ApplicationController

  # GET /
  @index = (req, res) ->
    res.render 'index',
      view: 'index'

  # GET /voice-callback/
  @voiceCallback = (req, res) ->
    res.redirect '/'

  # GET /sms-callback/
  @smsCallback = (req, res) ->
    res.redirect '/'


# Exports
global.ApplicationController = ApplicationController
