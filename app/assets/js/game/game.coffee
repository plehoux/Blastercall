class Game

  constructor: ->
    @game = $('#game')
    @listen()
    @addPlayer()
    @tick()

  # Player management
  addPlayer: ->
    @player = new Player
    @game.append @player.elem

  # Render management
  tick: =>
    @player.tick()
    requestAnimationFrame(this.tick)

  listen:->
    socket = io.connect "http://#{window.location.host}"
    socket.on 'action', (data) ->
      action  = data.action
      params  = data.params
      enemies = window.enemies
      switch action
        when 'connect'
          console.log "#{params.From} just connected!"
          enemies[params.CallSid] = 
            from   : params.From
            x      : 0
            y      : 0
            moveTo : null
        when 'disconnect'
          console.log "#{params.From} just disconnected!"
          delete enemies[params.CallSid]
        when 'move'
          enemies[params.CallSid].moveTo = params.Digits
          console.log enemies[params.CallSid].moveTo


new Game
