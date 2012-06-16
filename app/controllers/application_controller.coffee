class ApplicationController

  # GET /
  @index = (req, res) ->
    res.render 'index',
      view: 'index'

  # GET /callback/:type
  @callback = (req, res) =>
    res.contentType('text/xml')
    if req.query.ApplicationSid is 'AP581d3685e6ae1ee2f8584fb991b69aa0'
      action = req.params.action
      type   = req.params.type
      global.socket?.emit 'action',
            type   : type
            action : action
            params : req.query
          res.render 'twilio_response', 
            layout : false
            verb   : 'Gather'
            nouns  : 
              numDigits : 1
              timeout   : 3600
              action    : "/#{type}/move"

# Exports
global.ApplicationController = ApplicationController