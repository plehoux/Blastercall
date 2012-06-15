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
        global.socket?.emit 'voice',
          type   : type
          params : req.query
        res.render 'twilio_response', 
          layout : false
          verb   : 'Gather'
          nouns  : 
            action : "#{req.header('Host')}/#{type}/#{if type is 'enemy' then 'drop' else 'move'}"
      else
        switch type
          when 'enemy'
            console.log 'enemy-drop'  if action is 'drop'
          when 'player'
            console.log 'player-move' if action is 'move'

# Exports
global.ApplicationController = ApplicationController
