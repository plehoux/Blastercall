window.enemies = {}

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

  addEnemy: (id,from)->
    console.log "#{from} just connected!"
    enemies[id] = new Enemy(from)

  deleteEnemy: (id)->
    console.log "#{enemies[id].from} just disconnected!"
    delete enemies[id]

  moveEnemy: (id,moveTo)->
    enemies[id].moveTo = moveTo
    console.log "#{enemies[id].from} move to #{enemies[id].moveTo}!"

  # Render management
  tick: =>
    @player.tick()
    #enemy.tick() for enemy in @enemies
    requestAnimationFrame(@tick)

  listen:->
    socket = io.connect "http://#{window.location.host}"
    socket.on 'action', (data) =>
      action  = data.action
      params  = data.params
      enemies = window.enemies
      switch action
        when 'connect'
          @addEnemy(params.CallSid,params.From)
        when 'disconnect'
          @deleteEnemy(params.CallSid)
        when 'move'
          @moveEnemy(params.CallSid,params.Digits)

new Game
