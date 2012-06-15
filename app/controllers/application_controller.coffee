class ApplicationController

  # GET /
  @index = (req, res) ->
    res.render 'index',
      view: 'index'

  # GET /callback/:type
  @callback = (req, res) ->
    res.contentType('text/xml')
    if req.query.ApplicationSid is 'AP581d3685e6ae1ee2f8584fb991b69aa0'
      action = req.params.action
      type   = req.params.type
      if action is 'connect'
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
            action    : "#{req.header('Host')}/#{type}/#{if type is 'enemy' then 'drop' else 'move'}"
      else
        switch type
          when 'enemy'
            if action is 'drop'
              global.socket?.emit 'action',
                type   : type
                action : action
                params : req.query
          when 'player'
            console.log 'player-move' if action is 'move'

# Exports
global.ApplicationController = ApplicationController
