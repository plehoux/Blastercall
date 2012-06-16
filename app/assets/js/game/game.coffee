window.enemies = {}

class Game
  constructor: ->
    @game = $('#game')
    @enemies = {}
    @listen()
    @addPlayer()
    @tick()

  addPlayer: ->
    @player = new Player
    @game.append @player.elem

  addEnemy: (id,from)->
    console.log "#{from} just connected!"
    @enemies[id] = new Enemy(from)
    @game.append @enemies[id].elem

  deleteEnemy: (id)->
    console.log "#{@enemies[id].from} just disconnected!"
    delete @enemies[id]

  moveEnemy: (id,moveTo)->
    @enemies[id].moveTo = moveTo
    console.log "#{@enemies[id].from} move to #{@enemies[id].moveTo}!"

  tick: =>
    @player.tick()
    enemy.tick() for id,enemy of @enemies
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
